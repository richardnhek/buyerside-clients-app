import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'auth/firebase_auth/firebase_user_provider.dart';
import 'auth/firebase_auth/auth_util.dart';

import 'backend/push_notifications/push_notifications_util.dart';
import 'backend/firebase/firebase_config.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await initFirebase();

  await FlutterFlowTheme.initialize();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late Stream<BaseAuthUser> userStream;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  final authUserSub = authenticatedUserStream.listen((_) {});
  final fcmTokenSub = fcmTokenUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = mortgageChatAppFirebaseUserStream()
      ..listen((user) => _appStateNotifier.update(user));
    jwtTokenStream.listen((_) {});
    Future.delayed(
      const Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();
    fcmTokenSub.cancel();
    super.dispose();
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MortgageChatApp',
      localizationsDelegates: const [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: const ScrollbarThemeData(),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scrollbarTheme: const ScrollbarThemeData(),
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NavBarPage extends StatefulWidget {
  const NavBarPage({super.key, this.initialPage, this.page});

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'AllChats';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'HomePage': const HomePageWidget(),
      'AllChats': const AllChatsWidget(),
      'AllServices': const AllServicesWidget(),
      'refer': const ReferWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);

    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      // CUSTOM_CODE_STARTED
      bottomNavigationBar: Container(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        padding: const EdgeInsets.only(bottom: 20),
        height: 90,
        child: Column(
          children: [
            Divider(
              height: 1.0,
              thickness: 1.0,
              color: FlutterFlowTheme.of(context).darkGrey3,
            ),
            Expanded(
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                    backgroundColor:
                        FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                ),
                child: BottomNavigationBar(
                  elevation: 0,
                  currentIndex: currentIndex,
                  onTap: (i) => setState(() {
                    _currentPage = null;
                    _currentPageName = tabs.keys.toList()[i];
                  }),
                  backgroundColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                  selectedItemColor: FlutterFlowTheme.of(context).primary,
                  unselectedItemColor: const Color(0xFFAAAAAA),
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  unselectedFontSize: 10,
                  selectedFontSize: 10,
                  unselectedLabelStyle: GoogleFonts.inter(
                      height: 1.5, fontWeight: FontWeight.w400),
                  selectedLabelStyle: GoogleFonts.inter(
                      height: 1.5, fontWeight: FontWeight.w400),
                  type: BottomNavigationBarType.fixed,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(
                        FFIcons.kicon,
                        size: 18.0,
                      ),
                      activeIcon: Icon(
                        FFIcons.khomeActive,
                        size: 18.0,
                      ),
                      label: 'Home',
                      tooltip: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        FFIcons.kchat,
                        size: 18.0,
                      ),
                      activeIcon: Icon(
                        FFIcons.kchatActive,
                        size: 18.0,
                      ),
                      label: 'Chats',
                      tooltip: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        FFIcons.kservices,
                        size: 18.0,
                      ),
                      activeIcon: Icon(
                        FFIcons.kservicesActive,
                        size: 18.0,
                      ),
                      label: 'Services',
                      tooltip: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        FFIcons.krefer,
                        size: 18.0,
                      ),
                      activeIcon: Icon(
                        FFIcons.krefer,
                        size: 18.0,
                      ),
                      label: 'Refer',
                      tooltip: '',
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // CUSTOM_CODE_ENDED
    );
  }
}
