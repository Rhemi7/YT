
import 'package:equatable/equatable.dart';

///general/base failure class
abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

///server failure class that represents failure from remote data calls
class ServerFailure extends Failure {}

///cache failure class that represents failure from local data calls
class CacheFailure extends Failure {}

class ServerException implements Exception {}

class CacheException implements Exception {}

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'Maximum daily quota has been exceeded.\nPlease try again tomorrow';
    case CacheFailure:
      return 'No internet connection';
    default:
      return 'Unexpected error';
  }
}