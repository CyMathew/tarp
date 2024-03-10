import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModalWillScope extends StatelessWidget {
  const ModalWillScope({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;

        showCupertinoDialog<void>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
                  title: const Text('Should Close?'),
                  actions: <Widget>[
                    CupertinoButton(
                      child: const Text('Yes'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                    CupertinoButton(
                      child: const Text('No'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ));
      },
      child: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            leading: Container(), middle: const Text('Modal Page')),
        child: const Center(),
      ),
    ));
  }
}
