import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/pressable_button.dart';
import 'package:admain_center_managment_app/core/helper/helper.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/theme/app_theme.dart';

class CreateClassStepTwoScreen extends StatefulWidget {
  const CreateClassStepTwoScreen({super.key});

  @override
  State<CreateClassStepTwoScreen> createState() =>
      _CreateClassStepTwoScreenState();
}

class _CreateClassStepTwoScreenState extends State<CreateClassStepTwoScreen> {
  final List<String> days = [
    'السبت',
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
  ];
  final Set<int> selectedDays = {0, 2};
  Map<int, Map<String, TimeOfDay>> selectedDaysData = {0: {}, 2: {}};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 16,
            bottom: 120,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Step Indicator
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'المرحلة الثانية',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'تحديد الأوقات',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: selectedDaysData.entries
                        .map((e) => Text("  ${days[e.key]}  "))
                        .toList(),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: selectedDaysData.entries.expand((dayEntry) {
                      final dayIndex = dayEntry.key;
                      final times = dayEntry.value;

                      return times.entries.map((timeEntry) {
                        final key = timeEntry.key;
                        final time = timeEntry.value;

                        return Text(
                          '$dayIndex) $key // ${time.format(context)}',
                        );
                      });
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Day Selection Section
              const Text(
                'اختر أيام الأسبوع',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: days.map((day) {
                    int dayIndex = days.indexOf(day);
                    print(dayIndex);
                    final isSelected = selectedDays.contains(dayIndex);
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedDays.remove(dayIndex);
                              selectedDaysData.remove(dayIndex);
                            } else {
                              selectedDays.add(dayIndex);
                              selectedDaysData[dayIndex] = {};
                            }
                          });
                          print(selectedDaysData);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppTheme.primary
                                : AppTheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppTheme.primary.withOpacity(0.2),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ]
                                : [],
                          ),
                          child: Text(
                            day,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : AppTheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),

              // Time Slots Grid
              const Text(
                'تفاصيل الحصص',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),

              // Render cards only for selected days
              ...selectedDays
                  .map(
                    (day) => TimeSlotCard(
                      key: ValueKey(day),
                      dayIndex: day,
                      dayString: days[day],
                      onTapEnd: (timeOfDay) {
                        setState(() {
                          final dayData = selectedDaysData[day] ?? {};

                          selectedDaysData[day] = {
                            ...dayData,
                            'end': timeOfDay,
                          };
                        });
                        print(selectedDaysData);
                      },
                      onTapStart: (timeOfDay) {
                        setState(() {
                          final dayData = selectedDaysData[day] ?? {};

                          selectedDaysData[day] = {
                            ...dayData,
                            'start': timeOfDay,
                          };
                        });
                        print(selectedDaysData);
                      },
                    ),
                  )
                  .toList(),

              const SizedBox(height: 32),
              // Informational Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.secondaryContainer.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info, color: AppTheme.primary, size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'يمكنك تعديل هذه المواعيد لاحقاً من قسم إعدادات الفصل الدراسي في لوحة التحكم.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppTheme.onSecondaryContainer,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Bottom Action Bar
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.surface,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.onSurface.withOpacity(0.06),
                  blurRadius: 32,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 16,
              bottom: MediaQuery.of(context).padding.bottom + 16,
            ),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 8,
                shadowColor: AppTheme.primary.withOpacity(0.2),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'حفظ المواعيد',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.check_circle, size: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TimeSlotCard extends StatelessWidget {
  const TimeSlotCard({
    super.key,
    required this.dayIndex,
    required this.onTapStart,
    required this.onTapEnd,
    required this.dayString,
  });
  final int dayIndex;
  final String dayString;
  final Function(TimeOfDay) onTapStart;
  final Function(TimeOfDay) onTapEnd;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.15)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    dayString,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.schedule, color: AppTheme.outlineVariant),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TimePickerField(
                  // key: UniqueKey(),
                  label: 'وقت البدء',
                  day: dayIndex,
                  isStart: true,
                  onTap: onTapStart,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TimePickerField(
                  // key: UniqueKey(),
                  label: 'وقت الانتهاء',
                  day: dayIndex,
                  isStart: false,
                  onTap: onTapEnd,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TimePickerField extends StatefulWidget {
  const TimePickerField({
    super.key,
    required this.label,
    this.value,
    required this.day,
    required this.isStart,
    this.enable = true,
    required this.onTap,
  });
  final String label;
  final TimeOfDay? value;
  final int day;
  final bool isStart;
  final bool enable;
  final Function(TimeOfDay) onTap;

  @override
  State<TimePickerField> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerField> {
  late TimeOfDay? myValue;
  @override
  void initState() {
    super.initState();
    myValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 12,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        PressableButton(
          onTap: () async {
            final selectedTime = await Helper.pickTime(context);

            if (selectedTime == null || !mounted) return;

            setState(() => myValue = selectedTime);
            print('dddddddddddd& $myValue');

            await widget.onTap(selectedTime);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  myValue == null ? '--' : myValue!.format(context),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.onSurface,
                  ),
                ),
                const Icon(
                  Icons.expand_more,
                  size: 20,
                  color: AppTheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
