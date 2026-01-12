import 'package:aging_in_place/services/auth_service.dart';
import 'package:aging_in_place/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class InviteScreen extends ConsumerStatefulWidget {
  final String inviteId;
  const InviteScreen({super.key, required this.inviteId});

  @override
  ConsumerState<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends ConsumerState<InviteScreen> {
  bool _isLoading = true;
  Map<String, dynamic>? _inviteData;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadInvite();
  }

  Future<void> _loadInvite() async {
    try {
      final data = await ref.read(firestoreServiceProvider).getInviteById(widget.inviteId);
      if (mounted) {
        setState(() {
          _inviteData = data;
          _isLoading = false;
          if (data == null) _error = "Invite not found or expired.";
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = "Error loading invite: $e";
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _acceptInvite() async {
    final user = ref.read(authServiceProvider).currentUser;
    if (user == null) {
      // Not logged in, redirect to login
      context.go('/');
      return;
    }

    setState(() => _isLoading = true);
    try {
      final firestoreService = ref.read(firestoreServiceProvider);
      
      // 1. Ensure user profile exists first
      await firestoreService.ensureUserProfile(user.uid, user.email!);

      // 2. Accept Invite
      await firestoreService.acceptInvite(
        widget.inviteId,
        _inviteData!['senior_id'],
        user.uid,
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Successfully joined the Care Team!')),
        );
        context.go('/dashboard');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = "Failed to accept invite: $e";
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider).valueOrNull;

    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(_error!, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: () => context.go('/'), child: const Text('Go to Home')),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.people_alt_outlined, size: 80, color: Colors.teal),
              const SizedBox(height: 32),
              Text(
                'Join Care Team',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                '${_inviteData!['from_name']} has invited you to join the care team for ${_inviteData!['senior_name']}.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, color: Colors.blueGrey),
              ),
              const SizedBox(height: 48),
              if (user == null) ...[
                const Text(
                  'Please sign in or create an account to accept this invitation.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: const Text('Sign In / Sign Up'),
                ),
              ] else ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      const Text('You are currently logged in as:', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(user.email ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () async {
                          await ref.read(authServiceProvider).signOut();
                          setState(() {}); // Refresh to show login buttons
                        },
                        child: const Text('Not you? Logout', style: TextStyle(fontSize: 12, color: Colors.red)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _acceptInvite,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Accept Invitation'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => context.go('/dashboard'),
                  child: const Text('Decline'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
