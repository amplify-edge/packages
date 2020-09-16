import 'package:hive/hive.dart';
import 'package:sys_core/src/api/accounts.pb.dart';

class HiveProtoUserAdapter extends TypeAdapter<User> {
  @override
  final typeId = 3;

  @override
  User read(BinaryReader reader) {
    return User.fromBuffer(reader.read());
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.write(obj.writeToBuffer());
  }
}
