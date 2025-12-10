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

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  // Category Colors
  static const Color colorHealth = Color(0xFF2196F3); // Blue
  static const Color colorTeam = Color(0xFF9C27B0);   // Purple
  static const Color colorHome = Color(0xFFFF9800);   // Orange

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

  @override
  Widget build(BuildContext context) {
    final firestoreService = ref.watch(firestoreServiceProvider);
    final user = ref.watch(authServiceProvider).currentUser;
    final userId = user?.uid ?? '';

    if (userId.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => ref.read(authServiceProvider).signOut(),
          ),
        ],
      ),
      body: StreamBuilder<List<AssessmentModel>>(
        stream: firestoreService.getAssessmentsForSenior(userId),
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
             displayAssessment = _getEmptyAssessment(userId);
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
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (assessments.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text("No assessments yet. Start one below!", style: TextStyle(color: Colors.grey)),
                    ),
                  ),
                  
                _buildScoreSection(context, finalScore),
                const SizedBox(height: 40),

                // NEW: Score Reference Cards
                const Text(
                  'Score Legend',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                _buildScoreReferenceCards(),
                const SizedBox(height: 40),

                const Text(
                  'Score Breakdown',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 250,
                  child: _buildBarChart(results),
                ),
                const SizedBox(height: 10),
                _buildLegend(),
                const SizedBox(height: 40),

                if (recommendations.isNotEmpty) ...[
                  const Text(
                    'Suggested Actions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 180, 
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: recommendations.length,
                      separatorBuilder: (ctx, i) => const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        return _buildRecommendationCard(context, recommendations[index]);
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                ],

                if (assessments.length > 1) ...[
                  const Text(
                    'Score Trend',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: _buildTrendChart(assessments),
                  ),
                  const SizedBox(height: 40),
                ],

                ElevatedButton(
                  onPressed: () {
                    ref.invalidate(assessmentControllerProvider);
                    context.push('/assessment');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Start New Assessment'),
                ),
                
                if (assessments.isNotEmpty) ...[
                  const SizedBox(height: 40),
                  const Text(
                    "Recent History",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: assessments.length > 5 ? 5 : assessments.length,
                    separatorBuilder: (ctx, i) => const Divider(),
                    itemBuilder: (context, index) {
                      final item = assessments[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: _getScoreColor(item.calculatedResults.scoreFinalAip),
                          child: Text(
                            item.calculatedResults.scoreFinalAip.toInt().toString(), 
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                          ),
                        ),
                        title: Text(DateFormat.yMMMd().add_jm().format(item.metadata.createdAt)),
                        subtitle: Text("AIP Score: ${item.calculatedResults.scoreFinalAip.toInt()}"),
                        trailing: const Icon(Icons.chevron_right),
                      );
                    },
                  )
                ]
              ],
            ),
          );
        },
      ),
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
      width: 140,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(range, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18)),
          Container(height: 4, width: 40, color: color, margin: const EdgeInsets.symmetric(vertical: 8)),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          // Removing Expanded here because it causes errors inside SingleChildScrollView/Row if height isn't fixed
          Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey), maxLines: 3, overflow: TextOverflow.ellipsis),
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
          'Current AIP Score',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 200,
          width: 200,
          child: Stack(
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 80,
                  startDegreeOffset: -90,
                  sections: [
                    PieChartSectionData(
                      color: scoreColor,
                      value: score == 0 ? 0.1 : score,
                      showTitle: false,
                      radius: 20,
                    ),
                    PieChartSectionData(
                      color: Colors.grey.shade200,
                      value: 100 - (score == 0 ? 0.1 : score),
                      showTitle: false,
                      radius: 20,
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
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: scoreColor,
                      ),
                    ),
                    const Text(
                      '/ 100',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
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
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                const style = TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                );
                Widget text;
                switch (value.toInt()) {
                  case 0:
                    text = const Text('Health', style: style);
                    break;
                  case 1:
                    text = const Text('Team', style: style);
                    break;
                  case 2:
                    text = const Text('Home', style: style);
                    break;
                  default:
                    text = const Text('', style: style);
                    break;
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0),
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
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: const FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 20,
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: results.scoreFwb,
                color: colorHealth,
                width: 40, // THICKER BARS
                borderRadius: const BorderRadius.vertical(top: Radius.circular(6)), // ROUNDED TOPS
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: results.scoreCt,
                color: colorTeam,
                width: 40, // THICKER BARS
                borderRadius: const BorderRadius.vertical(top: Radius.circular(6)), // ROUNDED TOPS
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: results.scoreEs,
                color: colorHome,
                width: 40, // THICKER BARS
                borderRadius: const BorderRadius.vertical(top: Radius.circular(6)), // ROUNDED TOPS
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _legendItem("Health", colorHealth),
        const SizedBox(width: 16),
        _legendItem("Team", colorTeam),
        const SizedBox(width: 16),
        _legendItem("Home", colorHome),
      ],
    );
  }

  Widget _legendItem(String label, Color color) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildTrendChart(List<AssessmentModel> assessments) {
    // 1. Prepare Data Points
    // Sort oldest first for the line chart left-to-right flow
    final sortedHistory = List<AssessmentModel>.from(assessments)
      ..sort((a, b) => a.metadata.createdAt.compareTo(b.metadata.createdAt));
    
    // Take recent history but keep order
    // If list is huge, we might want to trim, but for now take all to show full history
    // actually, let's take last 10 points
    List<AssessmentModel> pointsData = sortedHistory;
    if (pointsData.length > 10) {
      pointsData = pointsData.sublist(pointsData.length - 10);
    }

    // 2. Add Start-at-Zero Logic
    // If we have at least one point, add a dummy point 1 month before the first one at score 0
    // This creates the "ramp up" visual.
    List<FlSpot> spots = [];
    if (pointsData.isNotEmpty) {
      final firstDate = pointsData.first.metadata.createdAt;
      // Dummy start point: 30 days before first assessment, score 0
      final startX = firstDate.subtract(const Duration(days: 30)).millisecondsSinceEpoch.toDouble();
      spots.add(FlSpot(startX, 0)); 

      // Add actual points
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
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.shade300,
              strokeWidth: 1,
              dashArray: [5, 5],
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                final text = DateFormat('MMM yy').format(date);
                
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                );
              },
              reservedSize: 30,
              // We need to set an interval so we don't get 1000 labels for milliseconds
              // A rough approximation for "1 month" in ms = 2.6e9
              interval: 2.628e+9, 
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true, 
              interval: 20,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                 return Text(
                   value.toInt().toString(), 
                   style: const TextStyle(color: Colors.grey, fontSize: 10)
                 );
              }
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false), // Hide box border for cleaner look
        minY: 0,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.teal,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: Colors.teal,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.teal.withOpacity(0.3),
                  Colors.teal.withOpacity(0.0),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getCategoryColor(rec.type).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              rec.type.toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: _getCategoryColor(rec.type),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            rec.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Text(
              rec.description,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              // Dialog with more tips
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(rec.title),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(rec.description),
                      const SizedBox(height: 16),
                      const Text("Specific Actions:", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      // Hardcoded detailed tips based on title/type
                      if (rec.title.contains("Fall")) ...[
                        const Text("• Remove throw rugs."),
                        const Text("• Improve lighting in hallways."),
                        const Text("• Consult a Physical Therapist."),
                      ] else if (rec.title.contains("Bathroom")) ...[
                        const Text("• Install grab bars near toilet/shower."),
                        const Text("• Use a non-slip mat."),
                        const Text("• Consider a shower chair."),
                      ] else ...[
                        const Text("• Consult with a local care manager."),
                        const Text("• Monitor daily."),
                      ]
                    ],
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text("Close"))
                  ],
                ),
              );
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
            ),
            child: Text(rec.actionLabel),
          ),
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
