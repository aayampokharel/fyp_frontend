import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:csv/csv.dart';
import 'package:flutter_dashboard/features/csv_upload/domain/entity/certificate_data_entity.dart';

/// Function to parse CSV into List<CertificateDataEntity>
Future<List<CertificateDataEntity>> parseCsvFileInBackground(
  String csvContent,
  String institutionId,
  String institutionFacultyId,
  String pdfCategoryId,
  String facultyPublicKey,
) async {
  return compute(_parseCsvFile, {
    'content': csvContent,
    'institutionId': institutionId,
    'institutionFacultyId': institutionFacultyId,
    'pdfCategoryId': pdfCategoryId,
    'facultyPublicKey': facultyPublicKey,
  });
}

List<CertificateDataEntity> _parseCsvFile(Map<String, dynamic> params) {
  final rawContent = params['content'] as String;
  final content = rawContent.replaceAll('\r\n', '\n');
  final institutionId = params['institutionId'] as String;
  final institutionFacultyId = params['institutionFacultyId'] as String;
  final pdfCategoryId = params['pdfCategoryId'] as String;
  final facultyPublicKey = params['facultyPublicKey'] as String;

  final rows = const CsvToListConverter().convert(content, eol: '\n');
  if (rows.isEmpty) throw Exception('CSV file is empty.');

  final headerRow = rows.first
      .map((e) => e.toString().trim().toLowerCase())
      .toList();
  final dataRows = rows.skip(1);

  // Create column index mapping
  final columnMap = _createColumnMap(headerRow);

  List<CertificateDataEntity> certificates = [];

  for (var row in dataRows) {
    try {
      final certificate = _parseRowWithColumnMapping(
        row,
        columnMap,
        institutionId,
        institutionFacultyId,
        pdfCategoryId,
        facultyPublicKey,
      );
      certificates.add(certificate);
    } catch (e) {
      throw Exception('Failed to parse CSV row: $row\nError: $e');
    }
  }

  return certificates;
}

/// Creates a mapping from column names to their indices
Map<String, int> _createColumnMap(List<String> headers) {
  final Map<String, int> columnMap = {};

  for (int i = 0; i < headers.length; i++) {
    final header = headers[i];
    columnMap[header] = i;

    // Add common aliases for flexibility
    if (header == 'certificate_id' ||
        header == 'id' ||
        header == 'certificate id') {
      columnMap['certificate_id'] = i;
    }
    if (header == 'student_id' ||
        header == 'student id' ||
        header == 'studentid') {
      columnMap['student_id'] = i;
    }
    if (header == 'student_name' ||
        header == 'name' ||
        header == 'student name') {
      columnMap['student_name'] = i;
    }
    if (header == 'certificate_type' ||
        header == 'type' ||
        header == 'certificate type') {
      columnMap['certificate_type'] = i;
    }
    // Add more aliases as needed
  }

  return columnMap;
}

