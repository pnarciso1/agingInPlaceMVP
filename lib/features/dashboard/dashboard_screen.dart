import 'package:aging_in_place/models/assessment_model.dart';
import 'package:aging_in_place/services/auth_service.dart';
import 'package:aging_in_place/services/firestore_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  // Category Colors
  static const Color colorHealth = Color(0xFF2196F3); // Blue
  static const Color colorTeam = Color(0xFF9C27B0);   // Purple
  static const Color colorHome = Color(0xFFFF9800);   // Orange

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firestoreService = ref.watch(firestoreServiceProvider);
    final user = ref.watch(authServiceProvider).currentUser;
    final userId = user?.uid ?? '';

    // If no user is logged in (should be handled by router redirect, but for safety)
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
          if (assessments.isEmpty) {
             displayAssessment = _getEmptyAssessment(userId);
          } else {
             displayAssessment = assessments.first;
          }

          final results = displayAssessment.calculatedResults;
          final finalScore = results.scoreFinalAip;

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
                  
                // 1. Top Section: AIP Score
                _buildScoreSection(context, finalScore),
                const SizedBox(height: 40),

                // 2. Middle Section: Breakdown Bar Chart
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

                // 3. Trend Line Chart (If history exists)
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

                // 4. Bottom Section: Start Assessment Button
                ElevatedButton(
                  onPressed: () {
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
                
                // 5. History List
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
                        subtitle: Text("Health: ${item.calculatedResults.scoreFwb.toInt()} | Home: ${item.calculatedResults.scoreEs.toInt()}"),
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

  AssessmentModel _getEmptyAssessment(String userId) {
    return AssessmentModel(
      metadata: AssessmentMetadata(
        assessmentId: 'empty',
        seniorId: userId,
        createdAt: DateTime.now(),
      ),
      inputsFwb: const InputsFWB(
        adls: ADLs(),
        iadls: IADLs(),
      ),
      inputsCt: const InputsCT(
        coordination: Coordination(),
      ),
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
                width: 22,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: results.scoreCt,
                color: colorTeam,
                width: 22,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: results.scoreEs,
                color: colorHome,
                width: 22,
                borderRadius: BorderRadius.circular(4),
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
    final sortedHistory = assessments.reversed.toList();
    final points = sortedHistory.take(10).toList();

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey.shade300)),
        minY: 0,
        maxY: 100,
        lineBarsData: [
          LineChartBarData(
            spots: points.asMap().entries.map((e) {
              return FlSpot(e.key.toDouble(), e.value.calculatedResults.scoreFinalAip);
            }).toList(),
            isCurved: true,
            color: Colors.teal,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.teal.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
  }
}
