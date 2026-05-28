import 'package:admain_center_managment_app/config/theme/app_theme.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/usecases/classes_useCases/delete_class_useCase.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/classes_screens/update_class_screen.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/pressable_button.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/class_entity.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/class_section_entity.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../../injection_container.dart';
import '../../../widgets/custom_app_bar.dart';
import 'classes_overview_screen.dart';

class ClassProfileScreen extends StatelessWidget {
  const ClassProfileScreen({
    super.key,
    required this.entity,
    required this.sections,
    required this.studyLevel,
  });
  final ClassEntity entity;
  final List<ClassSectionEntity> sections;
  final String studyLevel;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.surface,
        appBar: CustomAppBar(label: "تفاصيل الفصل الدراسى"),

        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 30,
            left: 16,
            right: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroClassCard(
                entity: entity,
                studyLevel: studyLevel,
                sections: sections,
              ),
              SizedBox(height: 24),
              _QuickActions(),
              SizedBox(height: 24),
              _ScheduleSection(sections: sections),
              SizedBox(height: 24),
              _StudentsListSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroClassCard extends StatefulWidget {
  const _HeroClassCard({
    required this.entity,
    required this.studyLevel,
    required this.sections,
  });
  final ClassEntity entity;
  final List<ClassSectionEntity> sections;
  final String studyLevel;

  @override
  State<_HeroClassCard> createState() => _HeroClassCardState();
}

class _HeroClassCardState extends State<_HeroClassCard> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuDnOyuug_nzhSVAjYq_GwbEprVBh6bApor5c3fWXFB2ULpWxZSL2sLXd6wUSXFH5fArHf1HPcyxrR-ArOg58hzIfT2MxebH3wReiGzbifuqxMNOSQ_ZMxw2yem5xTrm3-j-0kJ7n4y93Cv_Zkzbf8KZcwlJFJZ9kk5WQcYK3ZnYjEddGCtPriTFFbD_oa2QdbSgLaUgEd86sp0dPS76D5wH254tSSgCFrmCUmRpZFReLC0wBfOxNGmVDqjZN9byJSW0Hs24IsZrvBVI',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.entity.name,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                    color: AppTheme.onPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.studyLevel,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    color: AppTheme.primaryContainer,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.white.withOpacity(0.1)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.meeting_room,
                        color: AppTheme.onPrimary.withOpacity(0.8),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.entity.room,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppTheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.white.withOpacity(0.1)),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateClassScreen(
                                  entity: widget.entity,
                                  sections: widget.sections,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.2),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.edit, size: 18),
                          label: const Text(
                            'تعديل التفاصيل',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await _deleteClass(widget.entity);
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: AwesomeSnackbarContent(
                                  inMaterialBanner: true,
                                  title: S.of(context).wrongHappened,
                                  message: S.of(context).tryAgainLater,
                                  contentType: ContentType.failure,
                                ),
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                            );
                          } finally {
                            if (mounted) {
                              setState(() => isLoading = false);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.error.withOpacity(0.2),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.all(12),
                          minimumSize: const Size(48, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            Opacity(
                              opacity: isLoading ? 0 : 1,
                              child: const Icon(Icons.delete, size: 20),
                            ),
                            isLoading
                                ? SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      color: AppTheme.onPrimary,
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteClass(ClassEntity entity) async {
    if (isLoading) return;
    setState(() => isLoading = true);
    final result = await sl<DeleteClassUseCase>().call(
      DeleteClassUseCaseParams(entity),
    );
    result.fold(
      ifLeft: (e) {
        throw Exception("Delete has failed");
      },
      ifRight: (response) {
        if (response == null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ClassesOverviewScreen()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: AwesomeSnackbarContent(
                inMaterialBanner: true,
                title: S.of(context).success,
                message: "Class is deleted",
                contentType: ContentType.success,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          );
        } else {
          throw Exception("Delete has failed");
        }
      },
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: AppTheme.onPrimary,
              elevation: 8,
              shadowColor: AppTheme.primary.withOpacity(0.4),
              padding: const EdgeInsets.symmetric(vertical: 19),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.person_add, size: 20),
            label: const Text(
              'إضافة طالب',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.secondaryContainer,
              foregroundColor: AppTheme.onSecondaryContainer,
              elevation: 2,
              shadowColor: Colors.black.withOpacity(0.1),
              padding: const EdgeInsets.symmetric(vertical: 19),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.how_to_reg, size: 20),
            label: const Text(
              'تسجيل الحضور',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ScheduleSection extends StatelessWidget {
  const _ScheduleSection({required this.sections});
  final List<ClassSectionEntity> sections;
  final List<String> days = const [
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد',
  ];

  String getDay(ClassSectionEntity entity) {
    bool isSameDay = entity.startOn.toLocal().day == entity.endOn.toLocal().day;
    if (isSameDay) {
      return days[entity.day];
    } else {
      var day = entity.day;
      return "${days[day]} - ${days[(day + 1 >= days.length) ? 0 : (day + 1)]}";
    }
  }

  String formatDateTimeRange({required DateTime start, required DateTime end}) {
    StringBuffer buffer = StringBuffer();
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    String format(DateTime date) {
      final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
      final minute = twoDigits(date.minute);
      final period = date.hour >= 12 ? "م" : "ص";
      return "$hour:$minute $period";
    }

    buffer.write(format(start).trim());
    buffer.write(" - ");
    buffer.write(format(end).trim());
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'الجدول الزمني',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppTheme.onSurface,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                '3 جلسات أسبوعياً',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  color: AppTheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            children: List.generate(sections.length, (index) {
              final currentItem = sections[index];

              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: _ScheduleCard(
                  day: getDay(currentItem),
                  time: formatDateTimeRange(
                    start: currentItem.startOn.toLocal(),
                    end: currentItem.endOn.toLocal(),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  final String day;
  final String time;

  const _ScheduleCard({required this.day, required this.time});

  @override
  Widget build(BuildContext context) {
    return PressableButton(
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.outlineVariant.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                color: AppTheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: const TextStyle(
                fontSize: 13,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                color: AppTheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StudentsListSection extends StatelessWidget {
  const _StudentsListSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'الطلاب المسجلون',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppTheme.onSurface,
              ),
            ),
            Text(
              '24 طالب',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppTheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: const [
              _StudentItem(
                name: 'أحمد سليم الخالدي',
                id: '2023045',
                isActive: true,
                avatarUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDNmAMRjOeD4zYKaxwKYU-VKwiidBPHC8otOYsxBfgG7URDjrFBg7MsunbBK8eIzMkYOTCDAyEPVPji1Rw1vN0UHzshH-CnV-mf8S27YsOISFwpGLH-zClypIWkI4iWYps95AGNggIe081QBFFAyVTRQEOQd19mWYtrN23tP2tbDHt_YWp-34FK00uO5YtJUvpc9o7s_ImvHVr_gwh-RAnkmSH0Fjx_qgXsM2QB_nIcQNZLS4k8_2CcdZALh-s__M-wjKwnLlFcvhQk',
                avatarBgColor: AppTheme.tertiaryContainer,
              ),
              SizedBox(height: 8),
              _StudentItem(
                name: 'ليلى محمود جابر',
                id: '2023012',
                isActive: false,
                avatarUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAL8-urfpBiG3NvnPjLJoVdLghAxoIY3DxH4GP-VLBX__kQMC-OYqOi7QRccx3fGmBt_a_Maie6rs29cyz6-zwKMBsVjHJTdwVRxqUuQjqvAuMzOrQ9rkeFvYS37YkP5jhlpAUNCmON-flzIruQb9LO3E1M_MWYyiAkRc7yqkNl_EnG3r3BYQkDCa8-wT4bWrEjhPgNr0Bcu35bsI-YvxyMG__Hrypm-f3QiQwn0Kapze9Pr7Nnls63w421mf0x_273FJ5si128aI_K',
                avatarBgColor: AppTheme.secondaryFixed,
              ),
              SizedBox(height: 8),
              _StudentItem(
                name: 'ياسر عبد الرحمن',
                id: '2023089',
                isActive: true,
                initials: 'ي.ع',
                avatarBgColor: AppTheme.primaryFixedDim,
                avatarTextColor: AppTheme.onPrimaryFixed,
              ),
              SizedBox(height: 8),
              _StudentItem(
                name: 'عمر هشام توفيق',
                id: '2023033',
                isActive: true,
                avatarUrl:
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuC97OoIf6KUp1I-koilWnPHakH3KfXQZT8r2ohivsMIhkNnRTAU-hchi3jQReQiW-qFCsaY-nqItK-Ziodbau73Sz_w7KtqGFYGmtqWiV2am0ACgDLJhm-A2P-HF9P7vCQed7ZBJNsw8G0UAKK9syOGvVHJ0Gi-8TXeAVQ8hNPRcOGwfn4i6uZ6Hkdiq0-gbrH20HR1oVJnBsPH5cjDGu87VBgJebAAi4s37VgQ139B0mWh-u5H9AfwKcLO_5jRwXiBBtnn_K4QFgJT',
                avatarBgColor: AppTheme.surfaceContainer,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StudentItem extends StatelessWidget {
  final String name;
  final String id;
  final bool isActive;
  final String? avatarUrl;
  final String? initials;
  final Color avatarBgColor;
  final Color? avatarTextColor;

  const _StudentItem({
    required this.name,
    required this.id,
    required this.isActive,
    this.avatarUrl,
    this.initials,
    required this.avatarBgColor,
    this.avatarTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(8),
        hoverColor: AppTheme.surfaceContainerHigh,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: avatarBgColor,
                      shape: BoxShape.circle,
                      image: avatarUrl != null
                          ? DecorationImage(
                              image: NetworkImage(avatarUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: initials != null
                        ? Text(
                            initials!,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: avatarTextColor ?? Colors.black,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: AppTheme.onSurface,
                        ),
                      ),
                      Text(
                        'رقم أكاديمي: $id',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: AppTheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? Colors.green.shade100
                      : AppTheme.errorContainer.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  isActive ? 'نشط' : 'غائب',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: isActive ? Colors.green.shade700 : AppTheme.error,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
