import 'package:dartz/dartz.dart';
import 'package:pickpay/core/entities/product_entity.dart';
import 'package:pickpay/core/errors/failures.dart';
import 'package:pickpay/core/models/product_model.dart';
import 'package:pickpay/core/repos/product_repo/products_repo.dart';
import 'package:pickpay/core/services/database_services.dart';
import 'package:pickpay/core/utils/backend_endpoints.dart';

class ProductRepoImpl extends ProductsRepo {
  final DatabaseService databaseService;

  ProductRepoImpl(this.databaseService);

  @override
  Future<Either<Failure, List<ProductEntity>>> getBestSellingProducts() async {
    try {
      var data = await databaseService.getData(
          path: BackendEndpoints.getProducts,
          query: {
            'Limit': 5,
            'orderBy': 'sellingCount',
            'descending': true
          }) as List<Map<String, dynamic>>;

      List<ProductEntity> products =
          data.map((e) => ProductModel.fromJson(e).toEntity()).toList();

      return right(products);
    } catch (e) {
      return left(ServerFailure('failed to get product'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      var data = await databaseService.getData(
          path: BackendEndpoints.getProducts) as List<Map<String, dynamic>>;

      List<ProductEntity> products =
          data.map((e) => ProductModel.fromJson(e).toEntity()).toList();

      return right(products);
    } catch (e) {
      return left(ServerFailure('failed to get product'));
    }
  }
}
