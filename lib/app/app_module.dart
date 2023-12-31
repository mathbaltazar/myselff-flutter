import 'package:flutter_modular/flutter_modular.dart';
import 'package:myselff_flutter/app/modules/expenses/expense_module.dart';

import 'core/routes/app_routes.dart';

class AppModule extends Module {

  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          AppRoutes.initialRoute,
          module: ExpenseModule(),
        ),
      ];
}
