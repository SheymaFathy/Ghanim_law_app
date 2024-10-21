class Myfatoorah {
  String? mode;
  String? baseUrl;
  String? currency;
  String? accessToken;
  String? country;

  Myfatoorah(
      {this.mode, this.baseUrl, this.currency, this.accessToken, this.country});

  factory Myfatoorah.fromJson(Map<String, dynamic> json) {
    return Myfatoorah(
        mode: json['mode'] as String?,
        baseUrl: json['base_url'] as String?,
        currency: json['currency'],
        accessToken: json['access_token'] as String?,
        country: json['country'] as String?);
  }

  Map<String, dynamic> toJson() => {
        'mode': this.mode,
        'base_url': this.baseUrl,
        'currency': this.currency,
        'access_token': this.accessToken,
        'country': this.country
      };
}
