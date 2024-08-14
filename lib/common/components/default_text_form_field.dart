import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gather_here/common/const/colors.dart';

// GH 기본 TextField
class DefaultTextFormField extends StatefulWidget {
  final double height;
  final double width;
  final String label; // textField에 들어갈 안내 텍스트
  final Color filledColor; // textField 배경 색
  final double radius; // textField 곡률
  final TextEditingController controller; // 입력된 텍스트를 제어 및 관리
  final String? Function(String?)? validator; // 텍스트 입력 검증
  final TextInputType keyboardType; // 키보드 입력 타입
  final bool obscureText; // 입력된 텍스트 가리기, 비밀번호 입력 시 true
  final void Function(String)? onChanged; // 입력된 텍스트가 수정될  호출되는 콜백

  const DefaultTextFormField({
    required this.label,
    required this.controller,
    this.height = 65,
    this.width = double.infinity,
    this.filledColor = AppColor.grey4,
    this.radius = 12,
    this.validator,
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
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        cursorColor: AppColor.black,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        onChanged: widget.onChanged,
        style: TextStyle(fontSize: 16, color: AppColor.black),
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
          filled: true,
          fillColor: widget.filledColor,
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.grey2,
              ),
              borderRadius: BorderRadius.circular(widget.radius)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.grey2,
              ),
              borderRadius: BorderRadius.circular(widget.radius)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.grey2,
              ),
              borderRadius: BorderRadius.circular(widget.radius)),
        ),
      ),
    );
  }
}
