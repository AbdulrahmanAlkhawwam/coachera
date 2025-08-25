import 'package:coachera/features/review/domain/use_cases/get_course_review_uc.dart';
import 'package:get_it/get_it.dart';

import '../../features/review/data/data_source/review_remote_data_source.dart';
import '../../features/review/domain/repositories/review_repository.dart';
import '../../features/review/data/repositories/review_repository_impl.dart';
import '../../features/review/domain/use_cases/get_reviews_uc.dart';
import '../../features/review/presentation/bloc/bloc/review_bloc.dart';

Future<void> initializeReviewServices(GetIt sl) async {
  sl.registerLazySingleton<ReviewRemoteDataSource>(
      () => ReviewRemoteDataSourceImpl(http: sl()));
  sl.registerLazySingleton<ReviewRepository>(
      () => ReviewRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<GetReviewsUC>(
    () => GetReviewsUC(repository: sl()),
  );
  sl.registerLazySingleton<GetCourseReviewUC>(
      () => GetCourseReviewUC(repository: sl()));
  sl.registerFactory<ReviewBloc>(() => ReviewBloc(
        getCourseReviewUC: sl(),
        getReviewsUC: sl(),
      ));
}
