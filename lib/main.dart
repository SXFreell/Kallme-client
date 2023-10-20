import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'page/Home.dart';
import 'theme/color_schemes.g.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CN'),
        Locale('en', 'US'),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Kallme',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      home: const MyHomePage(),
    );
  }
}






// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         toolbarHeight: 0,
//         systemOverlayStyle: SystemUiOverlayStyle.light,
//       ),
//       // appBar: AppBar(
//       //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       //   title: Text(widget.title),
//       // ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(widget.title),
//             Text(widget.title),
//             Text(widget.title),
//             Text(widget.title),
//             Text(widget.title),
//             Text(widget.title),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: '首页',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.business),
//             label: '商家',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.school),
//             label: '学校',
//           ),
//         ],
//       ),

//     );
//   }
// }
