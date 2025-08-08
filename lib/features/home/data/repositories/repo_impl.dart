import 'package:dartz/dartz.dart';
import 'package:proo/features/home/data/datasources/home_web_service.dart';
import 'package:proo/features/home/data/models/home/home.dart';
import 'package:proo/features/home/domain/repositories/repo.dart';

class RepoImpl  implements Repo{
  final HomeWebService homeWebService;

  RepoImpl(this.homeWebService);
  @override
  Future<Either<String, HomeModel>> getHomeData() async{
    try{

var result = await homeWebService.getHomeData();
return Right(HomeModel.fromJson(result.data));
    }catch (e) {
      return Left(e.toString());
    }
 
  }
}