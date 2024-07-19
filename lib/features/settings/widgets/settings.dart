import '../cubit/cubit.dart';
import 'settings_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../data/model/setting_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../authentication/presentation/cubits/user_cubit/cubit.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 10),
      children: [
        SettingsSectionWidget(
          sectionTitle: 'General',
          settingItems: [
            SettingItem(
              title: 'All Orders',
              icon: Icons.shopping_basket_sharp,
              backgroundColor: const Color(0xfff26427),
              onTap: () {
                // Navigate to All Orders screen
              },
            ),
            SettingItem(
              title: 'Wishlist',
              icon: Icons.favorite,
              backgroundColor: const Color(0xff56c0a2),
              onTap: () {
                // Navigate to Wishlist screen
              },
            ),
            SettingItem(
              title: 'Address',
              icon: Icons.map_sharp,
              backgroundColor: const Color(0xff1a98d4),
              onTap: () {
                // Navigate to Address screen
              },
            ),
            SettingItem(
              title: 'Browsing History',
              icon: Icons.history_sharp,
              backgroundColor: const Color(0xff3f3e56),
              onTap: () {
                // Navigate to Browsing History screen
              },
            ),
          ],
        ),
        SettingsSectionWidget(
          sectionTitle: 'Settings',
          settingItems: [
            SettingItem(
              title: 'Dark Theme',
              icon: Icons.brightness_6_outlined,
              backgroundColor: const Color(0xff353430),
              trailing: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  bool isDarkTheme = false; // default value
                  if (state is SettingsThemeChanged) {
                    isDarkTheme = state.isDarkTheme;
                  }
                  return Switch(
                    value: isDarkTheme,
                    onChanged: (value) {
                      // Toggle theme action
                      if (kDebugMode) {
                        print("switch");
                      }
                      context.read<SettingsCubit>().toggleTheme(value);
                    },
                  );
                },
              ),
            ),
          ],
        ),
        SettingsSectionWidget(
          sectionTitle: 'About The App',
          settingItems: [
            SettingItem(
              title: 'Privacy Policy',
              icon: Icons.lock_person_sharp,
              backgroundColor: const Color(0xff56c0a2),
              onTap: () {
                // Navigate to Privacy Policy screen
              },
            ),
            SettingItem(
              title: 'Log out',
              icon: Icons.power_settings_new_rounded,
              backgroundColor: const Color(0xffe91d25),
              onTap: () {
                // Log out action
                context.read<UserCubit>().logoutUser(context);
              },
            ),
          ],
        ),
      ],
    );
  }
}
