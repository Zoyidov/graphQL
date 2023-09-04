import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_graphql/bloc/data/data_bloc.dart';
import 'package:flutter_graphql/bloc/data/data_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data',style: TextStyle(fontSize: 30),),
        backgroundColor: Colors.deepPurple,
        elevation: 20,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
          child: BlocBuilder<DataBloc, DataState>(
            builder: (context, state) {
              if (state is DataLoadInProgress) {
                return const CupertinoActivityIndicator();
              }
              if (state is DataLoadSuccess) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    final product = state.data[index];
                    return Card(
                      elevation: 10,
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 250,
                              child: product.image.isNotEmpty
                                  ? CachedNetworkImage(
                                      placeholder: (context, url) =>
                                          const CupertinoActivityIndicator(),
                                      imageUrl: product.image,
                                      height: 120,
                                      width: 120,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(
                                      Icons.no_photography_rounded,
                                      size: 60,
                                      color: Colors.deepPurple,
                                    ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                product.name,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.deepPurple,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'Year: ${product.yearBuilt.toString()}',
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Type: ${product.type}',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return const Text('Error occurred!');
            },
          ),
        ),
      ),
    );
  }
}