/// Parses a single row using column mapping
CertificateDataEntity _parseRowWithColumnMapping(
  List<dynamic> row,
  Map<String, int> columnMap,
  String institutionId,
  String institutionFacultyId,
  String pdfCategoryId,
  String facultyPublicKey,
) {
  // Helper function to get value from row with column mapping
  String getStringValue(String columnName, [String defaultValue = '']) {
    final index = columnMap[columnName];
    return index != null && index < row.length
        ? row[index].toString()
        : defaultValue;
  }

  int getIntValue(String columnName, [int defaultValue = 0]) {
    final index = columnMap[columnName];
    return index != null && index < row.length
        ? int.tryParse(row[index].toString()) ?? defaultValue
        : defaultValue;
  }

  double? getDoubleValue(String columnName) {
    final index = columnMap[columnName];
    return index != null && index < row.length
        ? double.tryParse(row[index].toString())
        : null;
  }

  DateTime getDateValue(String columnName) {
    final index = columnMap[columnName];
    if (index != null && index < row.length) {
      return _parseDateFromCsv(row[index].toString());
    }
    return DateTime.now();
  }

  DateTime? getNullableDateValue(String columnName) {
    final index = columnMap[columnName];
    if (index != null && index < row.length) {
      final value = row[index].toString();
      return value.isNotEmpty ? _parseDateFromCsv(value) : null;
    }
    return null;
  }

  // Parse dates
  final issueDate = getDateValue('issue_date');
  final enrollmentDate = getNullableDateValue('enrollment_date');
  final completionDate = getNullableDateValue('completion_date');
  final leavingDate = getNullableDateValue('leaving_date');

  return CertificateDataEntity(
    // Required fields
    certificateId: getStringValue('certificate_id'),
    blockNumber: getIntValue('block_number'),
    position: getIntValue('position', 1),
    studentId: getStringValue('student_id'),
    studentName: getStringValue('student_name'),
    institutionId: institutionId,
    institutionFacultyId: institutionFacultyId,
    pdfCategoryId: pdfCategoryId,
    certificateType: getStringValue('certificate_type'),
    issueDate: issueDate,
    facultyPublicKey: facultyPublicKey,
    createdAt: DateTime.now(),

    // Conditionally required fields
    degree: getStringValue('degree'),
    college: getStringValue('college'),
    major: getStringValue('major'),
    gpa: getStringValue('gpa'),
    percentage: getDoubleValue('percentage'),
    division: getStringValue('division'),
    universityName: getStringValue('university_name'),

    // Date fields
    enrollmentDate: enrollmentDate,
    completionDate: completionDate,
    leavingDate: leavingDate,

    // Optional fields
    reasonForLeaving: getStringValue('reason_for_leaving').isNotEmpty
        ? getStringValue('reason_for_leaving')
        : null,
    characterRemarks: getStringValue('character_remarks').isNotEmpty
        ? getStringValue('character_remarks')
        : null,
    generalRemarks: getStringValue('general_remarks').isNotEmpty
        ? getStringValue('general_remarks')
        : null,
    certificateHash: null,
  );
}

/// Helper method to get CSV content from PlatformFile (cross-platform)
Future<String> getCsvContent(PlatformFile file) async {
  if (kIsWeb) {
    // For web, read from bytes
    if (file.bytes != null) {
      return String.fromCharCodes(file.bytes!);
    } else {
      throw Exception("File bytes are null");
    }
  } else {
    // For mobile, read from path
    if (file.path != null) {
      return await File(file.path!).readAsString();
    } else {
      throw Exception("File path is null");
    }
  }
}

/// Helper method to parse dates from CSV with proper error handling
DateTime _parseDateFromCsv(String dateString) {
  if (dateString.isEmpty) {
    return DateTime.now();
  }

  try {
    // Clean the date string
    final cleanDateString = dateString.trim();

    // Try parsing as ISO format first (e.g., "2024-01-15T00:00:00Z")
    if (cleanDateString.contains('T')) {
      return DateTime.parse(cleanDateString).toLocal();
    }
    // Try parsing as simple date (YYYY-MM-DD)
    else if (RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(cleanDateString)) {
      final parts = cleanDateString.split('-');
      return DateTime(
        int.parse(parts[0]),
        int.parse(parts[1]),
        int.parse(parts[2]),
      );
    }
    // Try parsing as other common formats
    else if (cleanDateString.contains('/')) {
      final parts = cleanDateString.split('/');
      if (parts.length == 3) {
        // Handle MM/DD/YYYY or DD/MM/YYYY
        if (parts[0].length == 4) {
          // YYYY/MM/DD
          return DateTime(
            int.parse(parts[0]),
            int.parse(parts[1]),
            int.parse(parts[2]),
          );
        } else {
          // Assume MM/DD/YYYY
          return DateTime(
            int.parse(parts[2]), // year
            int.parse(parts[0]), // month
            int.parse(parts[1]), // day
          );
        }
      }
    }

    // Fallback to current date if no format matches
    return DateTime.now();
  } catch (e) {
    // If parsing fails, use current date with warning
    debugPrint(
      'Failed to parse date: "$dateString", using current date. Error: $e',
    );
    return DateTime.now();
  }
}

/// Alternative method for more strict date parsing (if needed)
DateTime _parseDateStrict(String dateString) {
  final formats = [
    // ISO 8601
    RegExp(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z$'),
    RegExp(r'^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}\.\d{3}Z$'),
    // Date only
    RegExp(r'^\d{4}-\d{2}-\d{2}$'),
  ];

  for (final format in formats) {
    if (format.hasMatch(dateString)) {
      try {
        return DateTime.parse(dateString).toLocal();
      } catch (e) {
        continue;
      }
    }
  }

  throw FormatException('Unable to parse date: $dateString');
}
