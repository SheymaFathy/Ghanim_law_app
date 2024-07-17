import 'package:equatable/equatable.dart';

class App extends Equatable {
  final String? name;
  final String? copyright;
  final String? logo;

  const App({this.name, this.copyright, this.logo});

  factory App.fromJson(Map<String, dynamic> json) => App(
        name: json['name'] as String?,
        copyright: json['copyright'] as String?,
        logo: json['logo'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'copyright': copyright,
        'logo': logo,
      };

  @override
  List<Object?> get props => [name, copyright, logo];
}
