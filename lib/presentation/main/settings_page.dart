import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:udemy_flutter_mvvm/app/app_preferences.dart';
import 'package:udemy_flutter_mvvm/app/di.dart';
import 'package:udemy_flutter_mvvm/data/data_source/local_data_source.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/assets_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/routes_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/strings_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/values_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          title: Text(
            AppStrings.changeLanguage.tr(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          leading: SvgPicture.asset(ImageAssets.changeLanguageIcon),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIcon),
          onTap: () {
            _changeLanguage();
          },
        ),
        ListTile(
          title: Text(
            AppStrings.contactUs.tr(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          leading: SvgPicture.asset(ImageAssets.contactUsIcon),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIcon),
          onTap: () {
            _contactUs();
          },
        ),
        ListTile(
          title: Text(
            AppStrings.inviteYourFriends.tr(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          leading: SvgPicture.asset(ImageAssets.inviteFriendsIcon),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIcon),
          onTap: () {
            _inviteFriends();
          },
        ),
        ListTile(
          title: Text(
            AppStrings.logout.tr(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          leading: SvgPicture.asset(ImageAssets.logoutIcon),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIcon),
          onTap: () {
            _logout();
          },
        )
      ],
    );
  }

  void _changeLanguage() {
    // add localization later
  }

  void _contactUs() {
    // open any web page with dummy content
  }

  void _inviteFriends() {
    // share app name with friends
  }

  void _logout() {
    _appPreferences.logout();
    _localDataSource.clearCache();
    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
  }
}
