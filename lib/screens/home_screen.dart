import 'package:dars82_graphql/utils/constants/products_graphql_queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            onPressed: () {
              GraphQLProvider.of(context).value.mutate(
                    MutationOptions(
                      document: gql(deleteProduct),
                      variables: {"id": 3279},
                      onCompleted: (data) {
                        print(data);
                      },
                      onError: (error) {
                        print(error!.linkException);
                      },
                    ),
                  );
            },
            icon: const Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () {
              String title = "Salom Javohiruuuu";
              String description = "Salom Ulugbek";
              double price = 25550;

              GraphQLProvider.of(context).value.mutate(
                    MutationOptions(
                      document: gql(editProduct),
                      variables: {
                        "id": 3279,
                        "title": title,
                        "description": description,
                        "price": price,
                      },
                      onCompleted: (data) {
                        print(data);
                      },
                      onError: (error) {
                        print(error!.linkException);
                      },
                    ),
                  );
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              String title = "Salom Dostonuuu";
              String description = "Salom Description";
              double price = 200;
              int categoryId = 2;
              List<String> images = [
                "https://img.goodfon.com/original/5417x2950/9/36/sopki-oblaka-zima-elki-sneg.jpg"
              ];

              GraphQLProvider.of(context).value.mutate(
                    MutationOptions(
                      document: gql(addProduct),
                      variables: {
                        "title": title,
                        "description": description,
                        "categoryId": categoryId,
                        "price": price,
                        "images": images,
                      },
                      onCompleted: (data) {
                        print(data);
                      },
                      onError: (error) {
                        print(error!.linkException);
                      },
                    ),
                  );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Query(
        // options'da nima ma'lumotlar kerakligini aytamiz
        options: QueryOptions(
          document: gql(getProducts),
        ),

        // builder'da usha ma'lumotlarni ko'rsatamiz
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (result.hasException) {
            return Center(
              child: Text(result.exception.toString()),
            );
          }

          if (result.data!['product'] != null) {
            final product = result.data!['product'];

            final imageUrl = product['images'][0].split('"')[1];
            return Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  Text(product['title']),
                  Text(product['description']),
                  Text(product['price'].toString()),
                ],
              ),
            );
          }

          List products = result.data!['products'];

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                title: Text(
                  products[index]['title'],
                ),
                subtitle: Text(products[index]['description']),
              );
            },
          );
        },
      ),
    );
  }
}
