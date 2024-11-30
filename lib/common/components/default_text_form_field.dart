import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gather_here/common/const/colors.dart';

typedef FormFieldValidator = String? Function(String?);
typedef OnChanged = void Function(String);

// GH 기본 TextField
class DefaultTextFormField extends StatefulWidget {
  final double height;
  final double width;
  final String title;
  final String label; // textField에 들어갈 안내 텍스트
  final Color filledColor; // textField 배경 색
  final double radius; // textField 곡률
  final TextEditingController? controller; // 입력된 텍스트를 제어 및 관리
  final FormFieldValidator? formFieldValidator; // 텍스트 입력 검증
  final String? errorText; // 에러일 경우 보여줄 텍스트
  final TextInputType keyboardType; // 키보드 입력 타입
  final bool obscureText; // 입력된 텍스트 가리기, 비밀번호 입력 시 true
  final OnChanged? onChanged; // 입력된 텍스트가 수정될  호출되는 콜백

  const DefaultTextFormField({
    required this.label,
    this.controller,
    this.height = 60,
    this.width = double.infinity,
    this.title = '',
    this.filledColor = AppColor.grey4,
    this.radius = 12,
    this.formFieldValidator,
    this.errorText = null,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    super.key,
  });

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {

  @override
  Widget build(BuildContext context) {
    double calculatedHeight = widget.height;
    if (widget.title.isNotEmpty) {
      calculatedHeight = 100;
    }
    return TextSelectionTheme(
      data: const TextSelectionThemeData(
        selectionHandleColor: AppColor.main,
        cursorColor: AppColor.black1
      ),
      child: SizedBox(
        width: widget.width,
        height: calculatedHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.title.isNotEmpty)
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: AppColor.black1,
                  fontWeight: FontWeight.w700,
                ),
              ),
            if (widget.title.isNotEmpty)
              const SizedBox(
                height: 14.0,
              ),
            TextFormField(
              controller: widget.controller,
              validator: widget.formFieldValidator,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              onChanged: widget.onChanged,
              style: const TextStyle(fontSize: 16, color: AppColor.black1),
              decoration: InputDecoration(
                errorText: widget.errorText,
                labelText: widget.label,
                labelStyle: const TextStyle(fontSize: 16, color: Colors.black),
                filled: true,
                fillColor: widget.filledColor,
                border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColor.grey2,
                    ),
                    borderRadius: BorderRadius.circular(widget.radius)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColor.grey2,
                    ),
                    borderRadius: BorderRadius.circular(widget.radius)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColor.black1,
                    ),
                    borderRadius: BorderRadius.circular(widget.radius)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
