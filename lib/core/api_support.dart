

class ApiSupport {

  ApiSupport._();
  // baseUrl
  static const String baseUrl = "https://690ef592bd0fefc30a063549.mockapi.io";

  //endPoints

static const login = "/login";
static const order = "/order";
static String deleteOrder (String id)=> "/order/$id";
}