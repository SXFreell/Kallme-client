import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kallme/components/index.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

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
            const MyAppBar(title: "Kallme 设置", back: true, setting: false),
            const Expanded(
              child: SingleChildScrollView(child: SettingForm()),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingForm extends StatefulWidget {
  const SettingForm({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingForm();
}

class _SettingForm extends State<SettingForm> {
  List<String> formNames = ["domain", "port", "username", "password"];
  Map<String, String> formLabels = {
    "domain": "域名/IP",
    "port": "端口",
    "username": "用户名",
    "password": "密码",
  };
  Map<String, dynamic> focus = {};
  Map<String, dynamic> controller = {};

  @override
  void initState() {
    super.initState();
    for (var element in formNames) {
      focus[element] = FocusNode();
      controller[element] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var element in formNames) {
      controller[element].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "服务器配置",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    controller: controller["domain"],
                    focusNode: focus["domain"],
                    decoration: const InputDecoration(
                      labelText: "域名/IP",
                    ),
                    // enabled: false,
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: controller["port"],
                    focusNode: focus["port"],
                    decoration: const InputDecoration(
                      labelText: "端口",
                    ),
                    // enabled: false,
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.tertiaryContainer),
                    ),
                    child: const Text("修改服务器配置"),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: loginForm(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> loginForm(BuildContext context) {
    return [
      const Text(
        "用户登录",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      inputWidget("username", true),
      const SizedBox(height: 8.0),
      inputWidget("password", true),
      const SizedBox(height: 16.0),
      ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Theme.of(context).colorScheme.tertiaryContainer),
        ),
        child: const Text("登陆"),
      ),
    ];
  }

  TextField inputWidget(formName, enabled) {
    return TextField(
      controller: controller[formName],
      focusNode: focus[formName],
      onTapOutside: (event) => {
        focus[formName].unfocus(),
      },
      decoration: InputDecoration(
        labelText: formLabels[formName],
      ),
      enabled: enabled,
    );
  }
}
