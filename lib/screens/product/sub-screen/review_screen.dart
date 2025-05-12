import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:shop_com/utils/widgets/appbar_widget.dart';
import 'package:shop_com/utils/widgets/button_widget.dart';
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text('What is your rate'),
                    RatingBar(
                      initialRating: 0,
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                          full: Icon(Icons.star, color: Colors.orange[300]),
                          half: Icon(Icons.star_half),
                          empty: Icon(Icons.star_border)),
                      onRatingUpdate: (value) {
                        print(value);
                      },
                    ),
                    TextFormField(
                      maxLines: 6,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Your review')),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: CommonButtonWidget(
                        callBack: () => Navigator.pop(context),
                        label: 'SEND REVIEW',
                        style: const TextStyle(color: Colors.white),
                        buttonStyle: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Colors.black)),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
        label: const Text(
          'Write a review',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.edit, color: Colors.white),
        backgroundColor: const Color(0xff000000),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _buildRating(),
            const SizedBox(
              height: 10,
            ),
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
