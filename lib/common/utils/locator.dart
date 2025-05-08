import 'package:talent_mesh/common/models/user_model.dart';
import 'package:talent_mesh/pages/dashboard/models/application_model.dart';
import 'package:talent_mesh/pages/job_listing/model/job_filter_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final dependencyLocator = GetIt.instance;

Future<void> setupGetIt() async {
  dependencyLocator.registerSingletonAsync<SharedPreferences>(
    () async => SharedPreferences.getInstance(),
  );

  dependencyLocator.registerSingleton<UserModel>(
    UserModel.fromJson({
      'role': 'none',
    }),
  );

  ///Firebase
  dependencyLocator
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance);
}

DocumentReference userDetailDocumentRef(String uid) =>
    dependencyLocator<FirebaseFirestore>().collection('users').doc(uid);

UserModel getUser() => dependencyLocator<UserModel>();

JobFilterModel getFilters() => dependencyLocator<JobFilterModel>();

List<ApplicationModel> getAppliedJobs() =>
    dependencyLocator<List<ApplicationModel>>();
