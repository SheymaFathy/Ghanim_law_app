import 'package:equatable/equatable.dart';

import 'app.dart';
import 'apps.dart';
import 'contacts.dart';
import 'pages.dart';
import 'prices.dart';

class HomeModel extends Equatable {
  final App? app;
  final Contacts? contacts;
  final Apps? apps;
  final Pages? pages;
  final Prices? prices;

  const HomeModel({
    this.app,
    this.contacts,
    this.apps,
    this.pages,
    this.prices,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        app: json['app'] == null
            ? null
            : App.fromJson(json['app'] as Map<String, dynamic>),
        contacts: json['contacts'] == null
            ? null
            : Contacts.fromJson(json['contacts'] as Map<String, dynamic>),
        apps: json['apps'] == null
            ? null
            : Apps.fromJson(json['apps'] as Map<String, dynamic>),
        pages: json['pages'] == null
            ? null
            : Pages.fromJson(json['pages'] as Map<String, dynamic>),
        prices: json['prices'] == null
            ? null
            : Prices.fromJson(json['prices'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'app': app?.toJson(),
        'contacts': contacts?.toJson(),
        'apps': apps?.toJson(),
        'pages': pages?.toJson(),
        'prices': prices?.toJson(),
      };

  @override
  List<Object?> get props => [app, contacts, apps, pages, prices];
}
