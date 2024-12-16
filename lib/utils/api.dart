class ApiConstant {
  static const BASE_URL = "";  // Enter your base URL like :: http://182.168.20.243:5000/
  static const SECRET_KEY = "";  // Enter your key like :: ssf45sd1fs5d1sdf1s56165s15sdf1s

  /// =================== Customer =================== ///
  static const loginOrSignUpCustomer = "api/customer/customer/loginOrSignUp";
  static const getCustomerProfile = "api/customer/customer/getProfile?";
  static const checkCustomer = "api/customer/customer/checkCustomer";
  static const editCustomerProfile = "api/customer/customer/update?";
  static const deleteCustomerProfile = "api/customer/customer/deleteCustomerAccount?";

  /// =================== OTP =================== ///
  static const generateOtpForLogin = "api/customer/otp/generateOtpForlogin";
  static const generateOtpForPassword = "api/customer/otp/generateOtpForPassword";
  static const verifyOtp = "api/customer/otp/verifyOtp";
  static const setPassword = "api/customer/customer/setPassword";

  /// =================== Service =================== ///
  static const getService = "api/customer/service/RetriveService";

  /// =================== Provider =================== ///
  static const getTopRatedProvider = "api/customer/provider/getTopRatedProvider?";
  static const saveProviderByCustomer = "api/customer/favoriteProvider/favoriteProByCust?";
  static const getServiceWiseProvider = "api/customer/provider/getServiceWiseProvider?";
  static const getAllSaveProvider = "api/customer/favoriteProvider/getFavoriteProviders?";
  static const getProviderInfo = "api/customer/provider/getProviderInfo?";
  static const getFilterWiseProvider = "api/customer/provider/getFilterWiseProvider";
  static const getProviderService = "api/customer/provider/getProviderServices?";

  /// =================== Appointment =================== ///
  static const getAppointmentTimeModel = "api/customer/appointment/checkAppointmentIsValid?";
  static const createBookingByCustomer = "api/customer/appointment/bookingByCustomer";
  static const getAllAppointment = "api/customer/appointment/getAppointmentByCust?";
  static const cancelAppointment = "api/customer/appointment/cancelAppointmentByCust?";
  static const reScheduleAppointment = "api/customer/appointment/rescheduleAppointmentByCust?";
  static const getAppointmentInfo = "api/customer/appointment/appointmentInfoByCust?";
  static const getUpcomingAppointment = "api/customer/appointment/fetchUpcomingBookingsForCust?";

  /// =================== Banner =================== ///
  static const getBanner = "api/customer/banner/getBanner";

  /// =================== Call =================== ///
  static const getCallEnableOrNot = "api/customer/provider/isCallEnableOrNot?";

  /// =================== Review =================== ///
  static const postReview = "api/customer/ratingReview/postReviewRating";
  static const getReview = "api/customer/ratingReview/getReviewOfProvider?";

  /// =================== Search =================== ///
  static const searchByCustomer = "api/customer/provider/searchByCustomer";

  /// =================== Notification =================== ///
  static const getNotification = "api/customer/notification/notificationList?";
  static const clearAllNotification = "api/customer/notification/clearNotificationHistory?";

  /// =================== Chat =================== ///
  static const getChatList = "api/customer/chatTopic/getChatList?";
  static const getOldChat = "api/customer/chat/getOldChat?";
  static const createChatImage = "api/customer/chat/createChat";

  /// =================== Wallet =================== ///
  static const depositWallet = "api/customer/customer/depositeToWallet?";
  static const getWalletHistory = "api/customer/customer/walletHistoryByCust?";

  /// =================== Coupon =================== ///
  static const getCoupon = "api/customer/coupon/retriveCoupons?";
  static const getCouponAmount = "api/customer/coupon/retriveValidateCoupon?";

  /// =================== Complain or Suggestion =================== ///
  static const raiseComplain = "api/customer/complaintSuggestion/raiseCompOrSuggByCust";
  static const getComplain = "api/customer/complaintSuggestion/retriveCompOrSuggByCust?";

  /// =================== Setting =================== ///
  static const getSetting = "api/customer/setting/fetchCustomerSettings";

  /// =================== Stripe Payment =================== ///
  static const stripeUrl = "https://api.stripe.com/v1/payment_intents";
}
