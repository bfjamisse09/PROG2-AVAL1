part of "exchange.dart";

class XmlData extends Data {
  File? genericFile;
  String? fileContent;
  List<dynamic> dataStructure = [];
  List<String> fileFields = [];

  @override
  String? get data => fileContent;

  @override
  set data(String? value) {
    // TODO: implement fields
  }

  @override
  void clear() {
    fileContent = null;
  }

  @override
  // TODO: implement fields
  List<String> get fields {
    Set attributeNamesSet = {};
    List<String> attributeNamesList = [];
    final document = xml.XmlDocument.parse(fileContent!);
    final data = document.findAllElements("record");
    for (final item in data) {
      for (final attribute in item.attributes) {
        attributeNamesSet.add(attribute.name.local);
      }
    }
    for (String names in attributeNamesSet) {
      attributeNamesList.add(names);
    }
    return attributeNamesList;
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
    if (fileName.contains(".xml")) {
      fileContent = genericFile!.readAsStringSync();
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
