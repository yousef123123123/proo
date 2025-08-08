import 'package:dartz/dartz.dart';
import 'package:proo/features/home/data/models/home/home.dart';

abstract class Repo{
  Future<Either<String, HomeModel>> getHomeData();
}