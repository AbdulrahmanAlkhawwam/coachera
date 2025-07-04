import 'package:coachera/core/components/bounded_list.dart';
import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/features/category/domain/entities/category.dart';
import 'package:coachera/features/category/presentation/widgets/category_card.dart';
import 'package:coachera/features/home/presentation/widgets/bottom_nev_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../course/presentation/widgets/categories_list.dart';
import '../../../search/presentation/widgets/search_card.dart';
import '../manager/bloc/favorite_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(GetFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(TablerIcons.bell_ringing),
          )
        ],
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => Container(
          width: double.infinity,
          height: 80,
          color: context.colors.primary,
        ),
        separatorBuilder: (context, index) => SizedBox(height: 8.0),
        itemCount: 10,
      ),
    );
  }
}
