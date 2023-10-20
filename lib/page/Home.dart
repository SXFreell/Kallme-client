import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kallme/components/index.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: Theme.of(context).colorScheme.brightness == Brightness.light
          ? SystemUiOverlayStyle.dark
          : SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top),
            const MyAppBar(),
            const Expanded(
              child: NotificationList(),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationList extends StatefulWidget {
  const NotificationList({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _NotificationList();
}

class _NotificationList extends State<NotificationList> {
  final Map<String, VoidCallback> _mapForHideActions = {};
  final List<Map> _notificationList = [
    {
      'title': "消息标题",
      'content': "这里是消息详情",
      'time': "2001-11-01 01:02:03",
      'icon': Icons.notifications_active_outlined,
    }
  ];

  void _addNotification() {
    setState(() {
      _notificationList.add({
        'title': "消息标题",
        'content': "这里是消息详情\n这里是消息详情",
        'time': DateTime.now().toString(),
        'icon': Icons.notifications_active_outlined,
      });
    });
  }

  Widget _buildNotificationItem(Map item) {
    return NotificationItem(
      title: item['title'],
      content: item['content'],
      time: item['time'],
      icon: item['icon'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextButton(
            onPressed: _addNotification,
            child: const Text(
              "添加推送",
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _notificationList.length,
              itemBuilder: (context, index) {
                Map item = _notificationList[index];
                String tempKey = item.toString();
                return MySlider(
                  key: Key(tempKey),
                  actionsWidth: 132,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 6.0),
                      child: IconButton(
                        onPressed: () {
                        },
                        icon: const Icon(Icons.star_rounded,
                        size: 28,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 24.0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _notificationList.removeAt(index);
                          });
                        },
                        icon: const Icon(Icons.delete_rounded,
                        size: 28,
                        color: Colors.red,),
                      ),
                    ),
                  ],
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: _buildNotificationItem(item),
                  ),
                  actionsWillShow: () {
                    for (int i = 0; i < _notificationList.length; i++) {
                      if (index == i) {
                        continue;
                      }
                      String tempKey = _notificationList[i].toString();
                      VoidCallback? hideActions = _mapForHideActions[tempKey];
                      if (hideActions != null) {
                        hideActions();
                      }
                    }
                  },
                  exportHideActions: (hideActions) {
                    _mapForHideActions[tempKey] = hideActions;
                  },
                );
                // return const MySlider(child: Text("123"));
              }
            ),
        ),
      ],
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String content;
  final String time;
  final IconData icon;
  const NotificationItem({
    super.key,
    required this.title,
    required this.content,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Card(
        // color: Theme.of(context).colorScheme.tertiaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  // color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: const TextStyle(
                    // color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0, bottom: 4.0),
              child: Text(
                content,
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Row(
              children: [
                Icon(Icons.access_time,
                    size: 14, color: Theme.of(context).colorScheme.secondary),
                const SizedBox(width: 4),
                Text(
                  time,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
