import 'package:flutter/material.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Get_Started_Screen.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Overlay with Title, Subtitle and Button
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Main title
                const Text(
                  'PureDrops',
                  style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Baloo 2',
                      color: Color(0xFF294899)),
                ),

                const SizedBox(height: 2),

                //Subtitle
                const Padding(
                  padding: EdgeInsets.only(bottom: 50.0),
                  child: Text(
                    'Save Water Save World',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Outfit',
                        color: Color(0xFF3E91E5)),
                  ),
                ),

                const SizedBox(height: 180),

                // get Started Button
                SizedBox(
                  width: 178, // Button width
                  height: 63, // Button height
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 10, 57, 128), // Button background color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                          fontFamily: 'Outfit',
                        ),
                      )),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
