import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController oldPointsController;
  final TextEditingController updatedPointsController;
  final VoidCallback onClear;

  const UserInfoWidget({
    Key? key,
    required this.nameController,
    required this.oldPointsController,
    required this.updatedPointsController,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(labelText: "Customer Name"),
            controller: nameController,
            readOnly: true,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Old Points"),
            controller: oldPointsController,
            readOnly: true,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "New Points"),
            controller: updatedPointsController,
            readOnly: true,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onClear,
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }
}
