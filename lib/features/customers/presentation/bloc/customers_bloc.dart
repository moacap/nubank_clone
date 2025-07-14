import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/fetch_customers_usecase.dart';
import '../../domain/entities/customer.dart';

abstract class CustomersEvent {}

class FetchCustomersEvent extends CustomersEvent {}

abstract class CustomersState {}

class CustomersInitial extends CustomersState {}

class CustomersLoading extends CustomersState {}

class CustomersLoaded extends CustomersState {
  final List<Customer> customers;
  CustomersLoaded(this.customers);
}

class CustomersError extends CustomersState {
  final String message;
  CustomersError(this.message);
}

class CustomersBloc extends Bloc<CustomersEvent, CustomersState> {
  final FetchCustomersUseCase fetchCustomersUseCase;

  CustomersBloc(this.fetchCustomersUseCase) : super(CustomersInitial()) {
    on<FetchCustomersEvent>((event, emit) async {
      emit(CustomersLoading());
      try {
        final customers = await fetchCustomersUseCase();
        emit(CustomersLoaded(customers));
      } catch (e) {
        emit(CustomersError(e.toString()));
      }
    });
  }
}
