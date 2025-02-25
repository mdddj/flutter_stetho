import 'dart:async';
import 'dart:io';

import 'package:flutter_stetho_null_safety/src/utils.dart';

import 'http_client_request.dart';
import 'inspector_request.dart';
import 'method_channel_controller.dart';


class StethoHttpClient implements HttpClient {
  final HttpClient? client;

  StethoHttpClient(
      {required this.client,
      this.autoUncompress = false,
      this.idleTimeout = const Duration(seconds: 5)});

  @override
  bool autoUncompress;

  @override
  Duration idleTimeout;

  @override
  Duration? connectionTimeout;

  @override
  int? maxConnectionsPerHost;

  @override
  String? userAgent;

  @override
  void addCredentials(
    Uri url,
    String realm,
    HttpClientCredentials credentials,
  ) {
    client!.addCredentials(url, realm, credentials);
  }

  @override
  void addProxyCredentials(
    String host,
    int port,
    String realm,
    HttpClientCredentials credentials,
  ) {
    client!.addProxyCredentials(host, port, realm, credentials);
  }

  @override
  set authenticate(
    Future<bool> Function(Uri url, String scheme, String? realm)? f,
  ) {
    client!.authenticate = f;
  }

  @override
  set authenticateProxy(
    Future<bool> Function(String host, int port, String scheme, String? realm)?
        f,
  ) {
    client!.authenticateProxy = f;
  }

  @override
  set badCertificateCallback(
    bool Function(X509Certificate cert, String host, int port)? callback,
  ) {
    client!.badCertificateCallback = callback;
  }

  @override
  void close({bool force = false}) {
    client!.close();
  }

  @override
  Future<HttpClientRequest> get(String host, int port, String path) =>
      open("get", host, port, path);

  @override
  Future<HttpClientRequest> getUrl(Uri url) => openUrl("get", url);

  @override
  Future<HttpClientRequest> post(String host, int port, String path) =>
      open("post", host, port, path);

  @override
  Future<HttpClientRequest> postUrl(Uri url) => openUrl("post", url);

  @override
  Future<HttpClientRequest> put(String host, int port, String path) =>
      open("put", host, port, path);

  @override
  Future<HttpClientRequest> putUrl(Uri url) => openUrl("put", url);

  @override
  Future<HttpClientRequest> delete(String host, int port, String path) =>
      open("delete", host, port, path);

  @override
  Future<HttpClientRequest> deleteUrl(Uri url) => openUrl("delete", url);

  @override
  Future<HttpClientRequest> head(String host, int port, String path) =>
      open("head", host, port, path);

  @override
  Future<HttpClientRequest> headUrl(Uri url) => openUrl("head", url);

  @override
  Future<HttpClientRequest> patch(String host, int port, String path) =>
      open("patch", host, port, path);

  @override
  Future<HttpClientRequest> patchUrl(Uri url) => openUrl("patch", url);

  @override
  set findProxy(String Function(Uri url)? f) => client!.findProxy = f;

  @override
  Future<HttpClientRequest> open(
    String method,
    String host,
    int port,
    String path,
  ) async {
    final Uri uri = Uri(host: host, port: port, path: path);
    return openUrl(method, uri);
  }

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) async {
    return client!.openUrl(method, url).then((request) {
      final wrapped = _wrapResponse(request);
      final List<int> body = [];
      if (method.toLowerCase() != 'post' && method.toLowerCase() != 'put') {
        scheduleMicrotask(() {
          MethodChannelController.requestWillBeSent(
            FlutterStethoInspectorRequest(
              url: request.uri.toString(),
              headers: headersToMap(request.headers),
              method: request.method,
              id: wrapped.id,
              body: body,
            ),
          );
        });
      } else {
        wrapped.stream.listen((onData) {
          body.addAll(onData as Iterable<int>);
          scheduleMicrotask(() {
            MethodChannelController.requestWillBeSent(
              FlutterStethoInspectorRequest(
                url: request.uri.toString(),
                headers: headersToMap(request.headers),
                method: request.method,
                id: wrapped.id,
                body: body,
              ),
            );
          });
        });
      }

      return wrapped;
    });
  }

  StethoHttpClientRequest _wrapResponse(HttpClientRequest request) {
    final id = Uuid().generateV4();

    return StethoHttpClientRequest(request, id);
  }
}
