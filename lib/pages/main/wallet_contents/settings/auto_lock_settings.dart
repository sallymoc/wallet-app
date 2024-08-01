import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:qubic_wallet/styles/edgeInsets.dart';
import 'package:qubic_wallet/flutter_flow/theme_paddings.dart';
import 'package:qubic_wallet/di.dart';
import 'package:qubic_wallet/stores/settings_store.dart';
import 'package:qubic_wallet/styles/textStyles.dart';

class AutoLockSettings extends StatelessWidget {
  final SettingsStore settingsStore = getIt<SettingsStore>();

  final List<int> _minuteList = [1, 3, 5, 10, 15, 20, 30, 45, 60];

  AutoLockSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          minimum: ThemeEdgeInsets.pageInsets
              .copyWith(left: 0, right: 0, top: 0, bottom: 0),
          child: Column(children: [
            Expanded(
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                child: getBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
      children: [
        getHeader(),
        getAutoLockBody(),
      ],
    );
  }

  Widget getHeader() {
    return Padding(
        padding: const EdgeInsets.only(
            left: ThemePaddings.normalPadding,
            right: ThemePaddings.normalPadding,
            top: ThemePaddings.hugePadding,
        bottom: ThemePaddings.smallPadding,
      ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Auto-Lock Settings", style: TextStyles.pageTitle),
        ],
      ),
    );
  }

  Widget getAutoLockBody() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (context) {
          return Column(
              children: [
                ListTile(
                  title: Text('Immediately', style: TextStyles.textNormal),
                  onTap: () {
                    settingsStore.setAutoLockTimeout(0);
                  },
                  trailing: settingsStore.settings.autoLockTimeout == 0
                      ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                      : null,
                ),
                for (int i = 0; i < _minuteList.length; i++)
                  ListTile(
                    title: Text('${_minuteList[i]} minutes',
                        style: TextStyles.textNormal),
                    onTap: () {
                      settingsStore.setAutoLockTimeout(_minuteList[i]);
                    },
                    trailing:
                        settingsStore.settings.autoLockTimeout == _minuteList[i]
                            ? Icon(Icons.check,
                                color: Theme.of(context).primaryColor)
                            : null,
                  ),
              ],
            );
          },
        ),
    );
  }
}
