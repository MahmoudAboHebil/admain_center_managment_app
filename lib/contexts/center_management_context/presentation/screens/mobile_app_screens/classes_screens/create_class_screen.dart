import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/classes_screens/create_class_step_one_screen.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/screens/mobile_app_screens/classes_screens/create_class_step_two_screen.dart';
import 'package:admain_center_managment_app/core/providers/create_class_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../config/theme/app_theme.dart';
import '../../../../../../core/providers/language_provider.dart';
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

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(createClassDataProvider.notifier).clearData();
    });
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
                    onPressed: () {
                      if (currentIndex == 0) {
                        _controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        final data = ref.read(createClassDataProvider);
                        print('name : ${_nameController.text}');
                        print('place : ${_placeController.text}');
                        print(data);
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
                    child: (currentIndex == 0)
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'التالي: تحديد المواعيد',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
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
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.check_circle, size: 20),
                            ],
                          ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
