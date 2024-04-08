abstract class AddReportState {}

class AddReportInitalState extends AddReportState {}

class AddReportLoadingState extends AddReportState {}

class AddReportSuccessState extends AddReportState {}

class AddReportErrorState extends AddReportState {
  final String error;

  AddReportErrorState({required this.error});
}

class SelectImageState extends AddReportState {}

class ClearFormState extends AddReportState {}
