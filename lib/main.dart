import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql/api/api.dart';
import 'package:flutter_graphql/bloc/data/data_bloc.dart';
import 'package:flutter_graphql/bloc/data/data_event.dart';
import 'package:flutter_graphql/ui/products/home_screen.dart';

import 'package:graphql_flutter/graphql_flutter.dart';

void main() => runApp(MyApp(productApiClient: DataApiClient.create()));

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.productApiClient});

  final DataApiClient productApiClient;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DataBloc(
            dataApiClient: productApiClient,
          )..add(DataFetchStarted()),
        ),
      ],
      child: GraphQLProvider(
        client: ValueNotifier(DataApiClient.create().graphQLClient),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        ),
      ),
    );
  }
}
