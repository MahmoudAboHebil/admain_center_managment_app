import 'package:admain_center_managment_app/contexts/center_management_context/presentation/bloc/student_bloc/student_bloc.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/bloc/student_bloc/student_event.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/bloc/student_bloc/student_state.dart';
import 'package:admain_center_managment_app/contexts/center_management_context/presentation/widgets/main_student_container.dart';
import 'package:admain_center_managment_app/core/constants/constants.dart';
import 'package:admain_center_managment_app/core/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({super.key});

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  void initState() {
    super.initState();
    context.read<StudentBloc>().add(GetAllStudentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Students")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final student = await Helper.showAddStudentDialog(
            context,
            studyLevels,
          );
          if (student != null) {
            context.read<StudentBloc>().add(
              CreateStudentEvent(entity: student),
            );
          }
        },
      ),
      body: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          if (state is StudentDone) {
            if (state.studentEntities == null ||
                (state.studentEntities?.isEmpty ?? true)) {
              return Text(
                'There is no students yet',
                style: TextStyle(fontSize: 28),
              );
            } else {
              return ListView.builder(
                itemCount: state.studentEntities?.length ?? 0,
                itemBuilder: (context, index) {
                  return MainStudentContainer(
                    studentEntity: state.studentEntities![index],
                  );
                },
              );
            }
          }
          if (state is StudentError) {
            return Text(
              'Error => ${state.error}',
              style: TextStyle(fontSize: 28),
            );
          }
          print('xxxxxxxxxxxxxxxxx ${state.runtimeType}');
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
