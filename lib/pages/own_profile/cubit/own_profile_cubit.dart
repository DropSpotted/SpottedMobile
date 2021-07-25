import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/failure/failure.dart';
import 'package:domain/model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'own_profile_state.dart';
part 'own_profile_cubit.freezed.dart';

class OwnProfileCubit extends Cubit<OwnProfileState> {
  OwnProfileCubit() : super(OwnProfileState.initial());

  Future<void> fetchAccount() async {
    emit(state.copyWith(isProfileLoading: true));

    
    
    emit(state.copyWith(isProfileLoading: true));
  }
}
