part of "exchange.dart";

class CsvData implements DelimitedData {
  File? genericFile;
  String? fileContent;
  List<List<dynamic>> dataStructure = [];
  List<String> fileFields = [];

  @override
  String? get data => fileContent;

  @override
  set data(String? value) {
    fileContent = fileContent! + "\n" + value!;
  }

  @override
  void clear() {
    fileContent = null;
  }

  @override
  String get delimiter => ",";

  @override
  List<String> get fields {
    List<String> fields = [];
    for (var value in dataStructure[0]) {
      fields.add(value.toString());
    }
    return fields;
  }

  @override
  bool get hasData {
    if (data == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  void load(String fileName) {
    genericFile = File(fileName);
    if (fileName.contains(".csv")) {
      fileContent = genericFile!.readAsStringSync();
      dataStructure = CsvToList(genericFile);
    } else {
      throw IncorrectFileFormat();
    }
  }

  @override
  void save(String fileName) {
    File myCsvFile = File(fileName);
    myCsvFile.writeAsString(fileContent!);
  }
}

List<List<dynamic>> CsvToList(File? genericFile) {
  csv.CsvToListConverter c = csv.CsvToListConverter(shouldParseNumbers: false);
  List<List<String>> csvList = c.convert(genericFile!.readAsStringSync());
  return csvList;
}
