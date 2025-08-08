part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState {
  final HomeModel homeData; 
  const HomeLoaded(this.homeData);
  @override
  List<Object> get props => [homeData];
}
class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);
  
  @override
  List<Object> get props => [message];
}