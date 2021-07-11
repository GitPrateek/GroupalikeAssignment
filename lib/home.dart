import 'package:flutter/material.dart';
// import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:groupalike/common_components.dart';
import 'package:slide_to_act/slide_to_act.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

enum LocalOrGlobal { local, global }

class _MainScreenState extends State<MainScreen> {
  static const _kIconSize = 56.0;
  static const _kFontFam =
      'icon_set_1'; //TODO Define different sets of icons in separate TTF file so it's easy to update in future
  static const IconData drawer_icon = IconData(0xe800,
      fontFamily:
          _kFontFam); //defining the custom fonts TODO move this and the ones following this to a separate file
  static const IconData logo = IconData(0xe801, fontFamily: _kFontFam);

  @override
  Widget build(BuildContext context) {
    var sliderText = 'Slide to match';

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: MyAppBar(drawer_icon: drawer_icon),
      drawer: Drawer(),
      body: SafeArea(
        child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  child: SlideToMatchWidget(
                    kIconSize: _kIconSize,
                    logo: logo,
                    sliderText: sliderText,
                  ),
                ),
                SizedBox.expand(
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.67,
                    expand: true,
                    maxChildSize: 1.0,
                    minChildSize: 0.5,
                    builder: (context, scrollController) {
                      return Container(
                        color: Theme.of(context).backgroundColor,
                        child: Column(
                          children: [
                            LocalOrGlobalRadioList(),
                            Expanded(
                              child: ListView.builder(
                                controller: scrollController,
                                itemBuilder: (context, index) {
                                  return PostCard(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            )),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
    );
  }

  Container PostCard(BuildContext context) {
    var isLiked = false;
    return Container(
      height: 320.0,
      color: Theme.of(context).backgroundColor,
      margin: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1050&q=80',
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '10 Benefits Of Meeting People While Trave...',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      '10 Benefits Of Meeting People While Trave...',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ),
                IconButton(onPressed: null, icon: Icon(Icons.more_vert))
              ],
            ),
          ), //Header of a post
          // FullScreenWidget(
          //   backgroundColor: Colors.transparent,
          //   backgroundIsTransparent: true,
          //   child: Center(
          //     child: Hero(
          //       transitionOnUserGestures: true,
          //       tag:
          //           'https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=687&q=80',
          //       child: Image.network(
          //         'https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=687&q=80',
          //         fit: BoxFit.cover,
          //         width: MediaQuery.of(context)
          //             .size
          //             .width,
          //         height: 200,
          //       ),
          //     ),
          //   ),
          // ),
          GestureDetector(
            //Implements the expandable image
            onTap: () => {
              context.pushTransparentRoute(
                DismissiblePage(
                  startingOpacity: 0.25,
                  backgroundColor: Colors.black,
                  onDismiss: () => Navigator.of(context).pop(),
                  child: Center(
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: 'fullscreen_image',
                      child: Image.network(
                        'https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=687&q=80',
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                ),
              ),
            },
            child: Hero(
              transitionOnUserGestures: true,
              tag: 'small_image',
              child: Image.network(
                'https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=687&q=80',
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                height: 200,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => {
                    setState(() => {
                          isLiked = !isLiked
                        }) //Will not work until the state is lifted
                  },
                  icon: isLiked
                      ? Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                        )
                      : Icon(
                          Icons.favorite_border,
                          color: Theme.of(context).accentColor,
                        ),
                ),
                Text('156'),
                IconButton(
                  onPressed: () => {print('Opens comment section')},
                  icon: Icon(
                    Icons.mode_comment_outlined,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                Text(
                  '27',
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            width: MediaQuery.of(context).size.width,
            child: Text(
              'The quick brown fox jumped over the lazy dog...',
              textAlign: TextAlign.left,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class LocalOrGlobalRadioList extends StatefulWidget {
  const LocalOrGlobalRadioList({
    Key? key,
  }) : super(key: key);

  @override
  _LocalOrGlobalRadioListState createState() => _LocalOrGlobalRadioListState();
}

class _LocalOrGlobalRadioListState extends State<LocalOrGlobalRadioList> {
  LocalOrGlobal _selected = LocalOrGlobal.local;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints.tight(Size(MediaQuery.of(context).size.width, 40.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 24.0),
          MaterialButton(
            onPressed: () => {
              setState(() {
                _selected = LocalOrGlobal.local;
              })
            },
            child: Row(children: [
              Icon(
                Icons.circle,
                color: _selected == LocalOrGlobal.local
                    ? Theme.of(context).accentColor
                    : Colors.transparent,
                size: 8.0,
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                'Local feed',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: _selected == LocalOrGlobal.local
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary),
              ),
            ]),
          ),
          MaterialButton(
            onPressed: () => {
              setState(() {
                _selected = LocalOrGlobal.global;
              })
            },
            child: Row(children: [
              Icon(
                Icons.circle,
                color: _selected == LocalOrGlobal.global
                    ? Theme.of(context).accentColor
                    : Colors.transparent,
                size: 8.0,
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                'Global feed',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: _selected == LocalOrGlobal.global
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              Icons.search,
              size: 32.0,
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}

class SlideToMatchWidget extends StatefulWidget {
  const SlideToMatchWidget({
    Key? key,
    required double kIconSize,
    required this.logo,
    required this.sliderText,
  })  : _kIconSize = kIconSize,
        super(key: key);

  final double _kIconSize;
  final IconData logo;
  final String sliderText;

  @override
  _SlideToMatchWidgetState createState() => _SlideToMatchWidgetState();
}

class _SlideToMatchWidgetState extends State<SlideToMatchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tight(
        Size.fromHeight(widget._kIconSize),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(100.0)),
          border: Border.all(
              width: 2.4, color: Theme.of(context).colorScheme.primary)),
      child: SlideAction(
        onSubmit: () {
          print('Slider submitted.');
        },
        //TODO can be used to manage state and Navigate pages
        borderRadius: 100.0,
        sliderRotate: false,
        outerColor: Colors.transparent,
        elevation: 0.0,
        sliderButtonIcon: Icon(
          widget.logo,
          size: widget._kIconSize,
          color: Theme.of(context).colorScheme.primary,
        ),
        innerColor: Colors.transparent,
        sliderButtonIconPadding: 0.0,
        sliderButtonIconSize: widget._kIconSize,
        sliderButtonYOffset: -10.0,
        alignment: Alignment.topCenter,
        child: Text(
          widget.sliderText,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      // ),
      // child: Row(
      //   mainAxisSize: MainAxisSize.max,
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     Icon(
      //       logo,
      //       size: 48.0,
      //       color: Theme.of(context).iconTheme.color,
      //     ),
      //     Expanded(
      //       child: Text(
      //         'Slide to match',
      //         style: Theme.of(context)
      //             .textTheme
      //             .headline5!
      //             .copyWith(fontWeight: FontWeight.bold),
      //         textAlign: TextAlign.center,
      //       ),
      //     ),
      //     SizedBox(
      //       width: 48.0,
      //     ),
      //   ],
      // ),
    );
  }
}
