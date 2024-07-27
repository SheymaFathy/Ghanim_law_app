import 'package:equatable/equatable.dart';

import 'book_preparation.dart';
import 'contract_review.dart';
import 'legal_advice.dart';

class Prices extends Equatable {
  final LegalAdvice? legalAdvice;
  final ContractReview? contractReview;
  final BookPreparation? bookPreparation;

  const Prices({
    this.legalAdvice,
    this.contractReview,
    this.bookPreparation,
  });

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        legalAdvice: json['legal_advice'] == null
            ? null
            : LegalAdvice.fromJson(
                json['legal_advice'] as Map<String, dynamic>),
        contractReview: json['contract_review'] == null
            ? null
            : ContractReview.fromJson(
                json['contract_review'] as Map<String, dynamic>),
        bookPreparation: json['book_preparation'] == null
            ? null
            : BookPreparation.fromJson(
                json['book_preparation'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'legal_advice': legalAdvice?.toJson(),
        'contract_review': contractReview?.toJson(),
        'book_preparation': bookPreparation?.toJson(),
      };

  @override
  List<Object?> get props {
    return [
      legalAdvice,
      contractReview,
      bookPreparation,
    ];
  }
}
