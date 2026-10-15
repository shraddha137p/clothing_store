import 'package:equatable/equatable.dart';

import '../../../domain/entities.dart';

enum PaymentStatus { initial, loading, success, failure }

class PaymentState extends Equatable {
	const PaymentState({
		this.status = PaymentStatus.initial,
		this.receipt,
		this.errorMessage,
	});

	final PaymentStatus status;
	final OrderReceipt? receipt;
	final String? errorMessage;

	@override
	List<Object?> get props => [status, receipt, errorMessage];
}
