import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/fetch_items_usecase.dart';

abstract class ExampleEvent {}

class FetchItemsEvent extends ExampleEvent {}

abstract class ExampleState {}

class ExampleInitial extends ExampleState {}

class ExampleLoading extends ExampleState {}

class ExampleLoaded extends ExampleState {
  final List<dynamic> items;
  ExampleLoaded(this.items);
}

class ExampleError extends ExampleState {
  final String message;
  ExampleError(this.message);
}

class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final FetchItemsUseCase fetchItemsUseCase;

  ExampleBloc(this.fetchItemsUseCase) : super(ExampleInitial()) {
    on<FetchItemsEvent>((event, emit) async {
      emit(ExampleLoading());
      try {
        final items = await fetchItemsUseCase();
        emit(ExampleLoaded(items));
      } catch (e) {
        emit(ExampleError(e.toString()));
      }
    });
  }
}
