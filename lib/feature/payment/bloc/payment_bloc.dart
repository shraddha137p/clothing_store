import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
	PaymentBloc({required this.processPayment, required this.clearCart})
			: super(const PaymentState()) {
		on<InitiatePayment>((event, emit) async {
			emit(const PaymentState(status: PaymentStatus.loading));
			try {
				final receipt = await processPayment(event.amount);
				await clearCart();
				emit(PaymentState(status: PaymentStatus.success, receipt: receipt));
			} catch (error) {
				emit(PaymentState(
					status: PaymentStatus.failure,
					errorMessage: error.toString(),
				));
			}
		});
	}

	final ProcessDummyPaymentUseCase processPayment;
	final ClearCartUseCase clearCart;
}
