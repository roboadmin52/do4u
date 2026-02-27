import 'package:flutter/material.dart';

class CarInspectionScreen extends StatefulWidget {
  final Function(List<String>) onComplete;
  const CarInspectionScreen({super.key, required this.onComplete});

  @override
  State<CarInspectionScreen> createState() => _CarInspectionScreenState();
}

class _CarInspectionScreenState extends State<CarInspectionScreen> {
  final List<String> _photos = [];
  final List<String> _steps = ['Front', 'Rear', 'Driver Side', 'Passenger Side'];
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Car Inspection')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(value: (_currentStep + 1) / _steps.length),
            const SizedBox(height: 32),
            Text(
              'Step ${_currentStep + 1}: Take photo of ${_steps[_currentStep]}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Icon(Icons.camera_alt, size: 100, color: Colors.grey),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _photos.add('https://mock-storage.do4u.app/car-${_steps[_currentStep].toLowerCase()}.jpg');
                    if (_currentStep < _steps.length - 1) {
                      _currentStep++;
                    } else {
                      widget.onComplete(_photos);
                      Navigator.pop(context);
                    }
                  });
                },
                child: Text(_currentStep < _steps.length - 1 ? 'Capture Photo' : 'Finish Inspection'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
