import 'package:flutter_graphql/api/models/data_model.dart';
import 'package:flutter_graphql/api/queries/get_data_query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GetDataRequestFailure implements Exception{}

class DataApiClient{
  const DataApiClient({required this.graphQLClient});

  final GraphQLClient graphQLClient;

  factory DataApiClient.create() {
    final httpLink = HttpLink('https://spacex-production.up.railway.app/');
    final link = Link.from([httpLink]);

    return DataApiClient(
      graphQLClient: GraphQLClient(cache: GraphQLCache(), link: link),
    );
  }

  Future<List<DataModel>> getData() async {
    final result = await graphQLClient.query(
      QueryOptions(document: gql(getDataQuery)),
    );

    if (result.hasException) throw GetDataRequestFailure();
    return (result.data?['ships'] as List?)
        ?.map((dynamic e) => DataModel.fromJson(e as Map<String, dynamic>))
        .toList() ??
        [];
  }

}