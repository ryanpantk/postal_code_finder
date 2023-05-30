import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:postal_code_finder/screens/search_results_screen.dart';
import 'package:postal_code_finder/services/onemap_api.dart';

class SearchScreenController extends GetxController {
  final OneMapAPI oneMapAPI = OneMapAPI();
  final postalCodeTextController = TextEditingController();
  final RxInt pageNumber = 1.obs;

  @override
  void onClose() {
    postalCodeTextController.dispose();
  }

  Future<void> onSearch() async {
    if (postalCodeTextController.text.isEmpty) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Empty Postal Code',
          message: 'Please make sure you have provided a postal code.',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.redAccent,
        ),
      );
    } else if (!RegExp(r'^[0-9]+$').hasMatch(postalCodeTextController.text)) {
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Incorrect Postal Code',
          message: 'Postal codes can only contain digits.',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.redAccent,
        ),
      );
    } else {
      try {
        oneMapAPI.getAddressResults(
            (postalCodeTextController.text), (pageNumber.toString()));
        Get.to(SearchResultScreen());
      } catch (exception) {
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Connection Error',
            message: 'Please try again later.',
            icon: Icon(Icons.refresh),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}
