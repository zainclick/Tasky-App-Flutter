import 'package:flutter/material.dart';


class Portofolio extends StatelessWidget {
  const Portofolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/images/person.png"),
              width: 170,
              height: 170,
            ),
            SizedBox(height: 30,),
            Text("Hi, I am John,\nCreative \nTechnologist",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0XFF21243D)
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                "Amet minim mollit non deserunt ullamco est \n"
                    "sit aliqua dolor do amet sint. Velit officia \n"
                    "consequat duis enim velit mollit. Exercitation \n"
                    "veniam consequat sunt nostrud amet.",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0XFF21243D)

                ),
              ),

            ),
            ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0XFFFF6464),
                  foregroundColor: Color(0xFFFFFFFF),
                  fixedSize: Size(208, 48),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2)
                  ),
                  padding: EdgeInsets.zero
              ),
              child: Text("Download Resume",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
