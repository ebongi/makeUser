// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovopay/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:ovopay/core/data/models/auth/sign_up_model/registration_response_model.dart';
import 'package:ovopay/core/data/models/global/response_model/response_model.dart';
import 'package:ovopay/core/data/models/profile_complete/profile_complete_post_model.dart';
import 'package:ovopay/core/data/models/user/user_model.dart';

import 'package:ovopay/core/data/repositories/auth/signup_repo.dart';
import 'package:ovopay/environment.dart';

import '../../../../../core/data/services/service_exporter.dart';
import '../../../../../core/route/route.dart';
import '../../../../../core/utils/util_exporter.dart';

class RegistrationController extends GetxController {
  final RegistrationRepo registrationRepo;

  RegistrationController({required this.registrationRepo});

  bool isLoading = true;

  // Controllers
  final TextEditingController pinController = TextEditingController();
  final TextEditingController cPinController = TextEditingController();

  final TextEditingController uNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  bool submitLoading = false;

  @override
  void onInit() {
    super.onInit();
    isLoading = false;
  }

  // 🚀 SKIPPED OTP: this replaces verifyYourSms
  Future<void> completeRegistrationAndContinue({
    required void Function() onSuccess,
  }) async {
    submitLoading = true;
    update();

    try {
      // Fake a success response flow
      ResponseModel responseModel = await registrationRepo.sendAuthorizationRequest();

      if (responseModel.statusCode == 200) {
        // Navigate directly to profile or dashboard
        onSuccess();
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } catch (e) {
      CustomSnackBar.error(errorList: [e.toString()]);
    }

    submitLoading = false;
    update();
  }

  // ✅ PROFILE COMPLETE LOGIC (unchanged)
  bool submitProfileCompleteLoading = false;

  Future<void> profileCompleteSubmit() async {
    submitProfileCompleteLoading = true;
    update();

    try {
      ProfileCompletePostModel model = ProfileCompletePostModel(
        email: emailController.text,
        username: uNameController.text,
        firstName: fNameController.text,
        lastName: lNameController.text,
        address: addressController.text,
        state: stateController.text,
        zip: zipCodeController.text,
        city: cityController.text,
        image: null,
        pin: pinController.text,
        cPin: pinController.text,
      );

      ResponseModel responseModel = await registrationRepo.completeProfile(model);

      if (responseModel.statusCode == 200) {
        RegistrationResponseModel model = RegistrationResponseModel.fromJson(
          responseModel.responseJson,
        );

        if (model.status?.toLowerCase() == AppStatus.SUCCESS.toLowerCase()) {
          RouteHelper.checkUserStatusAndGoToNextStep(
            model.data?.user,
            accessToken: model.data?.accessToken ?? "",
            isRemember: true,
          );
        } else {
          CustomSnackBar.error(
            errorList: model.message ?? ['Request failed'],
          );
        }
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } catch (e) {
      printE(e.toString());
    } finally {
      submitProfileCompleteLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    pinController.dispose();
    cPinController.dispose();
    uNameController.dispose();
    emailController.dispose();
    fNameController.dispose();
    lNameController.dispose();
    addressController.dispose();
    stateController.dispose();
    zipCodeController.dispose();
    cityController.dispose();
    super.onClose();
  }
}
