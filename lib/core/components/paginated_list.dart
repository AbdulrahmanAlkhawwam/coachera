import 'package:coachera/core/components/bounded_list.dart';
import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shimmer/shimmer.dart';

typedef ItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
  int index,
);
typedef FetchPage<T> = Future<List<T>> Function(int page);
typedef ShimmerBuilder = Widget Function();

class PaginatedScrollList<T> extends StatefulWidget {
  final ItemBuilder itemBuilder;
  final Widget itemSeparator;
  final FetchPage<T> fetchPage;
  final ShimmerBuilder shimmerBuilder;
  final String errorMessage;

  final int pageSize;

  const PaginatedScrollList({
    super.key,
    required this.itemBuilder,
    required this.itemSeparator,
    required this.fetchPage,
    required this.shimmerBuilder,
    this.errorMessage = "Error loading more items. Tap to retry.",
    this.pageSize = 15,
  });

  @override
  State<PaginatedScrollList<T>> createState() => _PaginatedScrollListState<T>();
}

class _PaginatedScrollListState<T> extends State<PaginatedScrollList<T>> {
  final ScrollController _controller = ScrollController();
  final List<T> _items = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _page = 0;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadMore();

    _controller.addListener(() {
      if (_controller.position.pixels >=
              _controller.position.maxScrollExtent - 200 &&
          !_isLoading &&
          _hasMore) {
        _loadMore();
      }
    });
  }

  Future<void> _loadMore() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final newItems = await widget.fetchPage(_page);
      setState(() {
        _items.addAll(newItems);
        _page++;
        _hasMore = newItems.length == widget.pageSize;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
    }
  }

  Future<void> _refresh() async {
    setState(() {
      _items.clear();
      _page = 0;
      _hasMore = true;
    });
    await _loadMore();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.separated(
          controller: _controller,
          itemCount: _items.length + (_hasMore || _error != null ? 1 : 0),
          separatorBuilder: (context, index) => widget.itemSeparator,
          itemBuilder: (context, index) => index < _items.length
              ? widget.itemBuilder(context, _items[index], index)
              : _error != null
                  ? GestureDetector(
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
                    )
                  : Column(
                      children:
                          List.generate(2, (i) => widget.shimmerBuilder()),
                    ),
        ),
      ),
    );
  }
}
