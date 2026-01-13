import 'package:aging_in_place/core/constants/legal_text.dart';
import 'package:aging_in_place/features/auth/widgets/score_explainer_sheet.dart';
import 'package:aging_in_place/services/firestore_service.dart';
import 'package:aging_in_place/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isSignUpMode = false; // Toggle between Login and Sign Up
  bool _agreedToTerms = false; // Checkbox state

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleMode() {
    setState(() {
      _isSignUpMode = !_isSignUpMode;
      _agreedToTerms = false;
    });
  }

  Future<void> _submit() async {
    setState(() => _isLoading = true);

    try {
      if (_isSignUpMode) {
        // --- SIGN UP LOGIC ---
        
        // 1. Validate Terms
        if (!_agreedToTerms) {
          throw Exception("You must agree to the Terms of Service & Privacy Policy.");
        }

        // 2. Create Account
        await ref.read(authServiceProvider).signUp(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            );
        
        final user = ref.read(authServiceProvider).currentUser;
        if (user != null) {
          await ref.read(firestoreServiceProvider).ensureUserProfile(user.uid, user.email!);
        }
      } else {
        // --- SIGN IN LOGIC ---
        await ref.read(authServiceProvider).signIn(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            );
        
        final user = ref.read(authServiceProvider).currentUser;
        if (user != null) {
          await ref.read(firestoreServiceProvider).ensureUserProfile(user.uid, user.email!);
        }
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFCFB), // Soft Warm Sand background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 1. The Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F3F1), // Sage Mint Light
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const Text(
                      'PROPRIETARY TECHNOLOGY',
                      style: TextStyle(
                        color: Color(0xFF4A6761), // Sage Deep
                        fontWeight: FontWeight.w800,
                        fontSize: 10,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 2. The Hero Title
                  Text(
                    'Aging In Place\nScore™',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF1A1F1E), // Deep Slate
                      height: 1.0,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 3. The Subtitle
                  Text(
                    'A simple number that tells a life-changing story.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF5A6361), // Muted Sage
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // 4. The Form Card
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1A1F1E).withOpacity(0.06),
                          blurRadius: 40,
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          _isSignUpMode ? 'Create Account' : 'Welcome Back',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1A1F1E),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 28),
                        
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(color: Color(0xFF5A6361), fontSize: 14),
                            filled: true,
                            fillColor: const Color(0xFFF8F9F9),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Color(0xFF5A6361), fontSize: 14),
                            filled: true,
                            fillColor: const Color(0xFFF8F9F9),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                          ),
                          obscureText: true,
                        ),
                        
                        // --- Extra Fields for Sign Up Mode ---
                        if (_isSignUpMode) ...[
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: _agreedToTerms,
                                  onChanged: (val) => setState(() => _agreedToTerms = val ?? false),
                                  activeColor: const Color(0xFF6B8E8E), // Sage
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: RichText(
                                  text: TextSpan(
                                    style: const TextStyle(color: Color(0xFF5A6361), fontSize: 12, height: 1.4),
                                    children: [
                                      const TextSpan(text: "I agree to the "),
                                      TextSpan(
                                        text: "Terms of Service & Privacy Policy",
                                        style: const TextStyle(
                                          color: Color(0xFF1A1F1E),
                                          fontWeight: FontWeight.w700,
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
                        
                        const SizedBox(height: 32),

                        if (_isLoading)
                          const Center(child: CircularProgressIndicator(color: Color(0xFF6B8E8E)))
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1A1F1E),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  _isSignUpMode ? 'Create Account' : 'Sign In',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 0.5),
                                ),
                              ),
                              const SizedBox(height: 20),
                              TextButton(
                                onPressed: _toggleMode,
                                style: TextButton.styleFrom(
                                   foregroundColor: const Color(0xFF5A6361),
                                ),
                                child: Text(_isSignUpMode 
                                  ? 'Already have an account? Sign In' 
                                  : 'Don\'t have an account? Create one',
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                              ),
                              
                              if (theme.platform == TargetPlatform.iOS) ...[
                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    const Expanded(child: Divider()),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Text('OR', style: TextStyle(color: const Color(0xFF5A6361).withOpacity(0.5), fontSize: 12, fontWeight: FontWeight.w800)),
                                    ),
                                    const Expanded(child: Divider()),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                SignInWithAppleButton(
                                  onPressed: () async {
                                    try {
                                      await ref.read(authServiceProvider).signInWithApple();
                                    } catch (e) {
                                      if (mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Apple Sign-In Error: $e')),
                                        );
                                      }
                                    }
                                  },
                                  style: SignInWithAppleButtonStyle.black,
                                  height: 56,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ],
                            ],
                          ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // 6. Explainer Link
                  TextButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => const ScoreExplainerSheet(),
                      );
                    },
                    icon: const Icon(Icons.info_outline, color: Color(0xFF5A6361), size: 18),
                    label: const Text(
                      'How is the AIP Score Calculated?',
                      style: TextStyle(
                        color: Color(0xFF5A6361), 
                        fontSize: 13, 
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
