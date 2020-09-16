//import 'package:hive/hive.dart';
import 'package:sys_core/src/api/accounts.pb.dart';

abstract class AccountsRepository {
  Future<User> loadUser();

  Future saveUser(User user);

  Future<List<Campaign>> loadCampaigns();

  Future saveCampaign(Campaign campaign);

  void dispose();
}
/*
class LocaleAccountsRepository extends AccountsRepository {
  static final String userBoxName = "LocaleAccountsRepositoryUser";
  static final String campaignBoxName = "LocaleAccountsRepositoryCampaign";
  static final String userKey = "user-key";
  Future<Box> _userBoxOpener;
  Box _userBox;
  Future<Box> _campaignBoxOpener;
  Box _campaignBox;

  LocaleAccountsRepository() {
    _userBoxOpener = Hive.openBox(userBoxName);
    _userBoxOpener.then((value) => _userBox = value);

    _campaignBoxOpener = Hive.openBox(campaignBoxName);
    _campaignBoxOpener.then((value) => _campaignBox = value);
  }

  Future<void> _ensureBoxOpened() async {
    if (_userBox == null) await _userBoxOpener;
    if (_campaignBox == null) await _campaignBoxOpener;
  }

  Future<User> loadUser() async {
    await _ensureBoxOpened();
    return _userBox.get(userKey);
  }

  Future saveUser(User user) async {
    await _ensureBoxOpened();
    return _userBox.put(userKey, user);
  }

  Future<List<Campaign>> loadCampaigns() async {
    await _ensureBoxOpened();
    return _campaignBox.values;
  }

  Future saveCampaign(Campaign campaign) async {
    await _ensureBoxOpened();
    _campaignBox.put(campaign.id, campaign);
  }

  @override
  void dispose() {
    _userBox?.close();
    _campaignBox?.close();
  }
}
*/