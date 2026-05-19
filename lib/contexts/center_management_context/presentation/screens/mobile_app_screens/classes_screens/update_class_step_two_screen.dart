import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/pressable_button.dart';
import 'package:admain_center_managment_app/core/helper/helper.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/class_section_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../config/theme/app_theme.dart';
import '../../../../../../core/providers/create_class_data_provider.dart';

class UpdateClassStepTwoScreen extends ConsumerStatefulWidget {
  const UpdateClassStepTwoScreen({required this.entities, super.key});
  final List<ClassSectionEntity> entities;

  @override
  ConsumerState<UpdateClassStepTwoScreen> createState() =>
      _CreateClassStepTwoScreenState();
}

class _CreateClassStepTwoScreenState
    extends ConsumerState<UpdateClassStepTwoScreen>
    with AutomaticKeepAliveClientMixin {
  final List<String> days = [
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد',
  ];
  Set<int> selectedDays = {};
  Map<int, Map<String, DateTime>> selectedDaysData = {};

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    for (var item in widget.entities) {
      selectedDays.add(item.day);
      selectedDaysData[item.day] = {};
      selectedDaysData[item.day]?["start"] = item.startOn.toLocal();
      selectedDaysData[item.day]?["end"] = item.endOn.toLocal();
    }
    Future.microtask(() {
      ref
          .read(createClassDataProvider.notifier)
          .updateIsUserVisitSecondScreen(true);
      ref
          .read(createClassDataProvider.notifier)
          .updateSelectedDaysData(selectedDaysData);
    });
  }

  bool isSameDay(DateTime? start, DateTime? end) {
    if (start == null || end == null) return true;
    return start.year == end.year &&
        start.month == end.month &&
        start.day == end.day;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 16,
            bottom: 100,
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
                      color: Colors.black,
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
                          '$dayIndex) $key // ${time.toIso8601String()}',
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
                          ref
                              .read(createClassDataProvider.notifier)
                              .updateSelectedDaysData(selectedDaysData);

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
                      startTime: selectedDaysData[day]?["start"]?.toLocal(),
                      endTime: selectedDaysData[day]?["end"]?.toLocal(),
                      key: ValueKey(day),
                      dayIndex: day,
                      dayString:
                          !isSameDay(
                            selectedDaysData[day]?["start"],
                            selectedDaysData[day]?["end"],
                          )
                          ? "${days[day]} - ${days[day + 1]}"
                          : days[day],
                      onTapEnd: (timeOfDay) {
                        setState(() {
                          final dayData = selectedDaysData[day] ?? {};

                          selectedDaysData[day] = {
                            ...dayData,
                            'end': timeOfDay,
                          };
                        });
                        ref
                            .read(createClassDataProvider.notifier)
                            .updateSelectedDaysData(selectedDaysData);

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
                        ref
                            .read(createClassDataProvider.notifier)
                            .updateSelectedDaysData(selectedDaysData);
                      },
                    ),
                  )
                  .toList(),

              const SizedBox(height: 16),
              // Informational Banner
              Container(
                height: 135,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage("assets/editImage.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppTheme.primary.withOpacity(0.8),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.bottomRight,
                  child: const Text(
                    'تأكد من مراجعة تفاصيل القاعة والجداول الزمنية قبل الحفظ لتجنب التضارب الدراسي.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TimeSlotCard extends StatefulWidget {
  const TimeSlotCard({
    super.key,
    required this.dayIndex,
    required this.onTapStart,
    required this.onTapEnd,
    required this.dayString,
    this.startTime,
    this.endTime,
  });
  final int dayIndex;
  final String dayString;
  final Function(DateTime) onTapStart;
  final Function(DateTime) onTapEnd;
  final DateTime? startTime;
  final DateTime? endTime;

  @override
  State<TimeSlotCard> createState() => _TimeSlotCardState();
}

class _TimeSlotCardState extends State<TimeSlotCard> {
  late DateTime? startTime;
  late DateTime? endTime;
  bool startError = false;
  bool endError = false;
  String? error;
  @override
  void initState() {
    super.initState();
    startTime = widget.startTime;
    endTime = widget.endTime;
  }

  DateTime combine(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  DateTime normalizeEnd(DateTime start, DateTime end) {
    if (end.isBefore(start)) {
      return end.add(Duration(days: 1));
    }
    return end;
  }

  bool isValidTimeRange({required DateTime start, required DateTime end}) {
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;

    // same time is not allowed
    if (startMinutes == endMinutes) {
      return false;
    }

    return true; // everything else is valid
  }

  bool validationStart() {
    bool isOk = true;
    if (endTime == null) {
      endError = true;
      // error = 'يجب تحديد وقت الانتهاء';
      isOk = false;
    } else {
      if (!isValidTimeRange(start: startTime!, end: endTime!)) {
        endError = true;
        error = "وقت البداية ووقت الانتهاء لا يمكن أن يكونا متساويين.";
        isOk = false;
      } else {
        endError = false;
        startError = false;

        error = null;
        isOk = true;
      }
    }

    setState(() {});

    return isOk;
  }

  bool validationEnd() {
    bool isOk = true;
    if (startTime == null) {
      startError = true;
      // error = 'يجب تحديد وقت البدء';
      isOk = false;
    } else {
      if (!isValidTimeRange(start: startTime!, end: endTime!)) {
        endError = true;
        error = "وقت البداية ووقت الانتهاء لا يمكن أن يكونا متساويين.";
        isOk = false;
      } else {
        endError = false;
        startError = false;
        error = null;
        isOk = true;
      }
    }
    setState(() {});
    return isOk;
  }

  String getClassDuration({required DateTime? start, required DateTime? end}) {
    if (start == null || end == null) return "";
    int startMinutes = start.hour * 60 + start.minute;
    int endMinutes = end.hour * 60 + end.minute;

    // handle crossing midnight
    if (endMinutes < startMinutes) {
      endMinutes += 24 * 60;
    }

    int totalMinutes = endMinutes - startMinutes;

    int hours = totalMinutes ~/ 60;
    int minutes = totalMinutes % 60;

    return formatDuration(hours, minutes);
  }

  String formatDuration(int hours, int minutes) {
    final buffer = StringBuffer();

    if (hours > 0) {
      buffer.write('${hours}h');
    }

    if (minutes > 0) {
      if (hours > 0) buffer.write(' ');
      buffer.write('${minutes}m');
    }

    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return PressableButton(
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                      widget.dayString,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Text(
                  getClassDuration(start: startTime, end: endTime),
                  style: TextStyle(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
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
                    day: widget.dayIndex,
                    isError: startError,
                    value: startTime != null
                        ? TimeOfDay(
                            hour: startTime!.hour,
                            minute: startTime!.minute,
                          )
                        : null,
                    isStart: true,
                    onTap: (start) {
                      DateTime newDate = combine(DateTime.now(), start);
                      startTime = newDate;
                      validationStart();
                      widget.onTapStart(newDate);
                      if (endTime != null) {
                        endTime = DateTime.now().copyWith(
                          minute: endTime!.minute,
                          hour: endTime!.hour,
                        );
                        final DateTime newDate = normalizeEnd(
                          startTime!,
                          endTime!,
                        );
                        endTime = newDate;
                        print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
                        print(endTime);
                        widget.onTapEnd(newDate);
                        setState(() {});
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TimePickerField(
                    // key: UniqueKey(),
                    label: 'وقت الانتهاء',
                    day: widget.dayIndex,
                    isError: endError,
                    value: endTime != null
                        ? TimeOfDay(
                            hour: endTime!.hour,
                            minute: endTime!.minute,
                          )
                        : null,
                    isStart: false,
                    onTap: (end) {
                      final DateTime newDate;
                      if (startTime == null) {
                        newDate = combine(DateTime.now(), end);
                      } else {
                        startTime = DateTime.now().copyWith(
                          minute: startTime!.minute,
                          hour: startTime!.hour,
                        );

                        newDate = normalizeEnd(
                          startTime!,
                          combine(DateTime.now(), end),
                        );
                        print('dddddddddddddd');
                        print(newDate);
                      }
                      endTime = newDate;
                      validationEnd();
                      widget.onTapEnd(newDate);
                    },
                  ),
                ),
              ],
            ),
            if (error != null)
              Padding(
                padding: EdgeInsets.only(top: 14),
                child: Text(
                  error!,
                  style: const TextStyle(fontSize: 12, color: AppTheme.error),
                ),
              ),
          ],
        ),
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
    required this.isError,
  });
  final String label;
  final TimeOfDay? value;
  final int day;
  final bool isStart;
  final bool enable;
  final bool isError;
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
            final selectedTime = await Helper.pickTime(context, myValue);

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
              border: widget.isError ? Border.all(color: AppTheme.error) : null,
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
