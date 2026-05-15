import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/class_repository.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/repository/class_section_repository.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/classes_screens/classes_overview_screen.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/classes_screens/create_class_step_one_screen.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/classes_screens/create_class_step_two_screen.dart';
import 'package:admain_center_managment_app/core/enums/division_enum.dart';
import 'package:admain_center_managment_app/core/providers/create_class_data_provider.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/class_entity.dart';
import 'package:admain_center_managment_app/sync_engine/domain/entities/class_section_entity.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../config/theme/app_theme.dart';
import '../../../../../../core/constants/constants.dart';
import '../../../../../../core/providers/language_provider.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../injection_container.dart';
import '../../../../../../sync_engine/domain/repository/sync_repository.dart';
import '../../../widgets/custom_app_bar.dart';

class CreateClassScreen extends ConsumerStatefulWidget {
  const CreateClassScreen({super.key});

  @override
  ConsumerState<CreateClassScreen> createState() => _CreateClassScreenState();
}

class _CreateClassScreenState extends ConsumerState<CreateClassScreen> {
  final PageController _controller = PageController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  int currentIndex = 0;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(createClassDataProvider.notifier).clearData();
    });
  }

  bool isEqual(DateTime a, DateTime b) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day &&
        a.hour == b.hour &&
        a.minute == b.minute;
  }

  String? isValidClassTimes() {
    final data = ref.read(createClassDataProvider).selectedDaysData;
    if (data == null || data.isEmpty) {
      return "يرجى تحديد حصة واحدة على الأقل.";
    }
    for (var item in data.entries) {
      DateTime? startData = item.value["start"];
      DateTime? endData = item.value["end"];
      if (startData == null || endData == null) {
        return "من فضلك قم بتحديد وقت البداية ووقت النهاية لجميع الأيام التي تم اختيارها.";
      } else if (isEqual(startData, endData)) {
        return "وقت البداية ووقت الانتهاء لا يمكن أن يكونا متساويين.";
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(languageProvider).value;
    ref.listen(createClassDataProvider, (prev, next) {});

    bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return WillPopScope(
      onWillPop: () async {
        ref.read(createClassDataProvider.notifier).clearData();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppTheme.surface,
          appBar: CustomAppBar(
            label: "اضافه فصل ",
            leavingCallback: () {
              // ref.read(createClassDataProvider.notifier).clearData();
            },
          ),
          body: Column(
            children: [
              // Stepper Indicator
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 16.0,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الخطوة 1 من 2',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primary,
                            ),
                          ),
                          AnimatedDefaultTextStyle(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            style: TextStyle(
                              fontSize: currentIndex == 1 ? 13 : 12,
                              fontWeight: currentIndex == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: currentIndex == 1
                                  ? AppTheme.primary
                                  : AppTheme.onSurfaceVariant,
                            ),
                            child: Text('تحديد الأوقات'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0, end: 1),
                            duration: Duration(milliseconds: 300),
                            builder: (context, value, _) {
                              return LinearProgressIndicator(
                                borderRadius: BorderRadius.circular(100),
                                backgroundColor: AppTheme.surfaceContainerHigh,
                                valueColor: AlwaysStoppedAnimation(
                                  AppTheme.primary,
                                ),
                                value: value,
                                minHeight: 6,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TweenAnimationBuilder(
                            tween: Tween<double>(
                              begin: 0,
                              end: currentIndex == 1 ? 1 : 0,
                            ),
                            duration: Duration(milliseconds: 300),
                            builder: (context, value, _) {
                              return LinearProgressIndicator(
                                borderRadius: BorderRadius.circular(100),

                                backgroundColor: AppTheme.surfaceContainerHigh,
                                valueColor: AlwaysStoppedAnimation(
                                  AppTheme.primary,
                                ),
                                value: value,
                                minHeight: 6,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  children: [
                    CreateClassStepOneScreen(
                      nameController: _nameController,
                      placeController: _placeController,
                    ),
                    CreateClassStepTwoScreen(),
                  ],
                ),
              ),
            ],
          ),
          bottomSheet: !isKeyboardOpen
              ? Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppTheme.surface,
                        AppTheme.surface.withOpacity(0.9),
                        AppTheme.surface.withOpacity(0.0),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        final data = ref.read(createClassDataProvider);
                        if (_nameController.text.trim().isEmpty) {
                          if (currentIndex == 1) {
                            _controller.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: AwesomeSnackbarContent(
                                inMaterialBanner: true,
                                title: S.of(context).unCompleteDetails,
                                message: "اسم الفصل مطلوب.",
                                contentType: ContentType.failure,
                              ),

                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                          );
                        } else if (_placeController.text.trim().isEmpty) {
                          if (currentIndex == 1) {
                            _controller.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: AwesomeSnackbarContent(
                                inMaterialBanner: true,
                                title: S.of(context).unCompleteDetails,
                                message: "مكان الفصل مطلوب.",
                                contentType: ContentType.failure,
                              ),

                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                          );
                        } else if (isValidClassTimes() != null) {
                          if (currentIndex == 0) {
                            _controller.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                          if (ref
                              .read(createClassDataProvider)
                              .isUserVisitSecondScreen) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: AwesomeSnackbarContent(
                                  inMaterialBanner: true,
                                  title: S.of(context).informationNotCorrect,
                                  message: isValidClassTimes()!,
                                  contentType: ContentType.failure,
                                ),

                                backgroundColor: Colors.transparent,
                                elevation: 0,
                              ),
                            );
                          }
                        } else {
                          if (currentIndex == 0) {
                            _controller.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            await _createClass();
                          }
                        }
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
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 8,
                      shadowColor: AppTheme.primary.withOpacity(0.4),
                    ),
                    child: addButtonContent(),
                  ),
                )
              : null,
        ),
      ),
    );
  }

  void _showError(String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AwesomeSnackbarContent(
          inMaterialBanner: true,
          title: title,
          message: message,
          contentType: ContentType.failure,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  Future<void> _createClass() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    try {
      final data = ref.read(createClassDataProvider);
      final uuid = Uuid();
      final deviceIdResult = await sl<SyncRepository>().getDeviceId();
      final deviceId = deviceIdResult.getOrThrow();

      final classId = uuid.v4();
      print('================================>1 ');
      final newEntity = ClassEntity(
        entityId: classId,
        centerId: currentCenter.entityId,
        byUser: currentUserId,
        byDevice: deviceId,
        isDeleted: false,
        version: 1,
        createdAt: DateTime.now().toUtc(),
        updatedAt: DateTime.now().toUtc(),
        name: _nameController.text.trim(),
        room: _placeController.text.trim(),
        divisionEnum: data.divisionEnum ?? DivisionEnum.generalDivision,
        semester: data.semester,
        studyLevelId: data.levelId?.entityId ?? studyLevels.first.entityId,
      );
      print('================================>2 ');

      final addResult = await sl<ClassRepository>().createClass(newEntity);
      print('================================>3');

      await addResult.fold(
        ifLeft: (failuer) {
          print('================================> $failuer');

          _showError(S.of(context).wrongHappened, S.of(context).tryAgainLater);
        },
        ifRight: (response) async {
          print('4================================> $response');

          if (response == null) {
            await _createClassSections(classId);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ClassesOverviewScreen()),
            );
            _showSuccess("Class is created");
          } else {
            _showError(
              S.of(context).wrongHappened,
              S.of(context).tryAgainLater,
            );
          }
        },
      );
    } catch (_) {
      _showError(S.of(context).wrongHappened, S.of(context).tryAgainLater);
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _createClassSections(String classId) async {
    final data = ref.read(createClassDataProvider);
    final uuid = Uuid();
    final deviceIdResult = await sl<SyncRepository>().getDeviceId();
    final deviceId = deviceIdResult.getOrThrow();
    print('5================================> ');
    print(data.selectedDaysData!.entries);
    for (final item in data.selectedDaysData!.entries) {
      final sectionId = uuid.v4();

      final newSection = ClassSectionEntity(
        entityId: sectionId,
        centerId: currentCenter.entityId,
        byUser: currentUserId,
        byDevice: deviceId,
        isDeleted: false,
        version: 1,
        createdAt: DateTime.now().toUtc(),
        updatedAt: DateTime.now().toUtc(),
        startOn: item.value["start"]!.toUtc(),
        endOn: item.value["end"]!.toUtc(),
        day: item.key,
        classId: classId,
      );
      print('12================================> ');

      final result = await sl<ClassSectionRepository>().createClassSection(
        newSection,
      );
      print('6================================> ');

      result.fold(
        ifLeft: (value) {
          print('7================================> $value');

          _showError(S.of(context).wrongHappened, S.of(context).tryAgainLater);
          throw Exception("Failed creating section");
        },
        ifRight: (value) {
          print('7================================> $value');

          if (value != null) {
            _showError(
              S.of(context).wrongHappened,
              S.of(context).tryAgainLater,
            );
            throw Exception("Failed creating section");
          }
        },
      );
    }
  }

  String? _validateInputs() {
    if (_nameController.text.trim().isEmpty) {
      return "اسم الفصل مطلوب.";
    }

    if (_placeController.text.trim().isEmpty) {
      return "مكان الفصل مطلوب.";
    }

    final timeError = isValidClassTimes();
    if (timeError != null) {
      return timeError;
    }

    return null;
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AwesomeSnackbarContent(
          inMaterialBanner: true,
          title: S.of(context).success,
          message: message,
          contentType: ContentType.success,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  Widget addButtonContent() {
    Widget subWidget = (currentIndex == 0)
        ? const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'التالي: تحديد المواعيد',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward),
            ],
          )
        : const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'إضافة حصة',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(width: 8),
              Icon(Icons.check_circle, size: 20),
            ],
          );

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Opacity(opacity: isLoading ? 0 : 1, child: subWidget),
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
    );
  }
}
