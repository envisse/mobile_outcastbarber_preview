part of 'barrel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  //list of pages
  final List<Widget?> _pages = [
    HomePage(),
    ServicePage(),
    null,
    WithdrawPage(),
    StockPage()
  ];

  //Bottomtab navigation
  void onTapTabbed(int index) {
    setState(() {
      //if index == 2 -> navigate push tp screen "addrecord"
      if (index == 2) {
        Navigator.pushNamed(context, '/add_record');
        index = _currentIndex = 0;
        return null;
      }

      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //list Appbar
    final List<PreferredSizeWidget?> appBar = [
      AppBar(
        elevation: 0,
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.only(right: Dimens.horizontalMargin),
            child: Text(
              DateFormat('d MMM').format(DateTime.now()),
            ),
          ))
        ],
      ),
      AppBar(title: Text(AppLocalizations.of(context)!.global_service)),
      null,
      AppBar(title: Text(AppLocalizations.of(context)!.global_withdraw)),
      AppBar(title: Text('Stock'))
    ];
    final firebaseUser = context.watch<User?>();
    //if data is empty, then get userid are downloaded
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit()..getdatauser(),
        ),
        BlocProvider(
          create: (context) => Recordv2Cubit(),
        ),
        BlocProvider(
          create: (context) => RecaprecordCubit()..recaprecordload(),
        ),
        BlocProvider(
          create: (context) => PdfexportCubit(),
        )
      ],
      child: BlocListener<UserCubit, UserState>(
        listener: (context, state) async {
          if (state is UserCubitEmpty) {
            await UserProfile().getUser(firebaseUser!.uid);
          }
        },
        child: Scaffold(
          appBar: appBar[_currentIndex],
          body: _pages[_currentIndex],
          bottomNavigationBar: BottomNavigationBarComponent(
              onTap: onTapTabbed, activeIndex: _currentIndex),
          drawer: SideNavigationBar(),
        ),
      ),
    );
  }
}
