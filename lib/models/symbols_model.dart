class SymbolsModel {
  late final List<String> symbols;

  SymbolsModel.fromJson(Map<String, dynamic> json) {
    symbols = json['symbols'].keys.toList();
  }
}
