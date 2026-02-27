import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:shared_ui/shared_ui.dart';

class PhotoUploadScreen extends StatelessWidget {
  final String title;
  final Function(String) onUpload;

  const PhotoUploadScreen({super.key, required this.title, required this.onUpload});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.camera_alt, size: 100, color: Colors.grey),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Mock photo capture and upload
                onUpload('https://mock-storage.do4u.app/photo-${DateUtils.dateOnly(DateTime.now())}.jpg');
                Navigator.pop(context);
              },
              child: const Text('Capture & Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
