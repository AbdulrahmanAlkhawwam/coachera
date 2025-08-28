import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/components/custom_input.dart';
import '../../../../core/components/tag_item.dart';
import '../bloc/search_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? selectedCategoryId;

  @override
  void initState() {
    context.read<SearchBloc>().add(GetEntities());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore"),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomInput(
                  onTap: () => print("hello world"),
                  isEnabled: true,
                  prefixIcon: TablerIcons.search,
                  suffixIcon: TablerIcons.adjustments_horizontal,
                  hint: "Search your course ...",
                ),

                const SizedBox(height: 24),

                const Text(
                  "Search by Entity",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: state.entities.map((entity) {
                    final isSelected = selectedCategoryId == entity.id;
                    return TagItem(
                      isSelected: isSelected,
                      onSelect: (_) =>
                          setState(() => selectedCategoryId = entity.id),
                      text: entity.name,
                    );
                  }).toList(),
                ),

                const SizedBox(height: 32),

                const Text(
                  "Search by Categories",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // GridView.builder(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemCount: widget.categories.length,
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 4,
                //     crossAxisSpacing: 12,
                //     mainAxisSpacing: 12,
                //   ),
                //   itemBuilder: (context, index) {
                //     final category = widget.categories[index];
                //     return CategoryCard(
                //       category: category,
                //       color: index % 4 % 2 == 1 && index <= 4 ||
                //               index % 2 == 0 && index > 3
                //           ? context.colors.primary
                //           : context.colors.secondary,
                //     );
                //   },
                // ),

                const SizedBox(height: 32),

                const Text(
                  "Recommendation course",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // TODO: Add horizontal list of course cards
              ],
            ),
          ),
        ),
      ),
    );
  }
}
