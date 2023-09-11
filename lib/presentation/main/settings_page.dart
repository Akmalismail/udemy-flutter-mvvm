import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/assets_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/strings_manager.dart';
import 'package:udemy_flutter_mvvm/presentation/resources/values_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          title: Text(
            AppStrings.changeLanguage,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          leading: SvgPicture.asset(ImageAssets.changeLanguageIcon),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIcon),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            AppStrings.contactUs,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          leading: SvgPicture.asset(ImageAssets.contactUsIcon),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIcon),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            AppStrings.inviteYourFriends,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          leading: SvgPicture.asset(ImageAssets.inviteFriendsIcon),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIcon),
          onTap: () {},
        ),
        ListTile(
          title: Text(
            AppStrings.logout,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          leading: SvgPicture.asset(ImageAssets.logoutIcon),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIcon),
          onTap: () {},
        )
      ],
    );
  }
}
