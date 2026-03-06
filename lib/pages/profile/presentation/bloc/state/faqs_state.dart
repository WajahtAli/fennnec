import 'package:equatable/equatable.dart';
import 'package:fennac_app/models/dummy/faq_item_model.dart';

abstract class FaqsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FaqsInitial extends FaqsState {}

class FaqsLoading extends FaqsState {}

class FaqsLoaded extends FaqsState {
  final List<FaqItem> faqs;

  FaqsLoaded(this.faqs);

  @override
  List<Object?> get props => [faqs];
}

class FaqsError extends FaqsState {
  final String error;

  FaqsError(this.error);

  @override
  List<Object?> get props => [error];
}
