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

  void _sendMessage() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    // 1. Add User Message
    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _isTyping = true;
      _textController.clear();
    });

    // 2. Call Controller (Simulate AI)
    await ref.read(assessmentControllerProvider.notifier).parseMessage(text);

    // 3. Add AI Response
    if (mounted) {
      setState(() {
        _isTyping = false;
        _messages.add({
          'role': 'ai',
          'text': 'I updated the assessment based on your input.'
        });
      });
    }
  }

  void _saveAndFinish() async {
    await ref.read(assessmentControllerProvider.notifier).saveCurrentAssessment();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Assessment Saved!')),
      );
      context.pop(); // Return to Dashboard
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the live score
    final assessmentState = ref.watch(assessmentControllerProvider);
    final currentScore = assessmentState.calculatedResults.scoreFinalAip;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assessment Chat'),
        actions: [
          // Live Score Indicator
          Container(
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
          ),
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Save & Finish',
            onPressed: _saveAndFinish,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              // Optional: Confirm dialog before logout since data might be lost
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
      body: Column(
        children: [
          // Chat List
          Expanded(
            child: ListView.builder(
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

          // Input Area
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
                    decoration: const InputDecoration(
                      hintText: 'Describe the situation...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _sendMessage(),
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
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }
}
