
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  MyText({
    super.key,
     required this.text,
      this.clors,
      this.fnSize,
      this.fnweight,
      this.maxlines,
      this.ecips,
      });
  String text;
  Color? clors;
  double? fnSize;
  FontWeight? fnweight;
  int?  maxlines;
  TextOverflow? ecips;
  @override
  Widget build(BuildContext context) {
    return Text(text,
    textAlign: TextAlign.center ,
    overflow: ecips != null ? ecips : TextOverflow.ellipsis,
    maxLines: maxlines != null ? maxlines : 1 ,
     style: GoogleFonts.openSans(
      color: clors ==  null ? Colors.white : clors, 
      fontSize: fnSize != null ? fnSize : 14 ,
      fontWeight: fnweight !=null ? fnweight : FontWeight.normal 
    ),);
  }
}
