
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reclutamiento/modelos/drawer_list.dart';


enum DrawerIndex {
  HOME, // Home screen is the location map
  FAV,
}

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key, required this.screenIndex, required this.iconAnimationController, required this.callBackIndex}) : super(key: key);

  final AnimationController iconAnimationController;
  final DrawerIndex screenIndex;
  final Function(DrawerIndex) callBackIndex;

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  late List<DrawerList> drawerList;
  final String pokMap = 'assets/images/pokedex.svg';//imagen del menu
  late Widget pokSvg;

  @override
  void initState() {
    setdDrawerListArray();

    setState(() {

      pokSvg = SvgPicture.asset(
        pokMap,
        semanticsLabel: 'Pokedex',

      );

    });
    super.initState();
  }

  void setdDrawerListArray() {
    drawerList = <DrawerList>[

      DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'Pokemons',
        icon: const Icon(Icons.home_outlined, color: Colors.red,),
      ),

      DrawerList(
        index: DrawerIndex.FAV,
        labelName: 'Pokemons Favoritos',
        icon: const Icon(Icons.favorite, color:  Colors.redAccent,),
      ),

    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF0F2).withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children:  <Widget>[

                  AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget? child) {
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(1.0 - (widget.iconAnimationController.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(begin: 0.0, end: 24.0)
                                  .animate(CurvedAnimation(parent: widget.iconAnimationController, curve: Curves.fastOutSlowIn))
                                  .value /
                              360),
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(color: const Color(0xFFEDF0F2).withOpacity(0.6), offset: const Offset(2.0, 4.0), blurRadius: 8),
                              ],
                            ),
                            child: pokSvg,
                          ),
                        ),
                      );
                    },
                  ),

                  const Padding(
                    padding: EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                        'Pokedex',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Divider(
            height: 1,
            color: const Color(0xFF3A5160).withOpacity(0.6),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: drawerList.length,
              itemBuilder: (BuildContext context, int index) {
                return inkwell(drawerList[index]);
              },
            ),
          ),
          Divider(
            height: 1,
            color: const Color(0xFF3A5160).withOpacity(0.6),
          ),
        ],
      ),
    );
  }

  Widget inkwell(DrawerList listData) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigationtoScreen(listData.index);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                      color: widget.screenIndex == listData.index
                          ? Colors.red
                          : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  listData.isAssetsImage
                      ? SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset(listData.imageName, color: widget.screenIndex == listData.index ? Colors.red : const Color(0xFF213333)),
                  )
                      : Icon(listData.icon.icon, color: widget.screenIndex == listData.index ? Colors.red : const Color(0xFF213333)),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Text(
                    listData.labelName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: widget.screenIndex == listData.index ? Colors.red : const Color(0xFF213333),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            widget.screenIndex == listData.index
                ? AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            (MediaQuery.of(context).size.width * 0.75 - 64) * (1.0 - widget.iconAnimationController.value - 1.0), 0.0, 0.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.75 - 64,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(28),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(28),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const SizedBox()

          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex(indexScreen);
  }
}