import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    required this.drawer_icon,
  }) : super(key: key);

  final IconData drawer_icon;

  @override
  Size get preferredSize => Size.fromHeight(80.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => {Scaffold.of(context).openDrawer()},
        icon: Icon(drawer_icon),
      ),
      title: Row(
        children: [
          Icon(Icons
              .notifications_outlined), //TODO Adding the count of notifications to this
          SizedBox(width: 8.0),
          Icon(Icons
              .search), //TODO Replace this with the search icon used in the design file
        ],
      ),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: Scaffold.of(context).appBarMaxHeight,
                width: 40.0,
                child: AnimatedWallet()),
            // Icon(Icons
            //     .account_balance_wallet), //TODO Add the wallet animation here. Might need to use IconButton instead
            SizedBox(width: 8.0),
            Text('1900'), //TODO Change color to the accent color
            SizedBox(width: 16.0)
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons
                .stars_outlined), //TODO update this with the icon used in design file
            SizedBox(width: 8.0),
            Text(
              '1900',
            ), //TODO Change color to the accent color
            SizedBox(width: 16.0)
          ],
        ),
      ],
      iconTheme: IconThemeData(color: Theme.of(context).accentColor),
    );
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  const MyBottomNavigationBar({
    this.currentIndex = 0,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 0.0,
      fixedColor: Theme.of(context).accentColor,
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      backgroundColor: Colors.transparent,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 40.0,
      onTap: (index) {
        print("User tapped the BottomNavigationBar at index: $index");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Page to be added later'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Back'),
              ),
            ],
          ),
        );
      }, //TODO depending on the structure of the app, this can be used to call Navigator functions, or used to call setState to update the screen in the 'body' attribute of the Scaffold in MainScreen, and 'currentIndex'
      currentIndex: 0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group_outlined),
          label: 'Classes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message_outlined),
          label: 'Sports',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined),
          label: 'Favourites',
        ),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}

class AnimatedWallet extends StatefulWidget {
  @override
  AnimatedWalletState createState() => AnimatedWalletState();
}

class AnimatedWalletState extends State<AnimatedWallet>
    with TickerProviderStateMixin {
  late AnimationController _lottieAnimationController;
  bool _hasBeenTapped = false;

  @override
  void initState() {
    super.initState();
    _lottieAnimationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _lottieAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _lottieAnimationController.duration = Duration(seconds: 1);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          setState(() {
            _hasBeenTapped = true;
          });
          _hasBeenTapped = true;
          if (_hasBeenTapped) _lottieAnimationController.forward(from: 0.0);
        },
        child: Container(
          color: Colors.white,
          child: _hasBeenTapped
              ? Lottie.network(
                  'https://assets8.lottiefiles.com/packages/lf20_ZeCXAz.json',
                  controller: _lottieAnimationController,
                  width: 100.0,
                  height: 100.0,
                  fit: BoxFit.cover,
                  onLoaded: (composition) {
                    _lottieAnimationController..duration = composition.duration;
                  },
                )
              : Center(child: Icon(Icons.account_balance_wallet)),
        ),
      ),
    );
  }
}
