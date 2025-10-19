import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'api_services.g.dart';

@RestApi()
@injectable
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;
}
