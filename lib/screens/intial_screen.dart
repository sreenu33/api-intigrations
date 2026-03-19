import 'package:api_integrations/controllers/dummy_api_controller.dart';
import 'package:api_integrations/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntialScreen extends StatefulWidget {
  const IntialScreen({super.key});

  @override
  State<IntialScreen> createState() => _IntialScreenState();
}

class _IntialScreenState extends State<IntialScreen> {
  final DummyApiController dummyApiController =
      Get.put(DummyApiController());

  @override
  void initState() {
    super.initState();
    dummyApiController.getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Carts")),
      body: GetBuilder<DummyApiController>(
        builder: (controller) {
          if (controller.usersData.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: controller.usersData.length,
            itemBuilder: (context, index) {
              UserDataModel cart = controller.usersData[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "User ID: ${cart.userId}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Date: ${cart.date}"),

                      const SizedBox(height: 10),

                      const Text(
                        "Products",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 6),

                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cart.products?.length ?? 0,
                        itemBuilder: (context, pIndex) {
                          final product = cart.products![pIndex];

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Product ID: ${product.productId}",
                                ),
                                Text(
                                  "Qty: ${product.quantity}",
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
