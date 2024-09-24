import 'package:flutter/material.dart';
import 'package:gather_here/common/components/default_button.dart';
import 'package:gather_here/common/const/colors.dart';
import 'package:intl/intl.dart';

class DefaultDateDialog extends StatefulWidget {
  final String destination;

  // final DateTime? targetDate;
  // final TimeOfDay? targetTime;
  final Function(DateTime, TimeOfDay) onTab;

  const DefaultDateDialog({
    required this.destination,
    // required this.targetDate,
    // required this.targetTime,
    required this.onTab,
    super.key,
  });

  @override
  State<DefaultDateDialog> createState() => _DefaultDateDialogState();
}

class _DefaultDateDialogState extends State<DefaultDateDialog> {
  late DateTime dateTime;
  late TimeOfDay timeOfDay;

  @override
  void initState() {
    super.initState();
    dateTime = DateTime.now();
    timeOfDay = TimeOfDay.now();
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
                const SizedBox(height: 30),

                /// DatePicker
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: GestureDetector(
                    onTap: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: dateTime,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: AppColor.main,
                                onPrimary: AppColor.white,
                                onSurface: AppColor.grey1,
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColor.main,
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedDate != null) {
                        setState(() {
                          dateTime = pickedDate;
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '날짜',
                          style: TextStyle(color: AppColor.grey1, fontSize: 18),
                        ),
                        Text(
                          DateFormat('MM-dd').format(dateTime),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// TimePicker
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: GestureDetector(
                    onTap: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: AppColor.main,
                                onPrimary: AppColor.white,
                                surface: AppColor.background,
                                onSurface: AppColor.grey1,
                              ),
                              dialogBackgroundColor: AppColor.background,
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedTime != null) {
                        setState(() {
                          timeOfDay = pickedTime;
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '시간',
                          style: TextStyle(color: AppColor.grey1, fontSize: 18),
                        ),
                        Text(
                          timeOfDay.format(context),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  widget.destination,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 46),
                DefaultButton(
                    title: '위치공유 시작하기',
                    onTap: () => widget.onTab(dateTime, timeOfDay))
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
