abstract class EditReportState {}

class EditReportInitalState extends EditReportState {}

class EditReportLoadingState extends EditReportState {}

class EditReportSuccessState extends EditReportState {}

class EditReportErrorState extends EditReportState {
  final String error;

  EditReportErrorState({required this.error});
}

class SelectimageState extends EditReportState {}

class ClearformState extends EditReportState {}
