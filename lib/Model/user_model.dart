class UserModel {
  late String? currentUserUID;
  late String? currentUserName;
  late String? currentUserImageURL;
  late String? currentUserEmail;
  late int? currentUserPoints;
  get getCurrentUserUID => currentUserUID;

  set setCurrentUserUID(currentUserUID) => this.currentUserUID = currentUserUID;

  get getCurrentUserName => currentUserName;

  set setCurrentUserName(currentUserName) =>
      this.currentUserName = currentUserName;

  get getCurrentUserImageURL => currentUserImageURL;

  set setCurrentUserImageURL(currentUserImageURL) =>
      this.currentUserImageURL = currentUserImageURL;

  get getCurrentUserEmail => currentUserEmail;

  set setCurrentUserEmail(currentUserEmail) =>
      this.currentUserEmail = currentUserEmail;
  UserModel({
    required this.currentUserUID,
    required this.currentUserEmail,
    required this.currentUserName,
    required this.currentUserImageURL,
    required this.currentUserPoints,
  });
}
