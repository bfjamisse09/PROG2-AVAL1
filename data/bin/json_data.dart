part of "exchange.dart";

class JsonData extends Data {
  File? genericFile;
  List<dynamic> fileContent = [];
  List<dynamic> dataStructure = [];
  List<String> fileFields = [];

  @override
  String? get data => fileContent.join();

  @override
  set data(String? value) {
    // TODO: implement fields
  }

  @override
  void clear() {
    fileContent = [];
  }

  @override
  List<String> get fields => fileContent[0].keys.toList();

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
    if (fileName.contains(".json")) {
      fileContent = jsonDecode(genericFile!.readAsStringSync());
    } else {
      throw IncorrectFileFormat();
    }
  }

  @override
  void save(String fileName) {
    File myCsvFile = File(fileName);
    myCsvFile.writeAsString(fileContent.join());
  }
}
