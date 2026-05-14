import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sankar_task/constants/app_constants.dart';

import '../models/quote_model.dart';

class QuoteController extends GetxController {
  var isLoading = false.obs;

  Rx<QuoteModel?> quote = Rx<QuoteModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchQuote();
  }

  Future<void> fetchQuote() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse(AppConstants.quoteApiUrl),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        quote.value = QuoteModel.fromJson(data);
      }
    } catch (e) {
      Get.snackbar(AppConstants.errorTitle, AppConstants.unableToFetchQuote);
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
