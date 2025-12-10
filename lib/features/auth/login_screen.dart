import 'package:aging_in_place/core/constants/legal_text.dart';
import 'package:aging_in_place/features/auth/widgets/score_explainer_sheet.dart';
import 'package:aging_in_place/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _inviteCodeController = TextEditingController();

  bool _isLoading = false;
  bool _isSignUpMode = false; // Toggle between Login and Sign Up
  bool _agreedToTerms = false; // Checkbox state

  // Hardcoded for MVP as per requirements
  static const String _validInviteCode = "ALBERT2025";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _inviteCodeController.dispose();
    super.dispose();
  }

  void _toggleMode() {
    setState(() {
      _isSignUpMode = !_isSignUpMode;
      // Reset sensitive fields when switching modes
      _inviteCodeController.clear();
      _agreedToTerms = false;
    });
  }

  Future<void> _submit() async {
    setState(() => _isLoading = true);

    try {
      if (_isSignUpMode) {
        // --- SIGN UP LOGIC ---
        
        // 1. Validate Invite Code
        if (_inviteCodeController.text.trim().toUpperCase() != _validInviteCode) {
          throw Exception("Invalid Invitation Code.");
        }

        // 2. Validate Terms
        if (!_agreedToTerms) {
          throw Exception("You must agree to the Terms of Service & Privacy Policy.");
        }

        // 3. Create Account
        await ref.read(authServiceProvider).signUp(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            );
      } else {
        // --- SIGN IN LOGIC ---
        await ref.read(authServiceProvider).signIn(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            );
      }
      // Success is handled by auth state changes in main.dart
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showLegalText() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Terms & Privacy"),
        content: SingleChildScrollView(
          child: Text(termsOfServiceText),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. The Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'PROPRIETARY TECHNOLOGY',
                    style: TextStyle(
                      color: Colors.deepOrange.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // 2. The Hero Title
                Text(
                  'Aging In Place Score™',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Colors.blueGrey.shade900,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 16),

                // 3. The Subtitle
                Text(
                  'A simple number that tells a life-changing story.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.blueGrey.shade700,
                  ),
                ),
                const SizedBox(height: 24),

                // 4. The Description
                Text(
                  "ALBERTai's proprietary Aging In Place Score™ is the first assessment that blends health, behavior, cognitive signals, and safety data into one easy-to-understand score.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey.shade600,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),

                // 5. The Form
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                  ),
                  obscureText: true,
                ),
                
                // --- Extra Fields for Sign Up Mode ---
                if (_isSignUpMode) ...[
                  const SizedBox(height: 16),
                  TextField(
                    controller: _inviteCodeController,
                    decoration: InputDecoration(
                      labelText: 'Invitation Code',
                      hintText: 'Enter your exclusive code',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: _agreedToTerms,
                          onChanged: (val) => setState(() => _agreedToTerms = val ?? false),
                          activeColor: Colors.blueGrey.shade900,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.blueGrey.shade600, fontSize: 13),
                            children: [
                              const TextSpan(text: "I agree to the "),
                              TextSpan(
                                text: "Terms of Service & Privacy Policy",
                                style: TextStyle(
                                  color: Colors.blueGrey.shade900,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()..onTap = _showLegalText,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                
                const SizedBox(height: 24),

                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey.shade900,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          _isSignUpMode ? 'Create Account' : 'Sign In',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: _toggleMode,
                        style: TextButton.styleFrom(
                           foregroundColor: Colors.blueGrey.shade700,
                        ),
                        child: Text(_isSignUpMode 
                          ? 'Already have an account? Sign In' 
                          : 'Don\'t have an account? Create one'
                        ),
                      ),
                    ],
                  ),
                
                const SizedBox(height: 32),
                
                // 6. Explainer Link
                TextButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => const ScoreExplainerSheet(),
                    );
                  },
                  icon: Icon(Icons.info_outline, color: Colors.blueGrey.shade400, size: 20),
                  label: Text(
                    'How is the AIP Score Calculated?',
                    style: TextStyle(color: Colors.blueGrey.shade400, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
