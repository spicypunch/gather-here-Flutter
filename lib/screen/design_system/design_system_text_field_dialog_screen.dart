import 'package:flutter/material.dart';
import 'package:gather_here/common/components/default_layout.dart';
import 'package:gather_here/common/components/default_text_field_dialog.dart';

import '../../common/const/colors.dart';

class DesignSystemTextFieldDialogScreen extends StatelessWidget {
  const DesignSystemTextFieldDialogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'TextFieldDialog',
      child: SafeArea(
        child: DefaultTextFieldDialog(
          title: '비밀번호 변경',
          labels: [
            '기존 비밀번호 입력',
            '새 비밀번호 입력',
            '새 비밀번호 입력 확인'
          ],
        ),
      ),
      backgroundColor: AppColor.black,
    );
  }
}
