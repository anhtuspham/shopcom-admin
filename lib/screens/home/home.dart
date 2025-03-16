import 'package:flutter/cupertino.dart';

final homeKey = GlobalKey<FormState>();

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(key: homeKey, child: Text('Home screen'));
  }
}
