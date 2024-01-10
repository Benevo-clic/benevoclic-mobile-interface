import 'package:equatable/equatable.dart';

abstract class OtherAuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OtherAuthInitialState extends OtherAuthState {}

class OtherAuthErrorState extends OtherAuthState {
  final String message;

  OtherAuthErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
