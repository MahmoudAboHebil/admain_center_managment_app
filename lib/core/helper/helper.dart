import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/student_entity.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/study_level_entity.dart';
import 'package:admain_center_managment_app/core/constants/constants.dart';
import 'package:admain_center_managment_app/core/enums/gender_enum.dart';
import 'package:admain_center_managment_app/core/enums/student_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Helper {
  static Future<StudentEntity?> showAddStudentDialog(
    BuildContext context,
    List<StudyLevelEntity> studyLevels,
  ) async {
    final formKey = GlobalKey<FormState>();

    String? studyLevelId;
    String name = '';
    String? phone;
    String? homePhone;
    String? whatsAppPhone;
    String schoolName = '';
    Gender? gender;
    DateTime? birthDate;

    final result = await showDialog<StudentEntity?>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("إضافة طالب"),
              content: SizedBox(
                width: 400,
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        /// المرحلة التعليمية
                        DropdownButtonFormField<StudyLevelEntity>(
                          decoration: const InputDecoration(
                            labelText: "المرحلة التعليمية",
                          ),
                          items: studyLevels
                              .map(
                                (level) => DropdownMenuItem(
                                  value: level,
                                  child: Text(level.arabicName),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            studyLevelId = value?.entityId;
                          },
                          validator: (value) =>
                              value == null ? "اختر المرحلة التعليمية" : null,
                        ),

                        /// الاسم
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "اسم الطالب",
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? "ادخل الاسم"
                              : null,
                          onSaved: (value) => name = value!,
                        ),

                        const SizedBox(height: 10),

                        /// تاريخ الميلاد
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: "تاريخ الميلاد",
                            suffixIcon: const Icon(Icons.calendar_today),
                          ),
                          controller: TextEditingController(
                            text: birthDate == null
                                ? ""
                                : "${birthDate!.day}/${birthDate!.month}/${birthDate!.year}",
                          ),
                          validator: (_) =>
                              birthDate == null ? "اختر تاريخ الميلاد" : null,
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2015),
                              firstDate: DateTime(1990),
                              lastDate: DateTime.now(),
                            );

                            if (picked != null) {
                              setState(() {
                                birthDate = picked;
                              });
                            }
                          },
                        ),

                        const SizedBox(height: 10),

                        /// رقم الموبايل
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "رقم الموبايل",
                          ),
                          keyboardType: TextInputType.phone,
                          onSaved: (value) => phone = value,
                        ),

                        /// رقم المنزل
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "رقم المنزل",
                          ),
                          keyboardType: TextInputType.phone,
                          onSaved: (value) => homePhone = value,
                        ),

                        const SizedBox(height: 10),

                        /// واتساب
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "رقم واتساب",
                          ),
                          keyboardType: TextInputType.phone,
                          onSaved: (value) => whatsAppPhone = value,
                        ),

                        const SizedBox(height: 10),

                        /// اسم المدرسة
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "اسم المدرسة",
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? "ادخل اسم المدرسة"
                              : null,
                          onSaved: (value) => schoolName = value!,
                        ),

                        const SizedBox(height: 10),

                        /// النوع
                        DropdownButtonFormField<Gender>(
                          decoration: const InputDecoration(labelText: "النوع"),
                          items: const [
                            DropdownMenuItem(
                              value: Gender.male,
                              child: Text("ذكر"),
                            ),
                            DropdownMenuItem(
                              value: Gender.female,
                              child: Text("أنثى"),
                            ),
                          ],
                          onChanged: (value) => gender = value,
                          validator: (value) =>
                              value == null ? "اختر النوع" : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("إلغاء"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      final student = {
                        "studyLevelId": studyLevelId,
                        "name": name,
                        "birthDate": birthDate,
                        "phone": phone,
                        "schoolName": schoolName,
                        "gender": gender,
                      };
                      final uuid = Uuid();
                      final newStudent = StudentEntity(
                        entityId: uuid.v4(),
                        centerId: currentCenter.entityId,
                        byUser: currentUserId,
                        byDevice: currentDevice,
                        isDeleted: false,
                        version: 1,
                        createdAt: DateTime.now().toUtc(),
                        updatedAt: DateTime.now().toUtc(),
                        studyLevelId: studyLevelId!,
                        name: name,
                        schoolName: schoolName,
                        gender: gender!,
                        birthDate: birthDate!.toUtc(),
                        joinDate: DateTime.now().toUtc(),
                        studentStatus: StudentStatus.inactive,
                        whatsAppPhone: whatsAppPhone,
                        phone: phone,
                        homePhone: homePhone,
                      );

                      print(student);

                      Navigator.pop(context, newStudent);
                    }
                  },
                  child: const Text("حفظ"),
                ),
              ],
            );
          },
        );
      },
    );
    return result;
  }
}
