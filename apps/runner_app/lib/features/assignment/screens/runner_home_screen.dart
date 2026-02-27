import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import 'package:shared_ui/shared_ui.dart';
import '../bloc/assignment_bloc.dart';
import '../bloc/assignment_event.dart';
import '../bloc/assignment_state.dart';
import 'assignment_detail_screen.dart';

class RunnerHomeScreen extends StatefulWidget {
  const RunnerHomeScreen({super.key});

  @override
  State<RunnerHomeScreen> createState() => _RunnerHomeScreenState();
}

class _RunnerHomeScreenState extends State<RunnerHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AssignmentBloc>().add(AssignmentFetchRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Runner Assignments'),
        actions: [
          BlocBuilder<AssignmentBloc, AssignmentState>(
            builder: (context, state) {
              return Switch(
                value: state.isAvailable,
                onChanged: (val) => context.read<AssignmentBloc>().add(RunnerAvailabilityToggled(val)),
                activeColor: Colors.green,
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<AssignmentBloc, AssignmentState>(
        builder: (context, state) {
          if (state.status == AssignmentStatus.loading && state.assignments.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.assignments.isEmpty) {
            return const Center(child: Text('No active assignments. Go online to receive some!'));
          }

          return RefreshIndicator(
            onRefresh: () async => context.read<AssignmentBloc>().add(AssignmentFetchRequested()),
            child: ListView.builder(
              itemCount: state.assignments.length,
              itemBuilder: (context, index) {
                final errand = state.assignments[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text('Errand #${errand.errandNumber}'),
                    subtitle: Text('${errand.category.toString().split('.').last.toUpperCase()} | ${errand.subType}'),
                    trailing: StatusChip(status: errand.status.toString().split('.').last),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AssignmentDetailScreen(errand: errand)),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
