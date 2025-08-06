import 'package:coachera/core/components/bounded_list.dart';
import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

typedef ItemBuilder<T> = Widget Function(BuildContext context, T item, int index);
typedef FetchPage<T> = Future<void> Function(int page);
typedef ShimmerBuilder = Widget Function();

class PaginatedScrollList<T> extends StatefulWidget {
  final ItemBuilder<T> itemBuilder;
  final Widget itemSeparator;
  final FetchPage<T> fetchPage;
  final List<T> listItem;
  final ShimmerBuilder shimmerBuilder;
  final String errorMessage;
  final int pageSize;

  const PaginatedScrollList({
    super.key,
    required this.itemBuilder,
    required this.itemSeparator,
    required this.fetchPage,
    required this.listItem,
    required this.shimmerBuilder,
    this.errorMessage = "Error loading more items. Tap to retry.",
    this.pageSize = 15,
  });

  @override
  State<PaginatedScrollList<T>> createState() => _PaginatedScrollListState<T>();
}

class _PaginatedScrollListState<T> extends State<PaginatedScrollList<T>> {
  final ScrollController _controller = ScrollController();
  int _page = 0;
  bool _isFetching = false;
  bool _hasMore = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMore();

    _controller.addListener(() {
      if (_controller.position.pixels >= _controller.position.maxScrollExtent - 200 &&
          !_isFetching &&
          _hasMore) {
        _loadMore();
      }
    });
  }

  Future<void> _loadMore() async {
    if (_isFetching) return;

    setState(() {
      _isFetching = true;
      _error = null;
    });

    try {
      await widget.fetchPage(_page);
      setState(() {
        _page++;
        _hasMore = widget.listItem.length >= _page * widget.pageSize;
        _isFetching = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isFetching = false;
      });
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _page = 0;
      _hasMore = true;
    });
    await widget.fetchPage(0);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.separated(
          controller: _controller,
          itemCount: widget.listItem.length + (_hasMore || _error != null ? 1 : 0),
          separatorBuilder: (context, index) => widget.itemSeparator,
          itemBuilder: (context, index) {
            if (index < widget.listItem.length) {
              return widget.itemBuilder(context, widget.listItem[index], index);
            } else if (_error != null) {
              return GestureDetector(
                onTap: _loadMore,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      widget.errorMessage,
                      style: context.textTheme.bodyMedium
                          ?.copyWith(color: context.colors.error),
                    ),
                  ),
                ),
              );
            } else {
              return Column(
                children: List.generate(2, (i) => widget.shimmerBuilder()),
              );
            }
          },
        ),
      ),
    );
  }
}
