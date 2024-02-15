///A basic type which provides all necessary methods to add dependency to the graph
abstract interface class RegistrationController {

  ///Add unique instance of dependency. Each time when [factory] called a new
  ///instance of dependency provided. If there are more then one instance of one type
  ///objects then use [named] to receive the required object
  void factory<T extends Object>(T Function() factory, [String? named]);

  ///Add single instance of dependency. Each time when [singleton] called only one
  ///instance of dependency provided. If there are more then one instance of one type
  ///objects then use [named] to receive the required object
  void singleton<T extends Object>(T instance, [String? named]);
}