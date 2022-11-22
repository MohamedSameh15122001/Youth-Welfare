import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
            ),
            TextFormField(),
            TextFormField(),
          ],
        ),
      ),
    );
  }
}
