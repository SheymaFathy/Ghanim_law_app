class PaymentMyFatorahModel {
  final String price;
  final String serviceName;
  final String? email;
  final String? phone;
  final String? name;
  final String? lang;
  final String? countryCode;
  final String? orderID;
  PaymentMyFatorahModel(
      {required this.price,
      required this.serviceName,
      this.lang,
      this.countryCode,
      this.email,
      this.phone,
      this.name,
      this.orderID});
}
