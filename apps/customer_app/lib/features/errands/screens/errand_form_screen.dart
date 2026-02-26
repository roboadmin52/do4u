import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:models/models.dart';
import '../bloc/errand_creation_bloc.dart';
import '../bloc/errand_creation_event.dart';
import '../bloc/errand_creation_state.dart';
import 'price_estimate_screen.dart';

class ErrandFormScreen extends StatefulWidget {
  const ErrandFormScreen({super.key});

  @override
  State<ErrandFormScreen> createState() => _ErrandFormScreenState();
}

class _ErrandFormScreenState extends State<ErrandFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _subTypeController = TextEditingController();
  bool _isExpress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Errand Details')),
      body: BlocBuilder<ErrandCreationBloc, ErrandCreationState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Category: ${state.category.toString().split('.').last}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _subTypeController,
                      decoration: const InputDecoration(
                        labelText: 'Sub-type (e.g., Pharmacy, Passport)',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Detailed Instructions',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value!.length < 10 ? 'Too short' : null,
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Express Delivery (+40%)'),
                      subtitle: const Text('Runner prioritizes your errand'),
                      value: _isExpress,
                      onChanged: (val) => setState(() => _isExpress = val),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<ErrandCreationBloc>().add(
                                  ErrandDetailsUpdated(
                                    subType: _subTypeController.text,
                                    description: _descriptionController.text,
                                    pickupAddress: {'lat': 30.0, 'lng': 31.0, 'label': 'Current Location'},
                                    isExpress: _isExpress,
                                  ),
                                );
                            context.read<ErrandCreationBloc>().add(ErrandEstimateRequested());
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PriceEstimateScreen()),
                            );
                          }
                        },
                        child: const Text('Get Price Estimate'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
