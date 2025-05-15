import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:news_xproject/core/helpers/error_handler.dart';

Future<T> executeTryCatchData<T>(Future<T> Function() function) async {
  try {
    return await function();
  } on SocketException catch (_) {
    throw NetworkException();
  } on HttpException catch (e) {
    throw ServerException('HTTP Error: ${e.message}');
  } on FormatException catch (e) {
    throw ParseException('Format Error: ${e.message}');
  } on ApiException {
    rethrow; // If it's already an ApiException, just rethrow it
  } catch (e) {
    throw ApiException('Unexpected error: $e');
  }
}


Future<Either<ApiException, T>> executeTryCatchRepo<T>(
    Future<T> Function() function) async {
  try {
    final result = await function();
    return Right(result);
  } on NetworkException catch (e) {
    return Left(e);
  } on ServerException catch (e) {
    return Left(e);
  } on ClientException catch (e) {
    return Left(e);
  } on ParseException catch (e) {
    return Left(e);
  } on ApiException catch (e) {
    return Left(e);
  } catch (e) {
    return Left(ApiException('Unexpected error: $e'));
  }
}