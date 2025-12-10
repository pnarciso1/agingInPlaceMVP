import 'package:aging_in_place/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'assessment_controller.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, String>> _messages = []; // {role: user/ai, text: ...}
  bool _isTyping = false;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    // We defer the initial check to the build/listener phase or run it once post-frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
        _checkInitialState();
    });
  }

  void _checkInitialState() async {
     // Wait for controller to initialize
     // We can't easily wait for the async build here without a listener, 
     // but we can check if the provider has value in the build method.
     // Instead, let's trigger a "hello" if the list is empty and state is askingName.
  }

  void _sendMessage() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    // 1. Add User Message
    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _isTyping = true;
      _textController.clear();
    });

    // 2. Call Controller
    // Note: We changed parseMessage to return a String response
    final response = await ref.read(assessmentControllerProvider.notifier).parseMessage(text);

    // 3. Add AI Response
    if (mounted) {
      setState(() {
        _isTyping = false;
        _messages.add({
          'role': 'ai',
          'text': response
        });
      });
    }
  }

  void _saveAndFinish() async {
    try {
      await ref.read(assessmentControllerProvider.notifier).saveCurrentAssessment();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Assessment Saved!')),
        );
        context.pop(); // Return to Dashboard
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final assessmentAsync = ref.watch(assessmentControllerProvider);
    
    // Auto-Greeting Logic
    ref.listen(assessmentControllerProvider, (previous, next) {
       if (next.hasValue && _messages.isEmpty && !_initialized) {
          final controller = ref.read(assessmentControllerProvider.notifier);
          if (controller.currentStep == AssessmentStep.askingName) {
             setState(() {
               _messages.add({
                 'role': 'ai', 
                 'text': 'Hello! To get started, what is the name of the person you are caring for?'
               });
               _initialized = true;
             });
          } else if (controller.currentStep == AssessmentStep.activeAssessment) {
              // If resuming an existing senior context
              final name = next.value!.metadata.subjectName ?? "the senior";
              setState(() {
               _messages.add({
                 'role': 'ai', 
                 'text': 'Welcome back. What updates do you have for $name today?'
               });
               _initialized = true;
             });
          }
       }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessment Chat'),
        actions: [
          // Live Score Indicator
          assessmentAsync.when(
            data: (data) {
              final currentScore = data.calculatedResults.scoreFinalAip;
              return Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getScoreColor(currentScore).withOpacity(0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: _getScoreColor(currentScore), width: 2),
                ),
                child: Text(
                  currentScore.toInt().toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _getScoreColor(currentScore),
                  ),
                ),
              );
            },
            loading: () => const Padding(
              padding: EdgeInsets.only(right: 16),
              child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)),
            ),
            error: (_, __) => const Icon(Icons.error, color: Colors.red),
          ),
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Save & Finish',
            onPressed: assessmentAsync.hasValue ? _saveAndFinish : null,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Logout?'),
                  content: const Text('Any unsaved progress will be lost.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        ref.read(authServiceProvider).signOut();
                      },
                      child: const Text('Logout', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: assessmentAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (assessment) {
          return Column(
            children: [
              Expanded(
                child: _messages.isEmpty 
                  ? const Center(child: CircularProgressIndicator()) // Waiting for auto-greeting
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        final isUser = msg['role'] == 'user';
                        return Align(
                          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isUser ? Colors.teal : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(16).copyWith(
                                bottomRight: isUser ? Radius.zero : const Radius.circular(16),
                                bottomLeft: !isUser ? Radius.zero : const Radius.circular(16),
                              ),
                            ),
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                            child: Text(
                              msg['text']!,
                              style: TextStyle(
                                color: isUser ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
              ),
              if (_isTyping)
                 const Padding(
                   padding: EdgeInsets.all(8.0),
                   child: LinearProgressIndicator(),
                 ),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        minLines: 1, // Start small
                        maxLines: 5, // Expand to 5 lines
                        decoration: const InputDecoration(
                          hintText: 'Type message...',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        // Note: onSubmitted only works for single-line fields usually.
                        // We rely on the button for multi-line submission.
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      onPressed: _sendMessage,
                      icon: const Icon(Icons.send),
                      color: Colors.teal,
                    )
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }
}
