import 'sort_param.dart';

class ListParam {
  final SortParam sort;
  final int? pageSize;

  final int page;

  ListParam({
    this.pageSize,
    required this.page,
    required this.sort,
  });
}
