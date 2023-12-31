import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    Animate.restartOnHotReload = true;
    GoogleFonts.config.allowRuntimeFetching = false;
    await initializeDateFormatting('pt_BR', null);

    runApp(
      ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    );
  }, (error, stack) {
    print('MYSELFF-FLUTTER error > $error');
    print('MYSELFF-FLUTTER stack > $stack');
  });
}