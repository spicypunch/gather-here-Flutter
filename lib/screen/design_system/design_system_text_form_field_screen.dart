import 'package:flutter/material.dart';

import '../../common/components/default_text_form_field.dart';

class DesignSystemTextFormFieldScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _textController = TextEditingController();

  DesignSystemTextFormFieldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design System')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DefaultTextFormField(
                label: 'Username',
                controller: _textController,
                title: '라이프시맨틱스',
                formFieldValidator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  if (value.length < 4) {
                    return 'Username must be at least 4 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Form의 상태를 검증. 모든 TextFormField의 validator 함수가 호출
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
