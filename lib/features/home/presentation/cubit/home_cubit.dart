// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:proo/features/home/data/models/home/home.dart';
import 'package:proo/features/home/data/repositories/repo_impl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeModel homeModel;
  final RepoImpl repoimpl;
  HomeCubit(this.homeModel, this.repoimpl) : super(HomeInitial());
  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    var result = await repoimpl.getHomeData();
    result.fold(
      (l) => emit(HomeError(l)),
      (r) => emit(HomeLoaded(r)),
    );
  }
}
