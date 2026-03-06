import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/student_entity.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/bloc/student_bloc/student_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainStudentContainer extends StatelessWidget {
  final StudentEntity studentEntity;
  const MainStudentContainer({required this.studentEntity, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('id :  ${studentEntity.entityId}'),
        Text('studyLevelId :  ${studentEntity.studyLevelId}'),
        Text('joinDate :  ${studentEntity.joinDate.toLocal()}'),
        Text('name :  ${studentEntity.name}'),
        TextButton(
          onPressed: () {
            context.read<StudentBloc>().add(
              SoftDeleteStudentEvent(entityId: studentEntity.entityId),
            );
          },
          child: Text('Delete'),
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.red),
          ),
        ),
      ],
    );
  }
}
