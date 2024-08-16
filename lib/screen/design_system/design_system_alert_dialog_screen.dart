import 'package:flutter/material.dart';
import 'package:gather_here/common/components/default_alert_dialog.dart';
import 'package:gather_here/common/components/default_layout.dart';

import '../../common/const/colors.dart';

class DesignSystemAlertDialogScreen extends StatelessWidget {
  const DesignSystemAlertDialogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Dialog',
      child: SafeArea(
        child: DefaultAlertDialog(
          title: '회원가입 실패',
          content: '실패 사유는 실패 사유입니다.',
        ),
      ),
      backgroundColor: AppColor.black,
    );
  }
}
