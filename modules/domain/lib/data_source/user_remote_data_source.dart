import 'package:dartz/dartz.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/error/update_logger_user_error.dart';
import 'package:domain/model/logged_user.dart';
import 'package:domain/model/update_logged_user.dart';
import 'package:domain/model/user.dart';

abstract class UserRemoteDateSource {
  Future<Either<Failure, LoggedUser>> loggedUser();

  Future<Either<Failure, User>> getUserById(String userId);

  Future<Either<Failure<UpdateLoggedUserError>, Unit>> updateUser(UpdateLoggedUser updateLoggedUser);
}
