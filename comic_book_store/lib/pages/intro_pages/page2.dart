import 'package:flutter/material.dart';
import 'package:comic_book_store/constants/colors.dart';

class Intro_page2 extends StatelessWidget {
  const Intro_page2({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.1),
              Center(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24.0),
                      child: Image.asset(
                        'images/page_02.png',
                        width: screenWidth * 0.8,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    const Text(
                      "Your Personal Comic Library",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: AppColors.accent2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    const Text(
                      "Build your ultimate collection with our easy-to-use store. Buy, sell, and manage your comics all in one place. Whether you're a casual reader or a hardcore collector, our app has everything you need to fuel your passion.",
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 17,
                        color: AppColors.accent2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
