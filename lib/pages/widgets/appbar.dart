
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white60),
                      color: Colors.grey.shade600.withOpacity(0.6),
                      ),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:  11.0, top: 55),
                  child:
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Good Morning', style: TextStyle(color: Colors.white,fontSize: 10, fontWeight: FontWeight.normal),),
                      Text('Good Morning', style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white60),
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.grey.shade600.withOpacity(0.6)
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(Icons.notifications)))
                  ],
                ),
            )
          ],
        ),
      ),
    );
  }
}
