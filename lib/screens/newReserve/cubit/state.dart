abstract class AddReverseState {}

class AddReverseInitalState extends AddReverseState {}

class AddReverseLoadingState extends AddReverseState {}

class AddReverseSuccessState extends AddReverseState {}

class AddReverseErrorState extends AddReverseState {
  final String error;

  AddReverseErrorState({required this.error});
}

class SelectImageState extends AddReverseState {}

class ClearFormState extends AddReverseState {}
