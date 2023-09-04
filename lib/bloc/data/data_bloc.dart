// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_graphql/api/api.dart';
import 'package:flutter_graphql/bloc/data/data_event.dart';
import 'package:flutter_graphql/bloc/data/data_state.dart';
import 'package:bloc/bloc.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc({required DataApiClient dataApiClient})
      : _dataApiClient = dataApiClient,
        super(DataLoadInProgress()) {
    on<DataFetchStarted>(_onDataFetchStarted);
  }

  final DataApiClient _dataApiClient;

  Future<void> _onDataFetchStarted(
    DataFetchStarted event,
    Emitter<DataState> emit,
  ) async {
    emit(DataLoadInProgress());
    try {
      final data = await _dataApiClient.getData();
      emit(DataLoadSuccess(data));
    } catch (error) {
      emit(DataLoadFailure());
    }
  }
}
