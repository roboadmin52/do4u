import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:shared_ui/shared_ui.dart';
import '../bloc/assignment_bloc.dart';
import '../bloc/assignment_event.dart';
import 'photo_upload_screen.dart';
import 'car_inspection_screen.dart';

class AssignmentDetailScreen extends StatelessWidget {
  final Errand errand;
  const AssignmentDetailScreen({super.key, required this.errand});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Errand #${errand.errandNumber}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(errand.category.toString().split('.').last.toUpperCase(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)),
                StatusChip(status: errand.status.toString().split('.').last),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Instructions', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(errand.description),
            const Divider(height: 32),
            const Text('Location', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(errand.pickupAddress['label'] ?? 'Unknown location'),
            const SizedBox(height: 32),

            _buildActionButton(context),
            const SizedBox(height: 16),
            if (errand.category == ErrandCategory.shopping)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.receipt_long),
                  label: const Text('Add Receipt & Item Cost'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PhotoUploadScreen(
                          title: 'Upload Receipt',
                          onUpload: (url) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Receipt uploaded successfully')),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (errand.category == ErrandCategory.car && errand.status == ErrandStatus.runnerArrived)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.directions_car),
                  label: const Text('Start Car Inspection'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarInspectionScreen(
                          onComplete: (photos) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Car inspection completed')),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    String label = 'Update Status';
    String nextStatus = 'in_progress';

    switch (errand.status) {
      case ErrandStatus.assigned:
        label = 'Start Journey';
        nextStatus = 'runner_en_route';
        break;
      case ErrandStatus.runnerEnRoute:
        label = 'I Have Arrived';
        nextStatus = 'runner_arrived';
        break;
      case ErrandStatus.runnerArrived:
        label = 'Begin Task';
        nextStatus = 'in_progress';
        break;
      case ErrandStatus.inProgress:
        label = 'Mark Completed';
        nextStatus = 'completed';
        break;
      default:
        return const SizedBox.shrink();
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white, padding: const EdgeInsets.all(16)),
        onPressed: () {
          context.read<AssignmentBloc>().add(AssignmentStatusUpdated(errand.id, nextStatus));
          Navigator.pop(context);
        },
        child: Text(label, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
