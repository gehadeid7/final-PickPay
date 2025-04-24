import 'package:dartz/dartz.dart';
import 'package:pickpay/core/entities/product_entity.dart';
import 'package:pickpay/core/errors/failures.dart';

abstract class  ProductsRepo {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, List<ProductEntity>>> getBestSellingProducts();

}
