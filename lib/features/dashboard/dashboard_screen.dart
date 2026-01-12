import 'package:share_plus/share_plus.dart';
import 'package:printing/printing.dart';
import 'package:aging_in_place/services/report_service.dart';
import 'package:aging_in_place/features/assessment/assessment_controller.dart';
import 'package:aging_in_place/features/auth/widgets/score_explainer_sheet.dart';
import 'package:aging_in_place/models/assessment_model.dart';
import 'package:aging_in_place/models/recommendation_model.dart';
import 'package:aging_in_place/services/auth_service.dart';
import 'package:aging_in_place/services/firestore_service.dart';
import 'package:aging_in_place/services/recommendation_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final selectedSeniorIdProvider = StateProvider<String?>((ref) => null);

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  // Category Colors
  static const Color colorHealth = Color(0xFF2DD4BF); // Sage Mint
  static const Color colorTeam = Color(0xFF818CF8);   // Soft Lavender
  static const Color colorHome = Color(0xFFFB923C);   // Warm Sand

  @override
  void initState() {
    super.initState();
    _checkFirstTimeUser();
  }

  Future<void> _checkFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeen = prefs.getBool('has_seen_intro') ?? false;

    if (!hasSeen) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, 
            builder: (_) => const ScoreExplainerSheet(),
          );
          prefs.setBool('has_seen_intro', true);
        }
      });
    }
  }

  void _createNewSenior() async {
    final nameController = TextEditingController();
    final user = ref.read(authServiceProvider).currentUser;
    if (user == null) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Create a Profile for Your Loved One'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: "Name"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty) {
                try {
                  final seniorId = await ref.read(firestoreServiceProvider).createSeniorProfile(user.uid, nameController.text);
                  ref.read(selectedSeniorIdProvider.notifier).state = seniorId;
                  if (mounted) Navigator.pop(ctx);
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
                    );
                  }
                }
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final firestoreService = ref.watch(firestoreServiceProvider);
    final user = ref.watch(authServiceProvider).currentUser;
    final userId = user?.uid ?? '';
    final userEmail = user?.email ?? '';

    // Auto-ensure user profile exists
    if (userId.isNotEmpty && userEmail.isNotEmpty) {
      Future.microtask(() => firestoreService.ensureUserProfile(userId, userEmail));
    }

    if (userId.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: firestoreService.getSeniorsForUser(userId),
      builder: (context, seniorsSnapshot) {
        if (seniorsSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        final seniors = seniorsSnapshot.data ?? [];
        final selectedSeniorId = ref.watch(selectedSeniorIdProvider);
        
        // Auto-select first senior if none selected
        if (selectedSeniorId == null && seniors.isNotEmpty) {
          Future.microtask(() {
            ref.read(selectedSeniorIdProvider.notifier).state = seniors.first['id'];
          });
    }

    return Scaffold(
      appBar: AppBar(
            elevation: 0,
            scrolledUnderElevation: 0,
            title: seniors.isEmpty 
              ? const Text('DASHBOARD', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 2))
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedSeniorId,
                      icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                      style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF0F172A), fontSize: 15),
                      items: seniors.map((s) => DropdownMenuItem(
                        value: s['id'] as String,
                        child: Text(s['name']?.toString().toUpperCase() ?? 'SENIOR'),
                      )).toList(),
                      onChanged: (id) => ref.read(selectedSeniorIdProvider.notifier).state = id,
                    ),
                  ),
                ),
        centerTitle: true,
        actions: [
              if (selectedSeniorId != null) ...[
                IconButton(
                  icon: const Icon(Icons.ios_share_rounded, size: 22),
                  tooltip: 'Share Invite Link',
                  onPressed: () => _shareInviteLink(selectedSeniorId, seniors.firstWhere((s) => s['id'] == selectedSeniorId)['name']),
                ),
                IconButton(
                  icon: const Icon(Icons.group_add_outlined, size: 24),
                  tooltip: 'Manage Team',
                  onPressed: () => _manageTeam(selectedSeniorId, seniors.firstWhere((s) => s['id'] == selectedSeniorId)['care_team']),
                ),
              ],
              IconButton(
                icon: const Icon(Icons.add_circle_outline_rounded, size: 22),
                tooltip: 'Add Senior',
                onPressed: _createNewSenior,
              ),
              IconButton(
                icon: const Icon(Icons.logout_rounded, size: 22),
                onPressed: () => ref.read(authServiceProvider).signOut(),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert_rounded, size: 22),
                onSelected: (value) async {
                  if (value == 'delete_account') {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (c) => AlertDialog(
                        title: const Text('Delete Account?', style: TextStyle(color: Colors.red)),
                        content: const Text('Are you sure you want to permanently delete your account and all associated data? This action cannot be undone.'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
                          TextButton(
                            onPressed: () => Navigator.pop(c, true), 
                            child: const Text('Delete', style: TextStyle(color: Colors.red))
                          ),
                        ],
                      ),
                    );
                    
                    if (confirm == true) {
                      try {
                        await ref.read(authServiceProvider).deleteAccount();
                        // Sign out happens automatically on delete, but we can force redirect
                        if (mounted) context.go('/');
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e. You may need to re-authenticate before deleting your account.')),
                          );
                        }
                      }
                    }
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'delete_account',
                    child: Text('Delete Account', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ],
          ),
          body: Column(
            children: [
              if (userEmail.isNotEmpty)
                _buildInvitesSection(userEmail, userId),
              Expanded(
                child: seniors.isEmpty 
                  ? _buildNoSeniorsView()
                  : selectedSeniorId == null
                    ? const Center(child: CircularProgressIndicator())
                    : _buildSeniorDashboard(selectedSeniorId, seniors.firstWhere((s) => s['id'] == selectedSeniorId)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInvitesSection(String email, String userId) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: ref.read(firestoreServiceProvider).getInvitesForEmail(email),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) return const SizedBox.shrink();
        
        final invites = snapshot.data!;
        return Container(
          color: Colors.blue.shade50,
          child: Column(
            children: invites.map((invite) => ListTile(
              leading: const Icon(Icons.mail_outline, color: Colors.blue),
              title: Text('Invite to join ${invite['senior_name']}\'s care team'),
              subtitle: Text('From: ${invite['from_name']}'),
              trailing: ElevatedButton(
                onPressed: () => ref.read(firestoreServiceProvider).acceptInvite(invite['id'], invite['senior_id'], userId),
                child: const Text('Accept'),
              ),
            )).toList(),
          ),
        );
      },
    );
  }

  Widget _buildNoSeniorsView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.people_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              "No Care Profiles Yet",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Create a profile for the person you are caring for to get started.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _createNewSenior,
              child: const Text("Create Profile"),
            ),
          ],
        ),
      ),
    );
  }

  void _shareReport(AssessmentModel assessment, List<AssessmentModel> history) async {
    setState(() => _isSharing = true);
    try {
      final pdfBytes = await ReportService.generateMedicalReport(assessment, history);
      final filename = 'AIP_Report_${(assessment.metadata.subjectName ?? 'Senior').replaceAll(' ', '_')}.pdf';
      await Printing.sharePdf(bytes: pdfBytes, filename: filename);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sharing report: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  bool _isSharing = false;

  void _shareInviteLink(String seniorId, String seniorName) async {
    final user = ref.read(authServiceProvider).currentUser;
    if (user == null) return;

    try {
      final inviteId = await ref.read(firestoreServiceProvider).createPublicInvite(
        seniorId: seniorId,
        seniorName: seniorName,
        fromUserId: user.uid,
        fromUserName: user.email ?? 'Family Member',
      );

      // In a real app, this would be your production URL
      final inviteUrl = 'https://aging-in-place.web.app/invite/$inviteId';
      
      await Share.share(
        'Join the care team for $seniorName on Aging In Place: $inviteUrl',
        subject: 'Invitation to join Care Team',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error creating invite: $e')),
        );
      }
    }
  }

  void _manageTeam(String seniorId, List<dynamic> careTeamIds) {
    final teamList = careTeamIds.cast<String>();
    final user = ref.read(authServiceProvider).currentUser;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Manage Care Team'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: teamList.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (ctx, i) {
              final memberId = teamList[i];
              final isMe = memberId == user?.uid;
              
              // Load user info and activity independently for each ID
              return FutureBuilder<Map<String, dynamic>?>(
                future: ref.read(firestoreServiceProvider).getUserProfile(memberId),
                builder: (context, userSnapshot) {
                  final userData = userSnapshot.data;
                  final email = userData?['email'] ?? (isMe ? user?.email : 'Member ID: $memberId');

                  return FutureBuilder<DateTime?>(
                    future: ref.read(firestoreServiceProvider).getLastEntryForMember(seniorId, memberId),
                    builder: (context, activitySnapshot) {
                      final lastEntry = activitySnapshot.data;
                      
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.teal.shade50,
                          child: Icon(Icons.person, color: Colors.teal.shade700),
                        ),
                        title: Text(email ?? 'Unknown Member'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (isMe) const Text('Owner (You)', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 12)),
                            if (activitySnapshot.connectionState == ConnectionState.waiting)
                              const Text('Loading activity...', style: TextStyle(fontSize: 11, color: Colors.grey))
                            else
                              Text(lastEntry != null 
                                ? 'Last Entry: ${DateFormat.yMMMd().add_jm().format(lastEntry)}' 
                                : 'No entries yet',
                                style: const TextStyle(fontSize: 11),
                              ),
                          ],
                        ),
                        trailing: isMe ? null : IconButton(
                          icon: const Icon(Icons.person_remove, color: Colors.red),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (c) => AlertDialog(
                                title: const Text('Revoke Access?'),
                                content: Text('Are you sure you want to remove $email from the care team?'),
                                actions: [
                                  TextButton(onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
                                  TextButton(onPressed: () => Navigator.pop(c, true), child: const Text('Remove', style: TextStyle(color: Colors.red))),
                                ],
                              ),
                            );
                            
                            if (confirm == true) {
                              await ref.read(firestoreServiceProvider).removeFromCareTeam(seniorId, memberId);
                              if (mounted) Navigator.pop(ctx);
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
        ],
      ),
    );
  }

  Widget _buildSeniorDashboard(String seniorId, Map<String, dynamic> seniorData) {
    final firestoreService = ref.watch(firestoreServiceProvider);
    return StreamBuilder<List<AssessmentModel>>(
      stream: firestoreService.getAssessmentsForSenior(seniorId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final assessments = snapshot.data ?? [];
          
          AssessmentModel displayAssessment;
          AssessmentModel? previousAssessment;

          if (assessments.isEmpty) {
           displayAssessment = _getEmptyAssessment(seniorId);
          } else {
             displayAssessment = assessments.first;
             if (assessments.length > 1) {
               previousAssessment = assessments[1];
             }
          }

          final results = displayAssessment.calculatedResults;
          final finalScore = results.scoreFinalAip;
          
          final recommendations = RecommendationService.generate(
            displayAssessment, 
            previous: previousAssessment
          );

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (assessments.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: Text("Ready to start your first assessment?", style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                  ),
                ),
                
              _buildScoreSection(context, finalScore),
              const SizedBox(height: 32),
              
              if (assessments.isNotEmpty)
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: TextButton.icon(
                      onPressed: _isSharing ? null : () => _shareReport(displayAssessment, assessments),
                      icon: _isSharing 
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.description_outlined, size: 20),
                      label: const Text('MEDICAL REPORT', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1, fontSize: 12)),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        foregroundColor: const Color(0xFF475569),
                      ),
                    ),
                  ),
                ),
                
              const SizedBox(height: 48),

              const Text(
                'SCORE LEGEND',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: Colors.blueGrey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildScoreReferenceCards(),
              const SizedBox(height: 56),

              const Text(
                'CATEGORY BREAKDOWN',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: Colors.blueGrey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 280,
                child: _buildBarChart(results),
              ),
              const SizedBox(height: 16),
              Center(child: _buildLegend()),
              const SizedBox(height: 64),

              if (recommendations.isNotEmpty) ...[
                Row(
                  children: [
                    const Text(
                      'SUGGESTED ACTIONS',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: Colors.blueGrey),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(6)),
                      child: Text('${recommendations.length} NEW', style: TextStyle(color: Colors.teal.shade700, fontSize: 10, fontWeight: FontWeight.w900)),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200, 
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: recommendations.length,
                    separatorBuilder: (ctx, i) => const SizedBox(width: 20),
                    itemBuilder: (context, index) {
                      return _buildRecommendationCard(context, recommendations[index]);
                    },
                  ),
                ),
                const SizedBox(height: 64),
              ],

              if (assessments.length > 1) ...[
                const Text(
                  'PROGRESS OVER TIME',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: Colors.blueGrey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Container(
                  height: 240,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: _buildTrendChart(assessments),
                ),
                const SizedBox(height: 64),
              ],

              ElevatedButton(
                onPressed: () {
                  ref.invalidate(assessmentControllerProvider(seniorId));
                  context.push('/assessment/$seniorId');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: const Color(0xFF0F172A),
                  foregroundColor: Colors.white,
                  elevation: 8,
                  shadowColor: const Color(0xFF0F172A).withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.add_circle_outline),
                    SizedBox(width: 12),
                    Text('Add Daily Observation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  ],
                ),
              ),

              if (assessments.isNotEmpty) ...[
                const Text(
                  "RECENT HISTORY",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1.5, color: Colors.blueGrey),
                ),
                const SizedBox(height: 20),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: assessments.length > 5 ? 5 : assessments.length,
                  separatorBuilder: (ctx, i) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = assessments[index];
                    final score = item.calculatedResults.scoreFinalAip;
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade100),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        leading: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: _getScoreColor(score).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              score.toInt().toString(), 
                              style: TextStyle(color: _getScoreColor(score), fontWeight: FontWeight.w900, fontSize: 16)
                            ),
                          ),
                        ),
                        title: Text(
                          DateFormat.yMMMd().format(item.metadata.createdAt),
                          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF1E293B)),
                        ),
                        subtitle: Text(
                          DateFormat.jm().format(item.metadata.createdAt),
                          style: const TextStyle(fontSize: 12, color: Colors.blueGrey),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 40),
              ]
              ],
            ),
          );
        },
    );
  }

  Widget _buildScoreReferenceCards() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Center( 
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, 
          mainAxisSize: MainAxisSize.min, 
          children: [
            _scoreCard("80-100", "Doing well", "Minimal support needed.", Colors.green),
            const SizedBox(width: 12),
            _scoreCard("60-79", "Early Warning", "Monitor closely.", Colors.lightGreen),
            const SizedBox(width: 12),
            _scoreCard("40-59", "Moderate Risk", "Support needed.", Colors.orange),
            const SizedBox(width: 12),
            _scoreCard("0-39", "High Risk", "Immediate action.", Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _scoreCard(String range, String title, String desc, Color color) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
        border: Border.all(color: color.withOpacity(0.1), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              range, 
              style: TextStyle(color: color, fontWeight: FontWeight.w800, fontSize: 14)
            ),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF1E293B))),
          const SizedBox(height: 6),
          Text(desc, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), height: 1.4), maxLines: 3, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  // ... (Rest of the helper methods remain unchanged)
  AssessmentModel _getEmptyAssessment(String userId) {
    return AssessmentModel(
      metadata: AssessmentMetadata(
        assessmentId: 'empty',
        seniorId: userId,
        createdAt: DateTime.now(),
      ),
      inputsFwb: const InputsFWB(),
      inputsCt: const InputsCT(),
      inputsEs: const InputsES(),
      calculatedResults: const CalculatedResults(scoreFwb: 0, scoreCt: 0, scoreEs: 0, scoreIcs: 0, scoreBls: 0, scoreFinalAip: 0),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.orange;
    return Colors.red;
  }

  Widget _buildScoreSection(BuildContext context, double score) {
    Color scoreColor = _getScoreColor(score);

    return Column(
      children: [
        const Text(
          'AIP SCORE',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 1.5, color: Colors.blueGrey),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 240,
          width: 240,
          child: Stack(
            children: [
              // Outer Glow/Shadow for the gauge
              Center(
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: scoreColor.withOpacity(0.15),
                        blurRadius: 40,
                        spreadRadius: 10,
                      )
                    ],
                  ),
                ),
              ),
              PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 90,
                  startDegreeOffset: -90,
                  sections: [
                    PieChartSectionData(
                      color: scoreColor,
                      value: score == 0 ? 0.1 : score,
                      showTitle: false,
                      radius: 12, // Thinner stroke
                    ),
                    PieChartSectionData(
                      color: Colors.grey.withOpacity(0.1),
                      value: 100 - (score == 0 ? 0.1 : score),
                      showTitle: false,
                      radius: 12,
                    ),
                  ],
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      score.toInt().toString(),
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w900,
                        color: scoreColor,
                        letterSpacing: -2,
                      ),
                    ),
                    const Text(
                      'Out of 100',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBarChart(CalculatedResults results) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 100,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => const Color(0xFF1E293B),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${rod.toY.toInt()}',
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  color: Colors.blueGrey,
                );
                Widget text;
                switch (value.toInt()) {
                  case 0: text = const Text('HEALTH', style: style); break;
                  case 1: text = const Text('TEAM', style: style); break;
                  case 2: text = const Text('HOME', style: style); break;
                  default: text = const Text(''); break;
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: text,
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 20,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 20,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey.withOpacity(0.1),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          _barGroup(0, results.scoreFwb, colorHealth),
          _barGroup(1, results.scoreCt, colorTeam),
          _barGroup(2, results.scoreEs, colorHome),
        ],
      ),
    );
  }

  BarChartGroupData _barGroup(int x, double y, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: color,
          width: 48,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 100,
            color: color.withOpacity(0.05),
          ),
        ),
      ],
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          _legendItem("HEALTH", colorHealth),
          const SizedBox(width: 24),
          _legendItem("TEAM", colorTeam),
          const SizedBox(width: 24),
          _legendItem("HOME", colorHome),
        ],
      ),
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8, 
          height: 8, 
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 8),
        Text(
          label, 
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.5, color: Colors.blueGrey)
        ),
      ],
    );
  }

  Widget _buildTrendChart(List<AssessmentModel> assessments) {
    final sortedHistory = List<AssessmentModel>.from(assessments)
      ..sort((a, b) => a.metadata.createdAt.compareTo(b.metadata.createdAt));
    
    List<AssessmentModel> pointsData = sortedHistory;
    if (pointsData.length > 10) {
      pointsData = pointsData.sublist(pointsData.length - 10);
    }

    List<FlSpot> spots = [];
    if (pointsData.isNotEmpty) {
      for (var a in pointsData) {
        spots.add(FlSpot(
          a.metadata.createdAt.millisecondsSinceEpoch.toDouble(), 
          a.calculatedResults.scoreFinalAip
        ));
      }
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 20,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey.withOpacity(0.05),
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                return Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    DateFormat('MMM d').format(date),
                    style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                  ),
                );
              },
              reservedSize: 30,
              interval: 8.64e+7 * 2, // 2 days interval approx
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true, 
              interval: 20,
              reservedSize: 30,
              getTitlesWidget: (value, meta) => Text(
                value.toInt().toString(), 
                style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)
              ),
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minY: 0,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: const Color(0xFF0F172A),
            barWidth: 4,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                radius: 6,
                color: Colors.white,
                strokeWidth: 3,
                strokeColor: const Color(0xFF0F172A),
              ),
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF0F172A).withOpacity(0.1),
                  const Color(0xFF0F172A).withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(BuildContext context, Recommendation rec) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 30,
            offset: const Offset(0, 10),
          )
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _getCategoryColor(rec.type).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              rec.type.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
                color: _getCategoryColor(rec.type),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            rec.title,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17, color: Color(0xFF1E293B)),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              rec.description,
              style: const TextStyle(color: Color(0xFF64748B), fontSize: 13, height: 1.5),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              // Dialog with more tips
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                  title: Text(rec.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(rec.description, style: const TextStyle(height: 1.5, color: Color(0xFF4A5568))),
                      const SizedBox(height: 24),
                      const Text("SPECIFIC ACTIONS", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1, color: Colors.blueGrey)),
                      const SizedBox(height: 12),
                      if (rec.title.contains("Fall")) ...[
                        _bulletPoint("Remove throw rugs"),
                        _bulletPoint("Improve hallway lighting"),
                        _bulletPoint("Consult a Physical Therapist"),
                      ] else if (rec.title.contains("Bathroom")) ...[
                        _bulletPoint("Install grab bars"),
                        _bulletPoint("Use a non-slip mat"),
                        _bulletPoint("Consider a shower chair"),
                      ] else ...[
                        _bulletPoint("Consult a care manager"),
                        _bulletPoint("Monitor daily"),
                      ]
                    ],
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text("Got it"))
                  ],
                ),
              );
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
              foregroundColor: _getCategoryColor(rec.type),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(rec.actionLabel, style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward_rounded, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline_rounded, size: 18, color: Colors.teal),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14, color: Color(0xFF2D3748)))),
        ],
      ),
    );
  }

  Color _getCategoryColor(String type) {
    switch (type) {
      case 'Health': return colorHealth;
      case 'Home': return colorHome;
      case 'Care': return colorTeam;
      default: return Colors.teal;
    }
  }
}
