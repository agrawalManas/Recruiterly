import 'package:cades_flutter_template/common/app_enums.dart';
import 'package:cades_flutter_template/common/utils/extensions/string_extensions.dart';
import 'package:cades_flutter_template/common/utils/locator.dart';
import 'package:cades_flutter_template/common/utils/utils.dart';
import 'package:cades_flutter_template/pages/onboarding/domain/recruiter/recruiter_onboarding_state.dart';
import 'package:cades_flutter_template/pages/onboarding/models/recruiter_profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecruiterOnboardingCubit extends Cubit<RecruiterOnboardingState> {
  RecruiterOnboardingCubit() : super(const RecruiterOnboardingState.init());

  final _firestore = dependencyLocator<FirebaseFirestore>();

  //-------step-1-controllers
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyDescriptionController =
      TextEditingController();
  final TextEditingController _companyFoundedYearController =
      TextEditingController();

  //--------step-2-controllers
  final TextEditingController _companyWebsiteController =
      TextEditingController();
  final TextEditingController _registeredPhoneNumberController =
      TextEditingController();

  //---------step-3-controllers
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _countryController =
      TextEditingController(text: 'India');

  //-------getters
  TextEditingController get companyNameController => _companyNameController;
  TextEditingController get companyDescriptionController =>
      _companyDescriptionController;
  TextEditingController get companyFoundedYearController =>
      _companyFoundedYearController;
  TextEditingController get companyWebsiteController =>
      _companyWebsiteController;
  TextEditingController get registeredPhoneNumberController =>
      _registeredPhoneNumberController;
  TextEditingController get addressLine1Controller => _addressLine1Controller;
  TextEditingController get addressLine2Controller => _addressLine2Controller;
  TextEditingController get cityController => _cityController;
  TextEditingController get stateController => _stateController;
  TextEditingController get pinCodeController => _pinCodeController;
  TextEditingController get countryController => _countryController;

  void onSelectCompanySize(String value) {
    emit(state.copyWith(companySize: value));
  }

  void onSelectIndustries(List<String> selectedIndustries) {
    emit(state.copyWith(industries: selectedIndustries));
  }

  Future<bool> continueOnboardingStep1() async {
    if (_companyNameController.text.isNotEmpty &&
        _companyDescriptionController.text.isNotEmpty &&
        (_companyFoundedYearController.text.isNotEmpty &&
            DateTime.now().year >=
                int.parse(_companyFoundedYearController.text.trim()))) {
      await _updateOnboardingDetails(
        data: {
          'companyName': _companyNameController.text.trim(),
          'yearFounded': int.parse(_companyFoundedYearController.text.trim()),
          'companyDescription': _companyDescriptionController.text.trim(),
          'updatedAt': DateTime.now(),
          'createdAt': DateTime.now(),
        },
        step: 1,
      );
      return true;
    }
    Utils.showToast(message: 'Please enter valid details!');
    return false;
  }

  Future<bool> continueOnboardingStep2() async {
    if ((state.companySize ?? '').isNotEmpty &&
        (state.industries ?? []).isNotEmpty) {
      await _updateOnboardingDetails(
        data: {
          'website': _companyWebsiteController.text.trim(),
          'industries': state.industries,
          'companySize': state.companySize,
          'updatedAt': DateTime.now(),
        },
        step: 2,
      );
      return true;
    }
    Utils.showToast(message: 'Please enter/select valid details!');
    return false;
  }

  Future<bool> continueOnboardingStep3() async {
    if (_registeredPhoneNumberController.text.trim().isNotEmpty &&
        _addressLine1Controller.text.trim().isNotEmpty &&
        _cityController.text.trim().isNotEmpty &&
        _stateController.text.trim().isNotEmpty &&
        _pinCodeController.text.trim().isNotEmpty) {
      await _updateOnboardingDetails(
        data: {
          'contactNumber': _registeredPhoneNumberController.text.trim(),
          'address': Address(
            city: _cityController.text.trim(),
            state: _stateController.text.trim(),
            country: _countryController.text.trim(),
            postalCode: _pinCodeController.text.trim(),
            addressLine1: _addressLine1Controller.text.trim(),
            addressLine2: _addressLine2Controller.text.trim(),
          ).toJson(),
          'updatedAt': DateTime.now(),
        },
        step: 3,
      );
      return true;
    }
    Utils.showToast(message: 'Please enter/select valid details!');
    return false;
  }

  /// update the candidates/recruitersHea collection
  /// corresponds to his profile
  Future<void> _updateOnboardingDetails({
    required Map<String, dynamic> data,
    required int step,
  }) async {
    final user = getUser();
    final userRef = userDetailDocumentRef(user.uid ?? '');
    if (user.role?.userRole == Role.candidate) {
      await _firestore.collection('candidates').doc(user.uid).update(data);
    } else if (user.role?.userRole == Role.recruiter) {
      await _firestore.collection('recruiters').doc(user.uid).update(data);
    }
    await userRef.update({
      'onboardingStep': step,
    });
  }
}
