abstract class AppStates {}

class AppInitialState extends AppStates {}
class AppChangeBottomNavBarState extends AppStates {}
class AppCreateDatabaseState extends AppStates{}
class AppGetDatabaseState extends AppStates{}

class AppInsertDatabaseState extends AppStates{}
class AppUpdateDatabaseState extends AppStates{}
class AppDeleteDatabaseState extends AppStates{}

class AppChangeBottomSheetState extends AppStates{}
class AppChangeModeStates extends AppStates{}


class UserUpdateLoadingState extends AppStates {}
class UserUpdateErrorState extends AppStates {}


class GetUserLoadingState extends AppStates {}

class GetUserSuccessState extends AppStates {}

class GetUserErrorState extends AppStates
{
  final String error;

  GetUserErrorState(this.error);
}