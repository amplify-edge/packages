import 'package:sys_account/api/v2/users.pbgrpc.dart' as rpc;
import 'package:grpc/grpc_web.dart';

class UserRepo {
  static final client = _accountClient();

  static Future<rpc.Account> getUser({String id}) async {
    final req = rpc.GetAccountRequest()..id = id;

    try {
      final resp = await client.getAccount(req).then((res) {
        print(res);
        return res;
      });
      return resp;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  static rpc.AccountServiceClient _accountClient() {
    final channel =
        GrpcWebClientChannel.xhr(Uri(host: "127.0.0.1", port: 8888));
    return rpc.AccountServiceClient(channel);
  }
}
