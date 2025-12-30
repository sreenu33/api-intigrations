import 'package:api_integrations/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../api_services/api_services.dart';
import '../models/products_model.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final ApiServices apiServices = ApiServices();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  bool isLoading = false;

  void createProduct() async {
    if (titleController.text.isEmpty ||
        priceController.text.isEmpty ||
        descController.text.isEmpty ||
        categoryController.text.isEmpty ||
        imageController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("All fields are required")));
      return;
    }

    final product = ProductsModel(
      title: titleController.text,
      price: double.parse(priceController.text),
      description: descController.text,
      category: categoryController.text,
      image: imageController.text,
    );

    setState(() => isLoading = true);

    try {
      final result = await apiServices.createProduct(product);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Product Created: ${result.title}")),
      );
      // wait for snackbar to finish
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      });
      // Clear fields
      titleController.clear();
      priceController.clear();
      descController.clear();
      categoryController.clear();
      imageController.clear();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTextField("Title", titleController),
              _buildTextField(
                "Price",
                priceController,
                keyboardType: TextInputType.number,
              ),
              _buildTextField("Description", descController, maxLines: 3),
              _buildTextField("Category", categoryController),
              _buildTextField("Image URL", imageController),

              const SizedBox(height: 20),

              isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: createProduct,
                        child: const Text("Create Product"),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
