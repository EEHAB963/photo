
 
  import 'failures.dart';
import 'streing/textError.dart';

String massaeFailure(Failur failur) {
    switch (failur.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE;
      case EmptyCacheFailure:
        return EMPTY_FAILURE;
      case OfflineFailure:
        return OFFLIN_FAILURE;

      default:
        return " Unexpected Error,Please try again later";
    }
  }

