import 'package:admain_center_managment_app/contexts/center_management_context/domain/entities/guardian_entity.dart';
import 'package:admain_center_managment_app/core/error/failure.dart';
import 'package:dart_either/dart_either.dart';

abstract class GuardianRepository {
  Future<Either<Failure, void>> createGuardian(
    GuardianEntity model,
    String studentId,
  );
  Future<Either<Failure, void>> updateGuardian(GuardianEntity newModel);
  Future<Either<Failure, void>> softDeleteGuardian(String entityId);
  Future<Either<Failure, void>> hardDeleteGuardian(String entityId);
  Future<Either<Failure, List<GuardianEntity>>> getAllStudentGuardians(
    String studentId,
  );
  Future<Either<Failure, GuardianEntity?>> getStudentGuardian(String entityId);
}
