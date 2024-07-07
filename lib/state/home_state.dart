import '../models/story_model.dart';

abstract class HomeState {}

class HomeStateInitial extends HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateError extends HomeState {
  final String errorMessage;

  HomeStateError(this.errorMessage);
}

class HomeStateSuccess extends HomeState {
  final List<Story> stories;

  HomeStateSuccess(this.stories);
}
