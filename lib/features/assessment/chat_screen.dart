import 'package:aging_in_place/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'assessment_controller.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String seniorId;
  const ChatScreen({super.key, required this.seniorId});

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
    final response = await ref.read(assessmentControllerProvider(widget.seniorId).notifier).parseMessage(text);

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
      await ref.read(assessmentControllerProvider(widget.seniorId).notifier).saveCurrentAssessment();
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
    final assessmentAsync = ref.watch(assessmentControllerProvider(widget.seniorId));
    
    // Auto-Greeting Logic
    ref.listen(assessmentControllerProvider(widget.seniorId), (previous, next) {
       if (next.hasValue && _messages.isEmpty && !_initialized) {
          final controller = ref.read(assessmentControllerProvider(widget.seniorId).notifier);
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
      backgroundColor: const Color(0xFFFDFCFB), // Soft Warm Sand background
      appBar: AppBar(
        title: const Text('Observation Chat'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        actions: [
          // Live Score Indicator
          assessmentAsync.when(
            data: (data) {
              final currentScore = data.calculatedResults.scoreFinalAip;
              final color = _getScoreColor(currentScore);
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color.withOpacity(0.3), width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      currentScore.toInt().toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: color,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const Icon(Icons.error, color: Colors.red),
          ),
          IconButton(
            icon: const Icon(Icons.check_circle_outline, color: Color(0xFF1A1F1E)),
            tooltip: 'Save & Finish',
            onPressed: assessmentAsync.hasValue ? _saveAndFinish : null,
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Color(0xFF1A1F1E)),
            onSelected: (value) {
              if (value == 'logout') {
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
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'logout', child: Text('Logout')),
            ],
          ),
        ],
      ),
      body: assessmentAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF6B8E8E))),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (assessment) {
          return Column(
            children: [
              Expanded(
                child: _messages.isEmpty 
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFF6B8E8E))) 
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final msg = _messages[index];
                        final isUser = msg['role'] == 'user';
                        return Align(
                          alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                            decoration: BoxDecoration(
                              color: isUser ? const Color(0xFF1A1F1E) : Colors.white,
                              borderRadius: BorderRadius.circular(24).copyWith(
                                bottomRight: isUser ? const Radius.circular(4) : const Radius.circular(24),
                                bottomLeft: !isUser ? const Radius.circular(4) : const Radius.circular(24),
                              ),
                              boxShadow: isUser ? [] : [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                )
                              ],
                            ),
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                            child: Text(
                              msg['text']!,
                              style: TextStyle(
                                color: isUser ? Colors.white : const Color(0xFF1A1F1E),
                                fontSize: 15,
                                height: 1.4,
                                fontWeight: isUser ? FontWeight.w500 : FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
              ),
              if (_isTyping)
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                   child: Row(
                     children: [
                       SizedBox(
                         width: 40,
                         child: LinearProgressIndicator(
                           backgroundColor: const Color(0xFF6B8E8E).withOpacity(0.1),
                           color: const Color(0xFF6B8E8E),
                           minHeight: 2,
                         ),
                       ),
                       const SizedBox(width: 8),
                       const Text('Analyzing...', style: TextStyle(fontSize: 12, color: Color(0xFF5A6361))),
                     ],
                   ),
                 ),

              Container(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, -8),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9F9),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: TextField(
                          controller: _textController,
                          minLines: 1,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText: 'Share an observation...',
                            hintStyle: TextStyle(color: Color(0xFF5A6361), fontSize: 15),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: _sendMessage,
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: const BoxDecoration(
                          color: Color(0xFF1A1F1E),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_upward, color: Colors.white, size: 24),
                      ),
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
