import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
	const PaymentEvent();
	@override
	List<Object?> get props => [];
}

class InitiatePayment extends PaymentEvent {
	const InitiatePayment(this.amount);
	final double amount;
	@override
	List<Object?> get props => [amount];
}
