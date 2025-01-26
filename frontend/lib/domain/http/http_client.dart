import 'package:http/http.dart' as http;

abstract class IHttpClient {
  Future get({required String url});

  Future post({required String url, required String body});

  Future delete({required String url, required int id});

  Future put({required String url, required String body});
}

class HttpClient extends IHttpClient {
  final client = http.Client();

  @override
  Future get({required String url}) async {
    return await client.get(Uri.parse(url));
  }
  
  @override
  Future post({required String url, required String body}) async {
    return await client.post(Uri.parse(url), headers: {'Content-Type': 'application/json'}, body: body);
  }
  
  @override
  Future delete({required String url, required int id}) {
    return client.delete(Uri.parse('$url/$id'), headers: {'Content-Type': 'application/json'});
  }
  
  @override
  Future put({required String url, required String body}) {
    return client.put(Uri.parse(url), headers: {'Content-Type': 'application/json'}, body: body);
  }
}
