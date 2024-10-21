import 'package:equatable/equatable.dart';
import 'package:ghanim_law_app/features/main_pages/pre/pages/home/data/model/home_model/my_fatorah.dart';

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
  final Myfatoorah? myfatoorah;

  final List<PriceModel>? priceModel;

  const HomeModel(
      {this.app,
      this.contacts,
      this.apps,
      this.pages,
      this.priceModel,
      this.myfatoorah});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    final List<PriceModel> priceList = [];
    json['prices'].forEach((key, value) {
      priceList.add(PriceModel.fromJson(value, key));
    });

    return HomeModel(
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
        priceModel: priceList,
        myfatoorah: json['myfatoorah'] != null
            ? Myfatoorah.fromJson(json['myfatoorah'])
            : null);
  }

  Map<String, dynamic> toJson() => {
        'app': app?.toJson(),
        'contacts': contacts?.toJson(),
        'apps': apps?.toJson(),
        'pages': pages?.toJson(),
        'myfatoorah': this.myfatoorah?.toJson()
      };

  @override
  List<Object?> get props => [app, contacts, apps, pages];
}
