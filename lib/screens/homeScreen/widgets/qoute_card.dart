import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sankar_task/controller/qoute_controller.dart';

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
          color: Colors.white,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: [

                const Text(
                  'Motivational Quote',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    quoteController.fetchQuote();
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),

            const SizedBox(height: 12),

            if (quoteController.isLoading.value)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (quote != null) ...[

              Text(
                '"${quote.content}"',
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 12),

              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  '- ${quote.author}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ]
          ],
        ),
      );
    });
  }
}