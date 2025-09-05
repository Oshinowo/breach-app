import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'features/blog/viewmodel/categories_provider.dart';
import 'features/blog/viewmodel/posts_provider.dart';
import 'features/interests/viewmodel/interests_provider.dart';
import 'routes/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Posts()),
        ChangeNotifierProvider(create: (_) => Categories()),
        ChangeNotifierProvider(create: (_) => Interests()),
      ],
      child: BreachApp(),
    ),
  );
}

class BreachApp extends StatelessWidget {
  const BreachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MaterialApp.router(
        title: 'Breach',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: const Color(0XFFffffff),
          useMaterial3: true,
          // primarySwatch: Palette.kCustomColour,
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme,
          ).copyWith(bodyMedium: const TextStyle(fontSize: 16.0)),
        ),
        routerConfig: router,
      ),
    );
  }
}
