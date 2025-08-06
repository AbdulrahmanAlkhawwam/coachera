import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/utils/message.dart';
import '../../../domain/entities/organization.dart';
import '../../../domain/use_cases/get_organization_uc.dart';

part 'organization_event.dart';

part 'organization_state.dart';

class OrganizationBloc extends Bloc<OrganizationEvent, OrganizationState> {
  final GetOrganizationUC getOrganizationUc;

  OrganizationBloc({
    required this.getOrganizationUc,
  }) : super(OrganizationState()) {
    // on<GetCategoryPaginated>(_getCategories);
  }

// FutureOr<void> _getCategories(
//   GetCategoryPaginated event,
//   Emitter<CategoryState> emit,
// ) async {
//   final isFirstPage = event.page == 0;
//
//   if (isFirstPage) {
//     emit(state.copyWith(
//       status: CourseStatus.loading,
//       courses: [],
//       message: null,
//     ));
//   }
//
//   final response = await getCategoriesUc.call(event.page);
//
//   response.fold(
//     (failure) {
//       event.completer.completeError(Message.fromFailure(failure));
//       emit(state.copyWith(
//         status: CourseStatus.error,
//         message: Message.fromFailure(failure),
//       ));
//     },
//     (newCourses) {
//       final updatedCourses = List<Category>.from(state.courses ?? [])
//         ..addAll(newCourses);
//
//       event.completer.complete(newCourses);
//
//       emit(state.copyWith(
//         status: CourseStatus.success,
//         courses: updatedCourses,
//       ));
//     },
//   );
// }
}
