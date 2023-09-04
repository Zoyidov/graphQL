import 'package:flutter_graphql/api/models/data_model.dart';

abstract class DataState {}

class DataLoadInProgress extends DataState {}

class DataLoadSuccess extends DataState {
  DataLoadSuccess(this.data);

  final List<DataModel> data;
}

class DataLoadFailure extends DataState {}