import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamsync_lite/features/authentication/view/signupScreen.dart';
import 'package:streamsync_lite/features/home/view/homescreen.dart';
import 'package:streamsync_lite/features/splash/viewModels/splash_cubit.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is UserAlreadyLogined) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else if (state is NavigateToNextScreen) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => SignUpScreen()),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFE7EFFD),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        size: 56,
                        color: Color(0xFF256DF4),
                      ),
                    ),

                    SizedBox(height: 32),
                    Text(
                      'StreamSync Lite',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF252733),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Learning in Motion',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF868991),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: LinearProgressIndicator(
              value: state is SplashLoading ? state.progress : 0.0,
              minHeight: 5,
              backgroundColor: Color(0xFFE8ECF1),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF256DF4)),
            ),
          ),
        );
      },
    );
  }
}
