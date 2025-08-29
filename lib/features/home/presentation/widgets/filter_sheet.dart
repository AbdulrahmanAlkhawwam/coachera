import 'package:coachera/core/components/section_title.dart';
import 'package:coachera/core/components/tag_item.dart';
import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';

import '../../../category/domain/entities/category.dart';

class FilterSheet extends StatefulWidget {
  final List<Category>? categories;
  final List<String>? sortOptions;
  final List<String>? priceRanges;
  final int? starsLength;

  final Function(FilterData) onFilter;

  const FilterSheet({
    super.key,
    this.categories,
    this.sortOptions,
    this.priceRanges,
    this.starsLength,
    required this.onFilter,
  });

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  int? selectedCategoryId;
  String? selectedSort;
  String? selectTypeSort;

  String? selectedPrice;
  int? selectedStars;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),

              if (widget.categories != null &&
                  widget.categories!.isNotEmpty) ...[
                const SizedBox(height: 8.0),
                const SectionTitle(title: "Categories"),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.categories!.map((cat) {
                    bool isSelected = selectedCategoryId == cat.id;
                    return TagItem(
                      isSelected: isSelected,
                      onSelect: (_) =>
                          setState(() => selectedCategoryId = cat.id),
                      text: cat.title,
                    );
                  }).toList(),
                ),
              ],

              // Sort by
              if (widget.sortOptions != null &&
                  widget.sortOptions!.isNotEmpty) ...[
                const SizedBox(height: 8.0),
                const SectionTitle(title: "Sort By"),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...widget.sortOptions!.map((option) {
                      bool isSelected = selectedSort == option;
                      return TagItem(
                        isSelected: isSelected,
                        onSelect: (_) => setState(() => selectedSort = option),
                        text: option,
                      );
                    }),
                  ],
                ),
              ],
              const SizedBox(height: 8.0),
              const SectionTitle(title: "Sort Direction"),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ...["Ascending", "Descending"].map((option) {
                    bool isSelected = selectTypeSort == option;
                    return TagItem(
                      isSelected: isSelected,
                      onSelect: (_) => setState(() => selectTypeSort = option),
                      text: option,
                    );
                  }),
                ],
              ),

              // Price ranges
              if (widget.priceRanges != null &&
                  widget.priceRanges!.isNotEmpty) ...[
                const SizedBox(height: 20),
                const SectionTitle(title: "Price"),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ...["More than", "Less than", ...widget.priceRanges!]
                        .map((price) {
                      bool isSelected = selectedPrice == price;
                      return TagItem(
                        isSelected: isSelected,
                        onSelect: (_) => setState(() => selectedPrice = price),
                        text: price,
                      );
                    }),
                  ],
                ),
              ],

              // Stars
              if (widget.starsLength != null && widget.starsLength != 0) ...[
                const SizedBox(height: 20),
                const SectionTitle(title: "Star Rating"),
                Row(
                  spacing: 8,
                  children: List.generate(widget.starsLength!, (index) {
                    int stars = index + 1;
                    bool isSelected = selectedStars == stars;
                    return TagItem(
                      isSelected: isSelected,
                      onSelect: (_) => setState(() => selectedStars = stars),
                      text: stars.toString(),
                      avatar: Icon(
                        Icons.star,
                        color: isSelected
                            ? context.colors.secondary
                            : context.colors.outline,
                        size: 20,
                      ),
                    );
                  }),
                ),
              ],
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => widget.onFilter(
                    FilterData(
                      categoryId: selectedCategoryId,
                      sortBy: selectedSort,
                      price: selectedPrice != null
                          ? double.tryParse(selectedPrice!)
                          : null,
                      star: selectedStars,
                    ),
                  ),
                  child: const Text(
                    "Apply Filters",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Filter",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
  }
}

class FilterData {
  final int? categoryId;
  final String? sortBy;
  final String? sortType;

  final double? price;
  final int? star;

  FilterData({
    this.categoryId,
    this.sortBy,
    this.sortType,
    this.price,
    this.star,
  });

  @override
  String toString() => ' categoryId = ${categoryId.toString()} , '
      'sortBy = ${sortBy.toString()} , '
      'price = ${price.toString()} , '
      'stars = ${star.toString()} ';
}
