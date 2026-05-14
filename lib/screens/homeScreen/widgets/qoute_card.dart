import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sankar_task/constants/app_constants.dart';
import 'package:sankar_task/controller/qoute_controller.dart';
import 'package:sankar_task/theme/app_Colors.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    final quoteController = Get.find<QuoteController>();

    return Obx(() {
      final quote = quoteController.quote.value;

      return Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
        ),

        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppConstants.motivationalQuoteHeading,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
          
                  IconButton(
                    onPressed: () {
                      quoteController.fetchQuote();
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
          
              if (quoteController.isLoading.value)
                const Center(child: CircularProgressIndicator())
              else if (quote != null) ...[
                Text('"${quote.content}"', style: const TextStyle(fontSize: 16)),
          
                const SizedBox(height: 12),
          
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '- ${quote.author}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }
}
