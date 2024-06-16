class Constants {
  static const String adminUsername = "9659446629";
  static const String adminPassword = "Arin@2024";
  static const String delete = "Delete";
  static const String donor = "Donor";
  static const String state = "State";
  static const String trustee = "Trustee";
  static const String admin = "Admin";
  static const String trusts = "Trusts";
  static const String userName = "User name";
  static const String userNameValidationText = "$userName is required";
  static const String trustName = "Trust name";
  static const String trustNameValidationText = "$trustName is required";
  static const String password = "Password";
  static const String passwordValidationText = "$password is required";
  static const String login = "LOG-IN";
  static const String donHaveAnAccount = "Don’t have an account?";
  static const String alreadyHaveAnAccount = "Already have an account?";
  static const String signIn = "SIGN-IN";
  static const String signUp = "SIGN-UP";
  static const String email = "Email";
  static const String age = "Age";
  static const String status = "Status";
  static const String ageValidationText = "$age is required";
  static const String emailValidationText = "$email is not valid";
  static const String password1ValidationText =
      "Password must contain upper,lower,digit and Special character";
  static const String password2ValidationText =
      "Please enter same password as above";
  static const String emailEmptyValidationText = "$email is required";
  static const String mobNumber = "Mobile Num";
  static const String mobileNumber = "Mobile Number";
  static const String review = "Review";
  static const String phNumberValidationText = "$mobNumber is not valid";
  static const String phNumberEmptyValidationText = "$mobNumber is required";
  static const String confirmPassword = "Confirm Password";
  static const String confirmPasswordValidationText =
      "$confirmPassword is required";
  static const String back = "Back";
  static const String alert = "Alert";
  static const String logoutAlertText = "Do you want to logout?";
  static const String trustDeleteAlertText =
      "Are you sure you want to delete this trust?";
  static const String yes = "Yes";
  static const String no = "No";
  static const String showOtherTrust = "Show Other Trusts";
  static const String accountNumber = "Account Num";
  static const String uPIId = "UPI ID";
  static const String uPIIdEmptyValidationText = "$uPIId is required";
  static const String accountNumberEmptyValidationText =
      "$accountNumber is required";
  static const String pinCode = "Pincode";
  static const String pinCodeEmptyValidationText = "$pinCode is required";

  static const String livesIn = "Lives In";
  static const String livesInEmptyValidationText = "$livesIn is required";

  static const String address = "Address";
  static const String address1EmptyValidationText = "$address is required";

  static const String vehicleCount = "Vehicle count";
  static const String vehicleCountEmptyValidationText =
      "$vehicleCount is required";

  static const dob = "DOB";
  static const String dobEmptyValidationText = "$dob is required";

  static const String members = "Members";
  static const String memberCountEmptyValidationText = "$members is required";

  static const String careTaker = "Care Taker";
  static const String careTakerEmptyValidationText = "$careTaker is required";
  static const occupation = "Occupation";
  static const String occupationEmptyValidationText = "$occupation is required";
  static const String category = "Category";
  static const String edit = "Edit";

  static const String save = "Save";
  static const String photoLibrary = "Photo Library";
  static const String camera = "Camera";
  static const String onlyFor = "Only For";
  static const String needs = "Needs";
  static const String date = "Date";
  static const String amount = "Amount";
  static const String donationHistory = "Donation History";
  static const String contactNumber = "Contact Number";
  static const String editProfile = "Edit Profile";
  static const String adoptRequests = "Adopt Requests";
  static const String adoptForm = "Adopt form";
  static const String adoptionApplicationForm = "Adoption Application Form";
  static const String emergencyNeeds = "Emergency Needs";
  static const String addMore = "Add More";
  static const String submit = "Submit";
  static const String adopt = "Adopt";
  static const String donate = "Donate";

  static const netBanking = "Net Banking";
  static const uPIPayment = "UPI Payment";
  static const googlePay = "Google Pay ";
  static const amazonPay = " Amazon Pay ";
  static const phonePe = "Phone Pe";
  static const paytm = "Paytm";

  static const name = "Name";
  static const String nameValidationText = "$name is required";
  static const lastName = "Last name";

  static const gender = "Gender";

  static const place = "Place";
  static const annualIncome = "Annual Income";

  static const drivingLicenceNumber = "Driving Lic Number";
  static const maritalStatus = "Marital status";
  static const decline = "Decline";
  static const accept = "Accept";

  // dropDownList

  static const List<String> categoryDropDownList = [
    "Women’s Home",
    "Child Care Home",
    "Old Age Home",
    "Handicap Home",
    "Mentally disabled Home",
    "Private Trust"
  ];

  static const List<String> forDropDownList = [
    "Women care",
    "Child care",
    "Old People",
    "Handicap",
    "All children",
    "Orphan(<18)",
  ];

  static const List<String> profileStatusList = [
    "Emergency",
    "Nil",
  ];

  static const List<String> maritalStatusList = [
    "Single",
    "Married",
    "divorced",
    "Domestic Partnership"
  ];

  static const List<String> stateList = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
  ];

  // drawer list names

  static const profile = "Profile";

  static const requestDetails = "Request Details";
  static const feedback = "Feedback";
  static const logout = "Log out";
  static const notification = "Notification";
  static const donationDetails = "Donation Details";

  // toast messages
  static const userNameIncorrectMessage = "Incorrect user name or password";
  static const signUpSuccessMessage = "Added SuccessFully";
  static const errorMessage = "Something went wrong, Please try again later";
  static const numberExistErrorMsg =
      "This number already exist, please try another number";
  static const signUpHere = "Sign up here first";
  static const profileUpdateSuccessMessage = "Profile Updated Successfully";
  static const savedSuccessfully = "Saved SuccessFully";

  static const orphanDataBase = "OrphanCare";

  // TRUST DATA BASE KEYS

  static const trustProfileDataKey = "trustProfileKey";
  static const trustEmergencyNeedDataKey = "trustEmergencyNeedKey";
  static const trustDonationHistoryKey = "trustDonationHistoryKey";
  static const trustFeedBackKey = "trustFeedBackKey";
  static const appFeedBackKey = "appFeedBackKey";

// DONOR DATA BASE KEYS

  static const donorProfileDataKey = "donorProfileKey";
  static const donorAdoptionRequestDataKey = "donorAdoptionRequestDataKey";
  static const donorNotificationDataKey = "donorNotificationDataKey";
  static const donorDonationHistoryKey = "donorDonationHistoryKey";
}
