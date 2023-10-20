import 'package:flutter/material.dart';
import 'package:kallme/page/index.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final bool back;
  final bool setting;
  const MyAppBar({
    super.key,
    this.title = 'Kallme 推送',
    this.back = false,
    this.setting = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (back)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: SizedBox(
              width: 32,
              height: 32,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                ),
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: back ? 0.0 : 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Spacer(),
        if (setting)
          Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Row(
                children: [
                  SizedBox(
                      width: 32,
                      height: 32,
                      child: IconButton(
                        icon: const Icon(Icons.star_rounded),
                        iconSize: 28,
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SettingPage(),
                            ),
                          );
                        },
                      )),
                  const SizedBox(width: 6,),
                  SizedBox(
                      width: 32,
                      height: 32,
                      child: IconButton(
                        icon: const Icon(Icons.settings_rounded),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SettingPage(),
                            ),
                          );
                        },
                      )),
                ],
              )),
      ],
    );
  }
}



// PopupMenuButton(
//   itemBuilder: (BuildContext context) => <PopupMenuItem>[
//     PopupMenuItem(
//       onTap: () {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) => const SettingPage(),
//           ),
//         );
//       },
//       child: const Text('设置'),
//     ),
//     const PopupMenuItem(
//       child: Text('关于'),
//     ),
//   ],
//   onSelected: (value) {},
//   shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10)),
//   tooltip: "",
//   iconSize: 24,
//   padding: EdgeInsets.zero,
//   icon: const Icon(
//     Icons.menu_rounded,
//   ),
// ),