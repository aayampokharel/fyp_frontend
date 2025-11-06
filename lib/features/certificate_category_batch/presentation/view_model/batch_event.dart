abstract class BatchEvent {}

class GetCategoryBatchListEvent extends BatchEvent {
  String institutionID;
  String institutionFacultyID;

  GetCategoryBatchListEvent({
    required this.institutionID,
    required this.institutionFacultyID,
  });
}

class GetCertificatesBatchListEvent extends BatchEvent {
  String institutionID;
  String institutionFacultyID;
  String categoryID;

  GetCertificatesBatchListEvent({
    required this.institutionID,
    required this.institutionFacultyID,
    required this.categoryID,
  });
}

class DownloadIndividualPDFButtonPressedEvent extends BatchEvent {
  String fileID;
  String categoryName;
  String categoryID;

  DownloadIndividualPDFButtonPressedEvent({
    required this.fileID,
    required this.categoryName,
    required this.categoryID,
  });
}
