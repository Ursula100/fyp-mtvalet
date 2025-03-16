import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController oldPointsController;
  final TextEditingController updatedPointsController;

  const UserInfoWidget({
    super.key,
    required this.nameController,
    required this.oldPointsController,
    required this.updatedPointsController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
          decoration: const InputDecoration(labelText: "Updated Points"),
          controller: updatedPointsController,
          readOnly: true,
        ),
      ],
    );
  }
}