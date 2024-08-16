import 'package:gather_here/screen/design_system/design_system_alert_dialog_screen.dart';
import 'package:gather_here/screen/design_system/design_system_button_dialog_screen.dart';
import 'package:gather_here/screen/design_system/design_system_button_screen.dart';
import 'package:gather_here/screen/design_system/design_system_screen.dart';
import 'package:gather_here/screen/design_system/design_system_text_form_field_screen.dart';
import 'package:gather_here/screen/home/home_screen.dart';
import 'package:go_router/go_router.dart';

import '../../screen/design_system/design_system_text_field_dialog_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => HomeScreen(),
    ),
  ],
);

final dsRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => DesignSystemScreen(),
      routes: [
        GoRoute(path: 'button', name: 'Button', builder: (_, state) => DesignSystemButtonScreen()),
        GoRoute(path: 'alertDialog', name: 'AlertDialog', builder: (_, state) => DesignSystemAlertDialogScreen()),
        GoRoute(path: 'buttonDialog', name: 'ButtonDialog', builder: (_, state) => DesignSystemButtonDialogScreen()),
        GoRoute(path: 'textFieldDialog', name: 'TextFieldDialog', builder: (_, state) => DesignSystemTextFieldDialogScreen()),
        GoRoute(path: 'textField', name: 'TextField', builder: (_, state) => DesignSystemTextFormFieldScreen())
      ]
    ),
  ],
);
