

class RoutingData{

  final String route;
  final Map<String,String> _queryParameters;

  RoutingData({this.route, queryParameters}) : _queryParameters = queryParameters;

  operator [](String key) => _queryParameters[key];

  
}