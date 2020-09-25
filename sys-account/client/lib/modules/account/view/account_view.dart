import 'package:flutter/material.dart';
import 'package:sys_account/modules/account/view_model/account_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:sys_account/core/core.dart';
import 'package:sys_account/core/shared_repositories/auth_repo.dart'
    as authRepo;
import 'package:sys_account/core/shared_repositories/user_repo.dart'
    as accountRepo;

class AccountView extends StatefulWidget {
  const AccountView({Key key, this.campaignID}) : super(key: key);
  final String campaignID;
  @override
  AccountViewState createState() => AccountViewState();
}

class AccountViewState extends State<AccountView> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _refreshCtrl = TextEditingController();
  final _accountIdCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _refreshCtrl.dispose();
    _accountIdCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: AccountViewModel(),
      onModelReady: (AccountViewModel model) {
        _emailCtrl.text = model.getEmail;
        _passwordCtrl.text = model.getPassword;
        _accountIdCtrl.text = model.accountId;
      },
      builder: (context, AccountViewModel model, child) => Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: <Widget>[
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Sys-Account Example',
                  style: Theme.of(context).textTheme.headline4),
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _emailCtrl,
                enabled: model.isEmailEnabled,
                onChanged: (value) => {model.setEmail(value)},
                decoration: InputDecoration(
                  labelText: ModAccountLocalizations.of(context)
                          .translate('emailAddress') +
                      ' *',
                  labelStyle: Theme.of(context).textTheme.bodyText2,
                  suffix: const Icon(Icons.email),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _passwordCtrl,
                obscureText: false,
                enabled: model.isPasswordEnabled,
                onChanged: (value) => {model.setPassword(value)},
                decoration: InputDecoration(
                  labelText:
                      ModAccountLocalizations.of(context).translate('password'),
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                  suffix: Icon(Icons.lock_outline),
                ),
              ),
            ),
            SubmitRequestButton(
              isLoading: model.buzy,
              onPressed: () async {
                model.enableEmailField(false);
                model.enablePasswordField(false);
                model.enableAccountField(false);
                model.setBuzy(true);
                final resp = await authRepo.AuthRepo.loginUser(
                  email: model.getEmail,
                  password: model.getPassword,
                );
                if (resp.success) {
                  model.enablePasswordField(true);
                  model.enableEmailField(true);
                  model.enableRefreshField(true);
                  model.enableAccountField(true);
                  model.setAccessToken(resp.accessToken);
                  model.setRefreshToken(resp.refreshToken);
                  _refreshCtrl.text = model.refreshToken;
                  model.enableResponseView(true);
                  model.setResponse(resp.toString());
                }
                model.setBuzy(false);
              },
              functionName: "Login Request",
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _refreshCtrl,
                obscureText: false,
                enabled: model.isRefreshTokenEnabled,
                onChanged: (value) => {model.setRefreshToken(value)},
                decoration: InputDecoration(
                  labelText: 'refresh token',
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                  suffix: Icon(Icons.refresh_outlined),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            SubmitRequestButton(
              isLoading: model.buzy,
              onPressed: () async {
                model.enableRefreshField(false);
                model.setBuzy(true);
                final resp = await authRepo.AuthRepo.renewAccessToken(
                  refreshToken: model.refreshToken,
                );
                model.enableRefreshField(true);
                _refreshCtrl.text = model.refreshToken;
                model.setAccessToken(resp.accessToken);
                model.enableResponseView(true);
                model.setResponse(resp.toString());
                model.setBuzy(false);
              },
              functionName: "Get Refresh Token",
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                controller: _accountIdCtrl,
                obscureText: false,
                enabled: model.isAccountEnabled,
                onChanged: (value) => {model.setAccountId(value)},
                decoration: InputDecoration(
                  labelText: 'account id',
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                  suffix: Icon(Icons.account_circle),
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            SubmitRequestButton(
                isLoading: model.buzy,
                onPressed: () async {
                  model.enableAccountField(false);
                  model.setBuzy(true);
                  final resp = await accountRepo.UserRepo.getUser(
                    id: model.accountId,
                    accessToken: model.accessToken,
                  );
                  model.enableAccountField(true);
                  model.enableResponseView(true);
                  model.setResponse(resp.toString());
                  model.setBuzy(false);
                },
                functionName: "Get Account By Id"),
            const SizedBox(height: 16.0),
            model.hasResponse
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        Text(
                          model.response,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: Colors.green[400],
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'No response',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Colors.red[400],
                            fontWeight: FontWeight.bold,
                          ),
                    )),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<Widget>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (BuildContext con) {
        return Scrollbar(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 40,
                  color: Theme.of(context).colorScheme.secondaryVariant,
                  height: 4,
                ),
              ),
              const SizedBox(height: 8),
/*               const ListTile(
                title: Text(
                    'Currently in development, to assure a highly secure system based on End to End encryption principles. On the users devices all user data is encrypted at rest against the users public key. On our servers, all data in transit or at rest is encrypted against the users public key. User aggregation is not done.'),
              ), */
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8.0),
                  children: <Widget>[
                    const SizedBox(height: 24),
                    ListTile(
                      title: Text(ModAccountLocalizations.of(context)
                          .translate('privacyPolicy')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SubmitRequestButton extends StatelessWidget {
  const SubmitRequestButton({
    Key key,
    @required bool isLoading,
    @required Function onPressed,
    @required String functionName,
  })  : _isLoading = isLoading,
        _onPressed = onPressed,
        _functionName = functionName,
        super(key: key);

  final bool _isLoading;
  final Function _onPressed;
  final String _functionName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: RaisedButton(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: !_isLoading
                      ? Text('Submit ' + _functionName,
                          style: Theme.of(context).textTheme.bodyText1)
                      : CircularProgressIndicator(),
                  onPressed: _onPressed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
