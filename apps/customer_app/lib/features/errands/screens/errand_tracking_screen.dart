import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:models/models.dart';
import 'package:shared_ui/shared_ui.dart';
import '../widgets/runner_map.dart';
import '../widgets/chat_overlay.dart';

class ErrandTrackingScreen extends StatelessWidget {
  final Errand errand;
  const ErrandTrackingScreen({super.key, required this.errand});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tracking Errand #${errand.errandNumber}')),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: RunnerMap(
              runnerLocation: LatLng(
                (errand.pickupAddress['lat'] as double) + 0.01,
                (errand.pickupAddress['lng'] as double) + 0.01,
              ),
              pickupLocation: LatLng(
                errand.pickupAddress['lat'] as double,
                errand.pickupAddress['lng'] as double,
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(errand.category.toString().split('.').last.toUpperCase(),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      StatusChip(status: errand.status.toString().split('.').last),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('Progress', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildTimeline(context),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ChatOverlay(errandId: errand.id),
            ),
          );
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.chat),
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    final states = [
      {'label': 'Confirmed', 'status': ErrandStatus.confirmed},
      {'label': 'Runner Assigned', 'status': ErrandStatus.assigned},
      {'label': 'On the Way', 'status': ErrandStatus.runnerEnRoute},
      {'label': 'At Location', 'status': ErrandStatus.runnerArrived},
      {'label': 'In Progress', 'status': ErrandStatus.inProgress},
      {'label': 'Completed', 'status': ErrandStatus.completed},
    ];

    int currentIndex = states.indexWhere((s) => s['status'] == errand.status);
    if (currentIndex == -1 && errand.status == ErrandStatus.completed) currentIndex = states.length - 1;

    return Column(
      children: states.asMap().entries.map((entry) {
        int idx = entry.key;
        var s = entry.value;
        bool isDone = idx <= currentIndex;
        bool isCurrent = idx == currentIndex;

        return Row(
          children: [
            Column(
              children: [
                Icon(
                  isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: isDone ? Colors.teal : Colors.grey,
                ),
                if (idx < states.length - 1)
                  Container(width: 2, height: 30, color: isDone ? Colors.teal : Colors.grey.shade300),
              ],
            ),
            const SizedBox(width: 16),
            Text(
              s['label'] as String,
              style: TextStyle(
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                color: isDone ? Colors.black : Colors.grey,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
