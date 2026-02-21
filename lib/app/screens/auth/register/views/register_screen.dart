// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovopay/app/components/card/my_custom_scaffold.dart';
import 'package:ovopay/app/screens/auth/register/controller/registration_controller.dart';
import 'package:ovopay/app/screens/auth/register/views/widgets/profile_complete_screen.dart';
import 'package:ovopay/core/data/models/user/user_model.dart';
import 'package:ovopay/core/data/repositories/auth/signup_repo.dart';

import '../../../../../core/route/route.dart';
import '../../../../../core/utils/util_exporter.dart';

class RegisterScreen extends StatefulWidget {
  final UserModel? userModel;
  const RegisterScreen({super.key, this.userModel});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final PageController _pageController2 = PageController(initialPage: 0);
  int _currentPage2 = 0;

  void _nextPage({int? goToPage}) {
    if (_pageController2.hasClients) {
      _pageController2.animateToPage(
        goToPage ?? ++_currentPage2,
        duration: const Duration(milliseconds: 600),
        curve: Curves.linear,
      );
    }
  }

  void _previousPage({int? goToPage}) {
    if (_pageController2.hasClients && _currentPage2 > 0) {
      _pageController2.animateToPage(
        goToPage ?? --_currentPage2,
        duration: const Duration(milliseconds: 600),
        curve: Curves.linear,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Get.put(RegistrationRepo());
    Get.put(RegistrationController(registrationRepo: Get.find()));
  }

  @override
  void dispose() {
    _pageController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomScaffold(
      pageTitle: MyStrings.register,
      body: PageView(
        controller: _pageController2,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Directly show Profile Complete Screen
          ProfileCompleteScreen(
            // pageController: _pageController2,
            currentPage: _currentPage2,
            nextPage: _nextPage,
            previousPage: _previousPage,
          ),
        ],
      ),
    );
  }
}
