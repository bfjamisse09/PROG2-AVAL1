part of "exchange.dart";

class TsvData implements DelimitedData {
  File? genericFile;
  String? fileContent;
  List<String> dataStructure = [];
  List<String> fileFields = [];

  @override
  String? get data => fileContent!;

  @override
  set data(String? value) {
    fileContent = fileContent! + "\n" + value!;
  }

  @override
  void clear() {
    fileContent = null;
  }

  @override
  String get delimiter => "\t";

  @override
  List<String> get fields {
    List<String> fieldsList = getFields()[0].split("\t");
    return fieldsList;
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
    if (fileName.contains(".tsv")) {
      fileContent = genericFile!.readAsStringSync();
      dataStructure = genericFile!.readAsLinesSync();
    } else {
      throw IncorrectFileFormat();
    }
  }

  @override
  void save(String fileName) {
    File myCsvFile = File(fileName);
    myCsvFile.writeAsString(fileContent!);
  }

  List<String> getFields() {
    var myfields = fileContent!.split("\n");
    return myfields;
  }
}
