import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:shop_com/utils/widgets/appbar_widget.dart';
import 'package:shop_com/utils/widgets/custom_reviews_widget.dart';

import '../../../utils/widgets/rating_start_widget.dart';

class ReviewScreen extends ConsumerStatefulWidget {
  const ReviewScreen({super.key});

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Rating and reviews',
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _buildRating(),
            const SizedBox(height: 10,),
            const Expanded(
              child: CustomerReviews(
                nameCustomer: 'Kim',
                ratings: 3.3,
                dateRating: 'August 13, 2009',
                comment:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets",
                reviewCount: 12,
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildRating() {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('3 trên 5'),
        RatingStartWidget(
          rating: 3.014,
          reviewCount: 10,
          iconFontSize: 20,
        ),
      ],
    );
  }
}
