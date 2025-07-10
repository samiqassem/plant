import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/profile_response.dart';
import '../repo/profile_repo.dart';
import 'profile__state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository repository;

  ProfileCubit({required this.repository}) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final profileResponse = await repository.getProfile();
      emit(ProfileLoaded(profileResponse));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}
