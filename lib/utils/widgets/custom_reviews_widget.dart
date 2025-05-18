import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_com_admin_web/utils/util.dart';
import 'package:shop_com_admin_web/utils/widgets/rating_start_widget.dart';

import '../../data/model/review.dart';

class CustomerReviews extends StatefulWidget {
  final List<Review> reviews;

  const CustomerReviews({super.key, required this.reviews});

  @override
  State<CustomerReviews> createState() => _CustomerReviewsState();
}

class _CustomerReviewsState extends State<CustomerReviews> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: ListView.separated(
          itemCount: widget.reviews.length,
          itemBuilder: (context, index) {
            final review = widget.reviews[index];
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.16),
                        offset: Offset(0, 2),
                        blurRadius: 3),
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.23),
                        offset: Offset(0, 2),
                        blurRadius: 3),
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.20),
                        offset: Offset(0, -1),
                        blurRadius: 2)
                  ],
                  borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review.userId?.name ?? 'Anonymous', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingStartWidget(rating: review.rating?.toDouble() ?? 0, paddingLeft: 0),
                      Text(getStringFromDateTime(
                          review.createdAt ?? DateTime.now(), 'dd/MM/yyyy'), style: const TextStyle(color: Colors.grey, fontSize: 12),)
                    ],
                  ),
                  ExpandableText(
                    review.comment ?? '',
                    expandText: 'Show more',
                    collapseText: 'Show less',
                    maxLines: 4,
                    linkStyle: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.red[500]),
                    animation: true,
                    animationCurve: Curves.ease,
                  )
                ],
              ),
            );
          },
          padding: const EdgeInsets.all(8),
          separatorBuilder: (context, index) => const SizedBox(
                height: 12,
              )),
    );
  }
}
