part of 'course_bloc.dart';

@immutable
sealed class CourseEvent {}

class GetCoursesPaginated extends CourseEvent {
  final int page;
  final bool reset;

  GetCoursesPaginated({
    required this.page,
    required this.reset,
  });
}

class GetRecommendedCourses extends CourseEvent {
  final ListParam param;

  GetRecommendedCourses({required this.param});
}

//
// abstract class CourseState extends Equatable {
//   const CourseState();
//
//   @override
//   List<Object> get props => [];
// }
//
// class CourseInitial extends CourseState {}
//
// class CourseLoading extends CourseState {
//   final bool isFirstFetch;
//   const CourseLoading({required this.isFirstFetch});
//
//   @override
//   List<Object> get props => [isFirstFetch];
// }
//
// class CourseLoaded extends CourseState {
//   final List<CourseModel> courses;
//   final bool hasReachedMax;
//
//   const CourseLoaded({
//     required this.courses,
//     this.hasReachedMax = false,
//   });
//
//   @override
//   List<Object> get props => [courses, hasReachedMax];
// }
//
// class CourseError extends CourseState {
//   final String message;
//   const CourseError({required this.message});
//
//   @override
//   List<Object> get props => [message];
// }
//
// class CourseBloc extends Bloc<CourseEvent, CourseState> {
//   final GetCoursesUseCase getCourses;
//
//   CourseBloc({required this.getCourses}) : super(CourseInitial()) {
//     on<GetCoursesPaginated>(_onGetCoursesPaginated);
//   }
//
//   Future<void> _onGetCoursesPaginated(
//       GetCoursesPaginated event,
//       Emitter<CourseState> emit,
//       ) async {
//     try {
//       // If it's the first page, show initial loading
//       if (event.page == 1) {
//         emit(CourseLoading(isFirstFetch: true));
//       }
//
//       final courses = await getCourses(page: event.page);
//
//       // Complete the completer if provided
//       event.completer?.complete(courses);
//
//       emit(CourseLoaded(
//         courses: courses,
//         hasReachedMax: courses.length < 15, // Assuming page size is 15
//       ));
//     } catch (e) {
//       // Complete the completer with error if provided
//       event.completer?.completeError(e);
//       emit(CourseError(message: e.toString()));
//     }
//   }
// }
