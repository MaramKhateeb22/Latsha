abstract class EditReverseState {}

class EditReverseInitalState extends EditReverseState {}

class EditReverseLoadingState extends EditReverseState {}

class EditReverseSuccessState extends EditReverseState {}

class EditReverseErrorState extends EditReverseState {
  final String error;

  EditReverseErrorState({required this.error});
}

class SelectImageState extends EditReverseState {}

class ClearFormState extends EditReverseState {}
