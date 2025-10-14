import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class confing {
  static String baseUrl = "https://api.eulink.app/";

  static String baseUrlPublic = baseUrl + "api/provider/";

  static int Side_TYPE = 1;
  static int SPECIALIST_Type = 2;
  static int EXPERT_TYPE = 3;

  static int ACCOUNT_Customer_TYPE = 1;
  static int ACCOUNT_PROVIDER_TYPE = 2;

  static int ACTIVE_USER = 1;

  static int NOT_COMPLETE_USER = 2;

  static int DEACTIVATE_USER = 3;

  static int UNDER_REVIEW_USER = 4;

  static String UrlInstall = "home/install";
  static String UrlCategories = "categories";
  static String UrlSliders = "sliders";
  static String UrlBrands = "brands";
  static String UrlGuest = "guest";
  static String UrlOffer = "offers";
  static String UrlUniversities = "universities";
  static String UrlFaqs = "home/faqs";
   static String UrlPolicy = "policy";
  static String UrlTerms = "terms";
  static String UrlSocial = "social-links";
  static String UrlAvatars = "avatars";
  static String UrlServices = "services";
  static String UrlServicesUpdate = "update";





  //gpa
  static String UrlSemesters =  "gpa/semesters";





  //auth
  static String UrlLogin = "auth/login";
  static String UrlUpdate = "auth/update";
  static String UrlCities = "country/";
  static String UrlVisitor = "auth/visitor";
  static String UrlRegister = "auth/register";
  static String UrlVerify = "auth/verify";
  static String UrlVerifyEmail = "auth/email/verify";
  static String UrlContact = "contact";
  static String UrlShowSchedules= "schedules/show";
  static String UrlShowSchedulesUpdate= "schedules/update";




  static String UrlResendVerify = "auth/resend_verify";
  static String UrlResendVerifyEmail = "auth/email/resend_verify";




  static String UrlMe = "auth/info";
  static String UrlUpdateUser = "auth/update";
  static String UrlLogout = "auth/logout";
  static String UrlDelete =  "auth/delete";
  static String UrlUserReviews = "orders/all_reviews";
  static String UrlUserspecialists = "specialists";
  static String UrlUnicodeCards = "auth/unicode-cards";
  static String UrlUnicodeCard = "auth/unicode-card";


  static String UrlForgetPassword = "auth/forget_password";
  static String UrlResetPassword = "auth/reset_password";
  static String UrlChangePassword = "auth/change_password";

  //menu

  static String UrlMembershipsSubscription =  "memberships/subscription";
  static String UrlMembershipsSubscribe =  "memberships/subscribe";
  static String UrlMembershipsPlans =  "memberships/plans";
  static String UrlSubscriptions =  "memberships/subscriptions/";
  static String UrlSchedulesUpdate =  "schedules/update/";

  //address
  static String UrlCreateAddress = "address/store";
  static String UrlUpdateAddress = "address/update";
  static String UrlMyAddress = "address";


  static String UrlTickets = "tickets";
  static String UrlTicketShow = "tickets/show";
  static String UrlTicketStore = "tickets/store";
  static String UrlTicketResponse = "tickets/response";

  //order
  static String UrlCreateProducts = "products/store";
  static String UrlUpdateProducts = "products/update";
  static String UrlProducts = "products";
  static String UrlAuthProducts = "products/products_auth";
  //static String UrlMyProducts = "products/my_product";
  static String UrlDeleteProducts = "products/delete";
  static String UrlDeleteMedia = "media/delete";

  static String UrlToggleFavorite = "products/toggle_favorite";
  static String UrlFavorites = "products/favorites";





  //product
  static String UrlCreateOrder = "orders/store";
  static String UrlUpdateOrderData = "orders/update_details";


  //product
  static String UrlAddToCart = "cart/store";
  static String UrlUpdateCart = "cart/update";
  static String UrlDeleteCart = "cart/delete";
  static String UrlCartList = "cart";

  static String UrlCartDelivery_cost = "cart/delivery_cost";




  //orders
  static String UrlOrders = "orders";
  static String UrlChat = "chat";
  static String UrlChatSend = "chat/send";
  static String UrlShow = "show";
  static String UrlOrderDetails = "orders/show";
  static String UrlUpdateOrder = "orders/update";

  // notifications query
  static String UrlNotifications = "notifications";
  static String UrlNotificationsRead = "notifications/read_all";
  static String UrlNotificationsReadAll = "notifications/read_all";

  // order review
  static String UrlOrdersReview = "products/review";

  // chat rooms
  static String UrlChatRooms = "chats/rooms";
  static String UrlCreateChatRooms = "chats/rooms/create";
  static String UrlChatMessages = "chats/rooms/messages";
  static String UrlCreateChatMessages = "chats/rooms/messages/create";

  // Transactions query
  static String UrlTransactionsMyBalance = "transactions/my_balance";
  static String UrlTransactions = "transactions";
  static String UrlTransGenerateCheckout = "transactions/generate_checkout";
  static String UrlRequestRefund = "transactions/request_refund";
  static String UrlCheckPayment = "transactions/check_payment";

  static int OrderTypesText = 1;
  static int OrderTypesVoice = 2;
  static int OrderTypesfile = 3;

  // static int   OrderTypesVideo= 4;
  static int OrderTypesImage = 5;

  static int OrderStatusNew = 1;
  static int OrderStatusAccept = 2;
  static int OrderStatusPayed = 3;
  static int OrderStatusInProgress = 4;
  static int OrderStatusInDelivery = 5;
  static int OrderStatusDelivered = 6;
  static int OrderStatusReceipt = 7;
  static int OrderStatusCancelled = 8;
  static int OrderStatusRejected= 9;



  static int UserStatusActive = 1;
  static int UserStatusNotComplete = 2;
  static int UserStatusDeactivate = 3;
  static int UserStatusUnderReview = 4;
}
