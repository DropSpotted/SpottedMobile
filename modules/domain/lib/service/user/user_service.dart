import 'package:dartz/dartz.dart';
import 'package:domain/data_source/user_remote_data_source.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/error/update_logger_user_error.dart';
import 'package:domain/model/logged_user.dart';
import 'package:domain/model/update_logged_user.dart';
import 'package:domain/model/user.dart';

abstract class UserService {
  Future<Either<Failure, LoggedUser>> loggedUser();

  Future<Either<Failure, User>> getUserById(String userId);

  Future<Either<Failure<UpdateLoggedUserError>, Unit>> updateUser(UpdateLoggedUser updateLoggedUser);
}

class UserServiceImpl implements UserService {
  UserServiceImpl({
    required UserRemoteDateSource userRemoteDataSource,
  }) : _userRemoteDataSource = userRemoteDataSource;

  final UserRemoteDateSource _userRemoteDataSource;

  @override
  Future<Either<Failure, User>> getUserById(String userId) async {
    return _userRemoteDataSource.getUserById(userId);
  }

  @override
  Future<Either<Failure, LoggedUser>> loggedUser() async {
    return _userRemoteDataSource.loggedUser();
  }

  @override
  Future<Either<Failure<UpdateLoggedUserError>, Unit>> updateUser(UpdateLoggedUser updateLoggedUser) async {
    return _userRemoteDataSource.updateUser(updateLoggedUser);
  }
}
