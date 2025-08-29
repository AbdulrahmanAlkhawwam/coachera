import 'package:coachera/core/utils/app_context.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc/review_bloc.dart';
import '../widgets/review_card.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  void initState() {
    context.read<ReviewBloc>().add(GetReviews());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("reviews"),
      ),
      body: BlocBuilder<ReviewBloc, ReviewState>(
          builder: (context, state) => switch (state.status) {
                ReviewStatus.loading =>
                  const Center(child: CircularProgressIndicator()),
                _ => ListView.separated(
                    padding: EdgeInsets.only(
                      left: 8,
                      right: 8,
                      bottom: context.bottomPadding,
                    ),
                    itemBuilder: (context, index) => ReviewCard(
                      reviewerName: 'You',
                      rating: context
                          .read<ReviewBloc>()
                          .state
                          .reviews![index]
                          .rating,
                      reviewText: context
                          .read<ReviewBloc>()
                          .state
                          .reviews![index]
                          .comment,
                      date: DateFormat("d MMM yyyy").format(context
                          .read<ReviewBloc>()
                          .state
                          .reviews![index]
                          .updatedAt),
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemCount:
                        context.read<ReviewBloc>().state.reviews?.length ?? 0,
                  ),
              }),
    );
  }
}
