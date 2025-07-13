import 'package:absolutecinema/pages/widgets/mywidgets/mytext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuccesPage extends StatefulWidget {
  const SuccesPage({super.key});

  @override
  State<SuccesPage> createState() => _SuccesPageState();
}



class _SuccesPageState extends State<SuccesPage> {
SharedPreferences? pref;
@override
  void initState() async{
    super.initState();
  SharedPreferences initialpref = await SharedPreferences.getInstance(); 
  pref = initialpref;
  }

  @override
  Widget build(BuildContext context) {
      var sesionId  = pref?.getString('sessionId');
    return Scaffold(
      body: Center(
      child: MyText(text: 
      sesionId!

      ),
      ),
    );
  }
}