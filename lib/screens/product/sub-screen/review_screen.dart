import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_com/utils/widgets/appbar_widget.dart';

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
          child: Column(
        children: [
          _buildRating(),
          _buildReviews(),
        ],
      )),
    );
  }

  Widget _buildRating() {
    return const Column(
      children: [
        Text('3 trên 5'),
        Icon(Icons.star),
        Icon(Icons.star),
        Icon(Icons.star),
        Icon(Icons.star),
        Icon(Icons.star),
      ],
    );
  }

  Widget _buildReviews() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: Colors.white),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return Column(children: [
              Text('Kim Shine'),

            ],);
          },
          separatorBuilder: (context, index) => const Divider(
                height: 10,
              ),
          itemCount: 2),
    );
  }
}
