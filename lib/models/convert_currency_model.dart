class ConvertCurrencyModel {
  ConvertCurrencyModel({
    required this.result,
  });
  late final double result;

  ConvertCurrencyModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
  }
}
