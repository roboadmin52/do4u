import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customer_app/features/errands/repository/errand_repository.dart';
import 'package:models/models.dart';
import 'package:shared_ui/shared_ui.dart';

class ErrandsHistoryTab extends StatefulWidget {
  const ErrandsHistoryTab({super.key});

  @override
  State<ErrandsHistoryTab> createState() => _ErrandsHistoryTabState();
}

class _ErrandsHistoryTabState extends State<ErrandsHistoryTab> {
  List<Errand> _errands = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchErrands();
  }

  Future<void> _fetchErrands() async {
    setState(() => _isLoading = true);
    try {
      final errands = await context.read<ErrandRepository>().getMyErrands();
      setState(() {
        _errands = errands;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Errands')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _fetchErrands,
              child: _errands.isEmpty
                  ? const Center(child: Text('You have no errands yet.'))
                  : ListView.builder(
                      itemCount: _errands.length,
                      itemBuilder: (context, index) {
                        final errand = _errands[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: ListTile(
                            title: Text('Errand #${errand.errandNumber}'),
                            subtitle: Text('${errand.category.toString().split('.').last.toUpperCase()} | ${errand.subType}'),
                            trailing: StatusChip(status: errand.status.toString().split('.').last),
                            onTap: () => context.push('/errands/${errand.id}', extra: errand),
                          ),
                        );
                      },
                    ),
            ),
    );
  }
}
