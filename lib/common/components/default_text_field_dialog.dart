import 'package:flutter/material.dart';

import '../const/colors.dart';
import 'default_button.dart';

class DefaultTextFieldDialog extends StatelessWidget {
  final String title;
  final List<String> labels;

  const DefaultTextFieldDialog({
    required this.title,
    required this.labels,
    super.key,
  });

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
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 30),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: labels.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                    itemBuilder: (context, index) {
                      return _TextFieldWidget(label: labels[index]);
                    },
                  ),
                ),
                const SizedBox(height: 30),
                DefaultButton(
                  title: '확인',
                  onTap: () {},
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
                Navigator.of(context).pop();
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

  const _TextFieldWidget({
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 16, color: AppColor.black),
      cursorColor: AppColor.black,
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: AppColor.grey4,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColor.grey2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColor.grey2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColor.black,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
