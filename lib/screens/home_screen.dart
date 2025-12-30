import 'package:api_integrations/api_services/api_services.dart';
import 'package:api_integrations/models/products_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: FutureBuilder<List<ProductsModel>>(
        future: apiServices.getProducts(),
        builder: (context, snapshot) {
          // 1️⃣ Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2️⃣ Error
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          // 3️⃣ No data
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data found"));
          }

          // 4️⃣ Success
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final product = snapshot.data![index];
              return ListTile(
                leading: Image.network(
                  product.image ?? "",
                  width: 50,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(product.title ?? ""),
                subtitle: Text(product.description ?? "",maxLines: 2,),
              );
            },
          );
        },
      ),
    );
  }
}
