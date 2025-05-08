import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_com/utils/widgets/rating_start_widget.dart';

class CustomerReviews extends StatefulWidget {
  final String nameCustomer;
  final double ratings;
  final String dateRating;
  final int? reviewCount;
  final String comment;

  const CustomerReviews(
      {super.key,
      required this.nameCustomer,
      required this.ratings,
      required this.dateRating,
      this.reviewCount,
      required this.comment});

  @override
  State<CustomerReviews> createState() => _CustomerReviewsState();
}

class _CustomerReviewsState extends State<CustomerReviews> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: ListView.separated(
          itemBuilder: (context, index) {
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
                      blurRadius: 2
                    )
                  ],
                  borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.nameCustomer),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingStartWidget(rating: widget.ratings),
                      Text(widget.dateRating)
                    ],
                  ),
                  ExpandableText(
                    widget.comment,
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
              ),
          itemCount: widget.reviewCount ?? 0),
    );
  }
}
