import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/profile/cubit/profile_state.dart';
import 'package:news_app/features/profile/data/services/profile_firebase_service.dart';
import 'package:news_app/utils/data/failure/failure.dart';
import 'package:news_app/utils/data/models/user.dart';


class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(BuildContext context) => BlocProvider.of(context);

  final profileFirebaseService = ProfileFirebaseService();
  late User user;

  Future<void> getUser() async {
    emit(ProfileLoading());
    try {
      user = await profileFirebaseService.getUser();
      emit(GetUserSuccess());
    } catch (e) {
      emit(GetUserError(Failure.fromException(e).message));
    }
  }
  Future<void> updateUser(User updatedUser) async {
    emit(UpdateUserLoading());
    try {
      await profileFirebaseService.updateUser(updatedUser);
      emit(UpdateUserSuccess());
    } catch (e) {
      emit(UpdateUserError(Failure.fromException(e).message));
    }
  }
}
