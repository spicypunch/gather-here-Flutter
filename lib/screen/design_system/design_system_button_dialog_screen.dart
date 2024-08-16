import 'package:flutter/material.dart';
import 'package:gather_here/common/components/default_layout.dart';

import '../../common/components/default_button_dialog.dart';
import '../../common/const/colors.dart';

class DesignSystemButtonDialogScreen extends StatelessWidget {
  const DesignSystemButtonDialogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Dialog',
      child: SafeArea(
        child: DefaultButtonDialog(
          date: '2024-08-03(토)',
          time: '19시 14분',
          destination: '스타벅스 선릉역점',
        ),
      ),
      backgroundColor: AppColor.black,
    );
  }
}
