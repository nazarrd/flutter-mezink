import 'package:flutter/material.dart';

import '../data/random_engagement.dart';
import '../data/random_followers.dart';
import '../data/random_grade.dart';
import '../models/user_model.dart';
import '../repository/user_repository.dart';
import '../utils/print_log.dart';
import '../widgets/snackbar_default.dart';

class UserProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<UserData>? listUser = [];
  List<UserData>? allListUser = [];
  List<UserData> filteredUser = [];
  bool? isLoading;
  bool isLast = false;
  int currentPage = 1;
  int totalPages = 0;
  int perPage = 8;
  String? engagement;
  String? hashtags;
  String? followers;
  String? platform;
  String? gender;
  String? country;

  void initialized(State state) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (state.mounted) await getUserData();
    });
  }

  void setValue(String? key, String? value) {
    // convert the key to lowercase for case-insensitive matching
    final newKey = key?.toLowerCase();

    // update the corresponding property based on the key
    if (newKey == 'engagement') {
      engagement = value;
    } else if (newKey == 'hashtags') {
      hashtags = value;
    } else if (newKey == 'followers') {
      followers = value;
    } else if (newKey == 'platform') {
      platform = value;
    } else if (newKey == 'gender') {
      gender = value;
    } else {
      country = value;
    }

    notifyListeners();
  }

  void clearValue({bool clearAll = true}) {
    if (clearAll) {
      // reset variable values to null
      engagement = hashtags = followers = platform = gender = country = null;
    }

    // clear list and controller data
    filteredUser.clear();
    searchController.clear();

    notifyListeners();
  }

  void paginateData() {
    final startIndex = (currentPage - 1) * perPage;
    final endIndex = startIndex + perPage;

    // clear the current displayed data
    listUser?.clear();

    // paginate logic
    if (endIndex >= (allListUser?.length ?? 0)) {
      // if there are fewer than totalPages items remaining
      listUser = allListUser?.sublist(startIndex);
    } else {
      // return the next totalPages items
      listUser = allListUser?.sublist(startIndex, endIndex);
    }
    notifyListeners();
  }

  void handleUserDataError(Object error) {
    // trigger snackbar to send feedback to user
    snackBarDefault('error occurred during API call: $error');
  }

  Future getUserData({bool reset = false}) async {
    try {
      // check if data loading is already in progress, if so, return immediately
      if (isLoading == true) return;

      // if reset is true, clear the user lists, reset page data, and start fresh
      if (reset) {
        listUser?.clear();
        allListUser?.clear();
        filteredUser.clear();
        currentPage = 1;
        totalPages = 0;
      }

      // set isLoading flag to true and notify listeners
      isLoading = true;
      notifyListeners();

      // if there are existing total pages, delay for a second (simulating a delay)
      if (totalPages != 0) await Future.delayed(const Duration(seconds: 1));

      // fetch user data from the UserRepository
      final result = await UserRepository.getAllUser(
        page: currentPage,
        perPage: perPage,
      );

      // if valid data is returned
      if (result?.data != null) {
        // update current page and total pages, and clear the user list
        currentPage = result?.page ?? 1;
        totalPages = result?.totalPages ?? 1;
        listUser?.clear();

        // iterate through the result data and perform some transformations
        for (UserData e in result?.data ?? []) {
          e.grade = randomGrade();
          e.followers = randomFollower();
          e.engagement = randomEngagement();
          e.hashtags =
              '#${e.firstName} ${e.lastName}'.toLowerCase().replaceAll(' ', '');
          listUser?.add(e);
        }

        // check if the data is the last
        isLast = listUser?.length == perPage;

        // save all data to temp list user
        allListUser?.addAll(listUser ?? []);

        // remove duplicate
        final uniqueList = allListUser?.toSet().toList();
        allListUser = uniqueList;
      }
    } catch (e) {
      printLog('error occurred during get user: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future deleteUserData(int? id) async {
    try {
      isLoading = true;
      notifyListeners();

      // perform fake api call to simulate delete function from API
      final result = await UserRepository.deleteUser(id);
      if (result == 204) {
        // 204 mean delete success
        // use removeWhere to remove the user with the specified id
        listUser?.removeWhere((e) => e.id == id);
        allListUser?.removeWhere((e) => e.id == id);
        paginateData();
        notifyListeners();
      } else {
        // trigger snackbar to send feedback to user
        snackBarDefault('delete user failed');
      }
    } catch (e) {
      handleUserDataError(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void searchUserData(String keyword) {
    // clear existing search data
    filteredUser.clear();
    for (UserData e in listUser ?? []) {
      // find user by firstname, lastname or hastag
      if ('${e.firstName?.toLowerCase()}'.contains(keyword.toLowerCase()) ||
          '${e.lastName?.toLowerCase()}'.contains(keyword.toLowerCase()) ||
          (e.hashtags?.contains(keyword.toLowerCase()) ?? false)) {
        // add match value to filteredUser
        filteredUser.add(e);
      }
    }
    notifyListeners();
  }

  void addUser(UserData? user) {
    // add the new item at the beginning
    user?.id = DateTime.now().millisecondsSinceEpoch;
    allListUser?.insert(0, user!);
    paginateData();
    notifyListeners();
  }

  void editUser(UserData? user) {
    final index = allListUser?.indexWhere((e) => e.id == user?.id);
    if (index != null && index != -1) {
      // Update the user information
      allListUser?[index] = user!;
      paginateData();
      notifyListeners();
    }
  }
}