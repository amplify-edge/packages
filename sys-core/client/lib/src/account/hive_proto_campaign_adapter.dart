import 'package:hive/hive.dart';
import 'package:sys_core/src/api/accounts.pb.dart';

class HiveProtoCampaignAdapter extends TypeAdapter<Campaign>{
  @override
  final typeId = 2;

  @override
  Campaign read(BinaryReader reader) {
    return Campaign.fromBuffer(reader.read());
  }

  @override
  void write(BinaryWriter writer, Campaign obj) {
    writer.write(obj.writeToBuffer());
  }
}
