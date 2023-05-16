import 'package:flutter_modular/flutter_modular.dart';
import './modules/core/core_module.dart';
import 'modules/login/login_module.dart';
import 'modules/template/base_layout.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/login/', module: LoginModule()),
        ChildRoute(
          '/',
          child: (context, args) => const BaseLayout(
            body: RouterOutlet(),
          ),
          transition: TransitionType.noTransition,
          children: [],
        ),
      ];
}
