import '../../../home/domain/param/list_param.dart';
import '../entities/entity.dart';

class SearchParam {
  final String input;
  final ListParam param;
  final Entity entity;

  SearchParam({
    required this.entity,
    required this.param,
    required this.input,
  });
}
