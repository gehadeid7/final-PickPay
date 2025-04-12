abstract class Failures {
  final String message;

  Failures({required this.message});
  
}
class ServerFailure extends Failures
{
  ServerFailure({required super.message});
}