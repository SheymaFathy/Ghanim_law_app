class PaymentMyFatorahModel {
  final String price;
  final String serviceName;
  final String? email;
  final String? phone;
  final String? name;

  PaymentMyFatorahModel(
      {required this.price,
      required this.serviceName,
      this.email,
      this.phone,
      this.name});
}
