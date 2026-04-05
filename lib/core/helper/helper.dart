import 'package:admain_center_managment_app/config/theme/colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../config/theme/app_theme.dart';
import '../../sync_engine/domain/entities/standard_table_record.dart';
import '../enums/DB_Table.dart';
import '../error/netwrok_response.dart';

class ParsedPhone {
  String countryCode;
  String phone;

  ParsedPhone({required this.countryCode, required this.phone});
  @override
  String toString() {
    return "$countryCode $phone";
  }
}

class Helper {
  static Future<String?> showCustomDialog(
    BuildContext context,
    String? initialValue,
    String label,
  ) async {
    final String? outPut;
    final TextEditingController controller = TextEditingController(
      text: initialValue,
    );
    final _formKey = GlobalKey<FormState>();

    outPut = await showDialog<String?>(
      context: context,
      builder: (context) {
        return Container(
          width: 350,
          padding: EdgeInsets.all(16),
          child: AlertDialog(
            title: Align(
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "الوظيفة",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: AppTheme.surfaceContainerLowest,
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: () {}, child: Text("الغاء")),

              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    controller.text != initialValue
                        ? controller.text.trim()
                        : null,
                  );
                },
                child: Text("تأكيد"),
              ),
            ],
          ),
        );
      },
    );
    return outPut;
  }

  static Future<String?> showEmailDialog(
    BuildContext context,
    String? initialEmail,
    String label,
  ) async {
    final String? outPut;
    final TextEditingController emailController = TextEditingController(
      text: initialEmail,
    );
    final _formKey = GlobalKey<FormState>();

    outPut = await showDialog<String?>(
      context: context,
      builder: (context) {
        return Container(
          width: 350,
          padding: EdgeInsets.all(16),
          child: AlertDialog(
            title: Align(
              alignment: Alignment.center,
              child: Text(
                label,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "example@email.com",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: AppTheme.surfaceContainerLowest,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }

                  // Regex for email validation
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );

                  if (!emailRegex.hasMatch(value)) {
                    return "Enter a valid email";
                  }

                  return null;
                },
              ),
            ),
            actions: [
              TextButton(onPressed: () {}, child: Text("الغاء")),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String email = emailController.text.trim();

                    print("Email: $email");

                    Navigator.pop(
                      context,
                      email != initialEmail ? email : null,
                    );
                  }
                },
                child: Text("تأكيد"),
              ),
            ],
          ),
        );
      },
    );
    return outPut;
  }

  static Future<String?> showPhoneDialog(
    BuildContext context,
    String? fullPhone,
    String label,
  ) async {
    TextEditingController phoneController = TextEditingController();
    String? countryCode = "+20";
    String? outPut;
    if (fullPhone != null && fullPhone.isNotEmpty) {
      final parsed = parsePhone(fullPhone);
      phoneController = TextEditingController(text: parsed.phone);
      countryCode = parsed.countryCode;
    }
    outPut = await showDialog<String?>(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 350,
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  children: [
                    CountryCodePicker(
                      initialSelection: countryCode, // 👈 مهم
                      onChanged: (code) {
                        countryCode = code.dialCode!;
                      },
                    ),

                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppTheme.surfaceContainerLowest,
                        ),
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("الغاء"),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {
                        String finalPhone =
                            "$countryCode ${phoneController.text}";
                        Navigator.pop(
                          context,
                          phoneController.text.isNotEmpty ? finalPhone : null,
                        );
                      },
                      child: Text("تأكيد"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    return outPut;
  }

  static ParsedPhone parsePhone(String fullPhone) {
    String countryCode = "+20"; // default
    String phone = fullPhone;

    if (fullPhone.contains(" ")) {
      // 👈 لو فيه space
      List parts = fullPhone.split(" ");
      countryCode = parts.first;
      phone = parts.sublist(1).join("");
    } else if (fullPhone.startsWith("+")) {
      // 👈 لو مفيش space
      // نفترض كود الدولة أول 3 أرقام (زي +20)
      countryCode = fullPhone.substring(0, 3);
      phone = fullPhone.substring(3);
    }

    return ParsedPhone(countryCode: countryCode, phone: phone);
  }

  static Iterable<List<T>> chunk<T>(List<T> list, int size) sync* {
    for (int i = 0; i < list.length; i += size) {
      yield list.sublist(i, i + size > list.length ? list.length : i + size);
    }
  }

  static String formatNumber(int number) {
    if (number >= 10000) {
      return NumberFormat.compact().format(number);
    } else {
      return NumberFormat('#,###').format(number);
    }
  }

  static Future<StandardTableRecord?> getParentId(
    BuildContext context,
    List<StandardTableRecord> data,
  ) async {
    final formKey = GlobalKey<FormState>();

    StandardTableRecord? tableEntity;

    final result = await showDialog<StandardTableRecord?>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text(" Get parent"),
              content: SizedBox(
                width: 400,
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        /// المرحلة التعليمية
                        DropdownButtonFormField<StandardTableRecord>(
                          decoration: const InputDecoration(
                            labelText: "المرحلة التعليمية",
                          ),
                          items: data
                              .map<DropdownMenuItem<StandardTableRecord>>((
                                entity,
                              ) {
                                return DropdownMenuItem(
                                  value: entity,
                                  child: Column(
                                    children: [Text(entity.entityId)],
                                  ),
                                );
                              })
                              .toList(),
                          onChanged: (value) {
                            tableEntity = value;
                          },
                          validator: (value) =>
                              value == null ? "Chose one" : null,
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
                      Navigator.pop(context, tableEntity);
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

  static Future<String?> showAddRecordDialog(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    String name = '';

    final result = await showDialog<String?>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("إضافة record"),
              content: SizedBox(
                width: 400,
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        /// الاسم
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Message",
                          ),
                          validator: (value) => value == null || value.isEmpty
                              ? "ادخل Message"
                              : null,
                          onSaved: (value) => name = value!,
                        ),

                        const SizedBox(height: 10),
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
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      Navigator.pop(context, name);
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

  static Future<bool?> confDeletion(
    BuildContext context,
    DBTable startTable,
    String startEntity,
    Map<DBTable, List<String>> deletedEntities,
  ) async {
    List<Widget> relationDeletedWidgets() {
      List<Text> list = [];
      for (var item in deletedEntities.entries) {
        list.add(Text('${item.key.name} -=> ${item.value}'));
      }
      return list;
    }

    final formKey = GlobalKey<FormState>();

    final result = await showDialog<bool?>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Delete a record"),
              content: SizedBox(
                width: 400,
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text('delete $startEntity in ${startTable.name}'),
                        Text('and those will be deleted'),
                        Column(children: relationDeletedWidgets()),

                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context, true);
                  },
                  child: const Text("Ok"),
                ),
              ],
            );
          },
        );
      },
    );
    return result;
  }

  static Map<String, List<String>> cleanParentIds(
    Map<String, dynamic> parentIds,
  ) {
    final Map<String, List<String>> result = {};

    parentIds.forEach((table, ids) {
      final List<String> cleanedIds = [];
      for (final id in ids as List) {
        // Remove _deleted or _not_found suffix
        String cleanId = id.toString();
        if (cleanId.endsWith('_deleted')) {
          cleanId = cleanId.replaceAll('_deleted', '');
        }
        if (cleanId.endsWith('_not_found')) {
          cleanId = cleanId.replaceAll('_not_found', '');
        }
        cleanedIds.add(cleanId);
      }
      result[table] = cleanedIds;
    });

    return result;
  }

  static NetworkResponse handleSyncOperationResponse(
    Map<String, dynamic> json,
  ) {
    final message = json['message'];
    switch (message) {
      case 'parent_is_deleted':
        return ParentIsDeleted(json['parent_ids'] as Map<String, dynamic>);
      case 'entity_not_found':
        return EntityIsNotFound(data: json);
      case 'Operation already processed':
        return OperationAlreadyProcessed();
      case 'entity_is_deleted':
        return EntityIsDeleted(data: json);
      case 'version_conflict':
        return VersionConflict(
          data: json['server_record'] as Map<String, dynamic>,
        );
      case 'internal_server_error':
        return InternalServerError(details: json['error']);
      case null: // success case
        return NetworkSuccess();
      default:
        return NetworkFailure(details: message, data: json);
    }
  }

  static Future<String?> login(String email, String password) async {
    final supabase = Supabase.instance.client;

    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.session != null) {
      print("Login Success");
      return response.session!.accessToken;
    } else {
      print("Login Failed");
      return null;
    }
  }
}
