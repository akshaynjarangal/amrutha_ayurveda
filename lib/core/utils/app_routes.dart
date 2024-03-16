import 'package:ayurveda/di/di.dart';
import 'package:ayurveda/presentation/provider/login_provider.dart';
import 'package:ayurveda/presentation/screens/home_screen.dart';
import 'package:ayurveda/presentation/screens/login_screen.dart';
import 'package:ayurveda/presentation/screens/registration_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GoRouter router = GoRouter(
  initialLocation: '/registration',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
          path: 'registration',
          name: 'registration',
          builder: (context, state) {
            return const RegistrationScreen();
          },
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, GoRouterState state) {
        return ChangeNotifierProvider(
          create: (context) => getIt<LoginProvider>(),
          child: const LoginScreen(),
        );
      },
    ),
  ],
);
