import 'package:flutter/material.dart';
import 'package:gather_here/common/components/default_text_form_field.dart';
import 'package:go_router/go_router.dart';

import '../const/colors.dart';
import 'default_button.dart';

class DefaultTextFieldDialog extends StatefulWidget {
  final String title;
  final List<String> labels;
  final Function(List<String>) onChanged;
  final bool hideText;

  const DefaultTextFieldDialog({
    required this.title,
    required this.labels,
    required this.onChanged,
    this.hideText = false,
    super.key,
  });

  @override
  _DefaultTextFieldDialogState createState() => _DefaultTextFieldDialogState();
}

class _DefaultTextFieldDialogState extends State<DefaultTextFieldDialog> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.labels.length,
      (_) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      backgroundColor: AppColor.background,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 30),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: widget.labels.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      return _TextFieldWidget(
                        label: widget.labels[index],
                        controller: _controllers[index],
                        hideText: widget.hideText,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),
                DefaultButton(
                  title: '확인',
                  onTap: () {
                    List<String> values =
                        _controllers.map((c) => c.text).toList();
                    widget.onChanged(values);
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool hideText;

  const _TextFieldWidget({
    required this.label,
    required this.controller,
    required this.hideText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTextFormField(
      label: label,
      controller: controller,
      obscureText: hideText,
    );
  }
}
