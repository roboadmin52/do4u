import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:models/models.dart';
import 'package:customer_app/features/errands/bloc/errand_creation_bloc.dart';
import 'package:customer_app/features/errands/bloc/errand_creation_event.dart';
import 'package:customer_app/features/errands/bloc/errand_creation_state.dart';
import 'package:customer_app/features/errands/widgets/shopping_list_builder.dart';
import 'package:customer_app/features/errands/widgets/government_form_details.dart';
import 'package:customer_app/features/errands/widgets/car_form_details.dart';
import 'package:customer_app/features/errands/widgets/address_picker.dart';
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

  final _carMakeController = TextEditingController();
  final _carModelController = TextEditingController();
  final _carPlateController = TextEditingController();

  String? _selectedDocType;
  bool _returnToHome = false;
  List<ShoppingItem> _shoppingItems = [];
  bool _isExpress = false;

  Map<String, dynamic>? _pickupAddress = {'lat': 30.0444, 'lng': 31.2357, 'label': 'Tahrir Square, Cairo'};
  Map<String, dynamic>? _dropoffAddress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.errandDetails)),
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
                      '${l10n.selectCategory}: ${state.category.toString().split('.').last.toUpperCase()}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                    const SizedBox(height: 20),

                    AddressPicker(
                      label: 'PICKUP FROM',
                      address: _pickupAddress,
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),
                    if (state.category == ErrandCategory.pickupDropoff || _returnToHome)
                      AddressPicker(
                        label: 'DROP-OFF TO',
                        address: _dropoffAddress,
                        onTap: () {
                          setState(() {
                            _dropoffAddress = {'lat': 30.0561, 'lng': 31.2394, 'label': 'Zamalek, Cairo'};
                          });
                        },
                      ),

                    const Divider(height: 32),

                    if (state.category == ErrandCategory.shopping)
                      ShoppingListBuilder(
                        onChanged: (items) => _shoppingItems = items,
                      ),

                    if (state.category == ErrandCategory.government)
                      GovernmentFormDetails(
                        selectedDocType: _selectedDocType,
                        returnToHome: _returnToHome,
                        onDocTypeChanged: (val) => setState(() => _selectedDocType = val),
                        onReturnToggleChanged: (val) => setState(() => _returnToHome = val),
                      ),

                    if (state.category == ErrandCategory.car)
                      CarFormDetails(
                        makeController: _carMakeController,
                        modelController: _carModelController,
                        plateController: _carPlateController,
                      ),

                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _subTypeController,
                      decoration: InputDecoration(
                        labelText: l10n.subType,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: l10n.instructions,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) => value!.length < 10 ? 'Too short' : null,
                    ),

                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: Text(l10n.expressService),
                      value: _isExpress,
                      onChanged: (val) => setState(() => _isExpress = val),
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => _submit(state.category!),
                        child: Text(l10n.reviewPrice, style: const TextStyle(fontSize: 18)),
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

  void _submit(ErrandCategory category) {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> categoryDetails = {};

      if (category == ErrandCategory.shopping) {
        categoryDetails['items'] = _shoppingItems.map((e) => e.toJson()).toList();
      } else if (category == ErrandCategory.government) {
        categoryDetails['doc_type'] = _selectedDocType;
        categoryDetails['return_to_home'] = _returnToHome;
      } else if (category == ErrandCategory.car) {
        categoryDetails['car_make'] = _carMakeController.text;
        categoryDetails['car_model'] = _carModelController.text;
        categoryDetails['car_plate'] = _carPlateController.text;
      }

      context.read<ErrandCreationBloc>().add(
            ErrandDetailsUpdated(
              subType: _subTypeController.text,
              description: _descriptionController.text,
              pickupAddress: _pickupAddress!,
              dropoffAddress: _dropoffAddress,
              isExpress: _isExpress,
              categoryDetails: categoryDetails,
            ),
          );

      context.read<ErrandCreationBloc>().add(ErrandEstimateRequested());
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PriceEstimateScreen()),
      );
    }
  }
}
