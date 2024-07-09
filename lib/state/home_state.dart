import '../models/story_model.dart';

sealed class HomeState {}

class HomeStateInitial extends HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateError extends HomeState {
  final String errorMessage;

  HomeStateError(this.errorMessage);
}

class HomeStateSuccess extends HomeState {
  final List<StoryModel> stories;

  HomeStateSuccess(this.stories);
}
