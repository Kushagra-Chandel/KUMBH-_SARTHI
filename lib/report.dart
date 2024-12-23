// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  XFile? _pickedImage;

  // List to store reports
  final List<Map<String, dynamic>> _reports = [];

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = image;
    });
  }

  void _submitReport() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _reports.add({
          'name': _nameController.text,
          'location': _locationController.text,
          'phone': _phoneController.text,
          'image': _pickedImage?.path,
        });
      });

      // Clear the form
      _nameController.clear();
      _locationController.clear();
      _phoneController.clear();
      _pickedImage = null;
    }
  }

  void _reportFound(int index) {
    TextEditingController foundPhoneController = TextEditingController();
    TextEditingController foundLocationController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Report Found'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: foundLocationController,
                decoration: const InputDecoration(labelText: 'Found Location'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: foundPhoneController,
                decoration:
                    const InputDecoration(labelText: 'Your Phone Number'),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (foundLocationController.text.isNotEmpty &&
                    foundPhoneController.text.isNotEmpty) {
                  setState(() {
                    _reports[index]['foundLocation'] =
                        foundLocationController.text;
                    _reports[index]['foundPhone'] = foundPhoneController.text;
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Lost/Found'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration:
                        const InputDecoration(labelText: 'Name/Description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name or description.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _locationController,
                    decoration:
                        const InputDecoration(labelText: 'Last Seen Location'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the location.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _phoneController,
                    decoration:
                        const InputDecoration(labelText: 'Your Phone Number'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a phone number.';
                      }
                      if (value.length < 10) {
                        return 'Please enter a valid phone number.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo),
                    label: const Text('Attach Image'),
                  ),
                  if (_pickedImage != null) ...[
                    const SizedBox(height: 16),
                    Image.file(
                      File(_pickedImage!.path),
                      height: 150,
                    ),
                  ],
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _submitReport,
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Submit Report'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Submitted Reports',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _reports.length,
                itemBuilder: (context, index) {
                  final report = _reports[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: report['image'] != null
                          ? Image.file(
                              File(report['image']),
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.person),
                      title: Text(report['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Last Seen: ${report['location']}'),
                          Text('Phone: ${report['phone']}'),
                          if (report.containsKey('foundLocation'))
                            Text('Found Location: ${report['foundLocation']}'),
                          if (report.containsKey('foundPhone'))
                            Text('Found By: ${report['foundPhone']}'),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () => _reportFound(index),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange),
                        child: const Text('Found'),
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
}
