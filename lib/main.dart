import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hrm_app/api_service/estimate_order_service.dart';
import 'package:hrm_app/api_service/invoice_order_service.dart';
import 'package:hrm_app/api_service/pos_cart_service.dart';
import 'package:hrm_app/api_service/proposal_order_service.dart';
import 'package:hrm_app/data/model/client_estimate/estimateOrderCart.dart';
import 'package:hrm_app/data/model/client_invoice/invoiceOrderCart.dart';
import 'package:hrm_app/data/model/client_proposal/proposalOrderCart.dart';
import 'package:hrm_app/data/model/crm_sales/cart.dart';
import 'package:hrm_app/data/model/f_c_m_data_model.dart';
import 'package:hrm_app/live_traking/location_provider.dart';
import 'package:hrm_app/screens/appFlow/home/appreciate_teammate/apreciate_teamate_provider.dart';
import 'package:hrm_app/screens/appFlow/home/attendeance/attendance.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/campaign/provider/campaign_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/coupon/provider/coupon_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/discount/provider/discount_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/booking/service/provider/service_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/clients/provider/downloads_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/contract/provider/contract_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/crm_appoinment/provider/appointment_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/lead/provider/lead_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/all_leave_request_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/leave_calender/leave_calender_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/leave_note/create_leave_request_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/leave_request_details/leave_request_details_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/leave/leave_type/leave_type_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/mailbox/provider/mailbox_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/menu_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/office_tab/change_password/change_password_profile_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/office_tab/edit_official_info/deartment_list/department_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/my_account/tab/office_tab/edit_official_info/designation_list/designation_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_create_estimate_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_create_invoice_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/new_clients_details/provider/client_create_proposal_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/notice/notice_screen.dart';
import 'package:hrm_app/screens/appFlow/menu/phonebook/phonebook_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/adjustment/provider/adjustment_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/biller/provider/biller_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/customer/provider/customer_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/pos/provider/pos_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/product/provider/product_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/purchase/provider/purchase_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/sale/provider/sale_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/sales/stock_management/provider/stock_list_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/monthly_overview_provider.dart';
import 'package:hrm_app/screens/appFlow/menu/time_sheet/provider/timesheet_overview_provider.dart';
import 'package:hrm_app/screens/appFlow/navigation_bar/bottom_nav_controller.dart';
import 'package:hrm_app/screens/auth/change_password/change_password_provider.dart';
import 'package:hrm_app/screens/auth/forget_password/forget_pass_provider.dart';
import 'package:hrm_app/screens/auth/login/login_provider.dart';
import 'package:hrm_app/screens/domain_selection/domain_provider.dart';
import 'package:hrm_app/utils/global_state.dart';
import 'package:hrm_app/utils/notification_service.dart';
import 'package:hrm_app/utils/res.dart';
import 'package:hrm_app/utils/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'api_provider/api_provider.dart';
import 'api_service/connectivity/connectivity_status.dart';
import 'live_traking/hive/driver_location_model.dart';
import 'live_traking/hive/driver_location_provider.dart';
import 'screens/appFlow/menu/sales/quotation/provider/quotation_list_provider.dart';
import 'screens/appFlow/menu/task/task_list/task_list_provider.dart';
import 'screens/auth/splash_screen/splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final global = GlobalState.instance;

Future openBox() async {
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(DriverLocationModelAdapter());
  await Hive.openBox<DriverLocationModel>(location);
}

void main() async {

  /// for play store and app store update dialog
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  Hive.registerAdapter(CartAdapter());
  Hive.registerAdapter(InvoiceOrderCartAdapter());
  Hive.registerAdapter(ProposalOrderCartAdapter());
  Hive.registerAdapter(EstimateOrderCartAdapter());

  ///initializeFirebaseAtStatingPoint
  await Firebase.initializeApp();

  await FlutterDownloader.initialize(debug: true);

  ///get device details information
  await getDeviceId();

  await openBox();
  Hive.openBox<Cart>(cartBoxName);
  Hive.openBox<InvoiceOrderCart>(invoiceOrderBoxName);
  Hive.openBox<ProposalOrderCart>(proposalOrderBoxName);
  Hive.openBox<EstimateOrderCart>(estimateOrderBoxName);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  ///top-level function
  ///to handle background messaging
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('bn', 'BN'),
        Locale('ar', 'AR'),
        Locale('es', 'ES'),
        Locale('fr', 'FR'),
      ],
      path: 'assets/translations',
      saveLocale: true,
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp()));
  configLoading();
}

Future<void> getDeviceId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    final result =
        '${iosDeviceInfo.name}-${iosDeviceInfo.model}-${iosDeviceInfo.identifierForVendor}';
    SPUtill.setValue(SPUtill.keyIosDeviceToken, result);
  } else {
    final androidDeviceInfo = await deviceInfo.androidInfo;
    final result =
        '${androidDeviceInfo.brand}-${androidDeviceInfo.device}-${androidDeviceInfo.id}';
    SPUtill.setValue(SPUtill.keyAndroidDeviceToken, result);
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = AppColors.colorPrimary
    ..backgroundColor = Colors.transparent
    ..indicatorColor = AppColors.colorPrimary
    ..textColor = AppColors.colorPrimary
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..boxShadow = <BoxShadow>[];
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: ((context, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ApiProvider()),
              ChangeNotifierProvider(create: (_) => LoginProvider()),
              ChangeNotifierProvider(create: (_) => BottomNavController()),
              ChangeNotifierProvider(create: (_) => ForgetPassProvider()),
              ChangeNotifierProvider(create: (_) => ChangePasswordProvider()),
              ChangeNotifierProvider(create: (_) => ChangePasswordProfileProvider()),
              ChangeNotifierProvider(create: (_) => DepartmentProvider()),
              ChangeNotifierProvider(create: (_) => DesignationProvider()),
              ChangeNotifierProvider(create: (_) => LeaveTypeProvider()),
              ChangeNotifierProvider(create: (_) => AllLeaveRequestProvider()),
              ChangeNotifierProvider(create: (_) => LeaveCalenderProvider()),
              ChangeNotifierProvider(create: (_) => CreateLeaveRequestProvider()),
              ChangeNotifierProvider(create: (_) => AppreciateTeammateProvider()),
              ChangeNotifierProvider(create: (_) => PhonebookProvider()),
              ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
              ChangeNotifierProvider(create: (_) => DownloadsProvider()),
              ChangeNotifierProvider(create: (_) => CrmTaskListProvider()),
              ChangeNotifierProvider(create: (_) => MenuProvider()),
              ChangeNotifierProvider(create: (_) => LocationProvider()),
              ChangeNotifierProvider(create: (_) => DomainProvider()),
              ChangeNotifierProvider(create: (_) => ProductListProvider()),
              ChangeNotifierProvider(create: (_) => AdjustmentListProvider()),
              ChangeNotifierProvider(create: (_) => StockListProvider()),
              ChangeNotifierProvider(create: (_) => PurchaseListProvider()),
              ChangeNotifierProvider(create: (_) => SaleListProvider()),
              ChangeNotifierProvider(create: (_) => QuotationListProvider()),
              ChangeNotifierProvider(create: (_) => BillerListProvider()),
              ChangeNotifierProvider(create: (_) => CustomerListProvider()),
              ChangeNotifierProvider(create: (_) => LeadListProvider()),
              ChangeNotifierProvider(create: (_) => PosProvider()),
              ChangeNotifierProvider(create: (_) => ServiceListProvider()),
              ChangeNotifierProvider(create: (_) => DiscountListProvider()),
              ChangeNotifierProvider(create: (_) => CampaignListProvider()),
              ChangeNotifierProvider(create: (_) => CouponListProvider()),
              ChangeNotifierProvider(create: (_) => CrmAppointmentListProvider()),
              ChangeNotifierProvider(create: (_) => ContractListProvider()),
              ChangeNotifierProvider(create: (_) => ClientCreateInvoiceProvider()),
              ChangeNotifierProvider(create: (_) => ClientCreateProposalProvider()),
              ChangeNotifierProvider(create: (_) => ClientCreateEstimateProvider()),
              ChangeNotifierProvider(create: (_) => TimeSheetOverviewProvider()),
              ChangeNotifierProvider(create: (_) => MonthlyOverviewProvider()),
              ChangeNotifierProvider(create: (_) => MailBoxProvider("")),
              ChangeNotifierProvider<CartService>(create: (context) => CartService()),
              ChangeNotifierProvider<InvoiceOrderService>(create: (context) => InvoiceOrderService()),
              ChangeNotifierProvider<ProposalOrderService>(create: (context) => ProposalOrderService()),
              ChangeNotifierProvider<EstimateOrderService>(create: (context) => EstimateOrderService()),
            ],
            child: MaterialApp(
              title: 'Wismaa CRM',
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              initialRoute: '/',
              routes: {
                '/': (context) => const SplashScreen(),
                '/leave_details': (context) => const LeaveRequestDetails(),
                '/notice_screen': (context) => const NoticeScreen(),
                '/attendance': (context) => const Attendance(navigationMenu: false)
              },
              theme: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: AppColors.colorPrimary,
                      ),
                  textTheme: GoogleFonts.interTextTheme(),
                  appBarTheme: const AppBarTheme(
                      backgroundColor: AppColors.appBarColor,
                    titleTextStyle: TextStyle(color: Colors.black),
                    iconTheme: IconThemeData(color: Colors.black)
                  )),
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              builder: EasyLoading.init(),
            ),
          );
        }));
  
  
  }
}

///Handle background messaging service
///It must not be an anonymous function.
/// It must be a top-level function (e.g. not a class method which requires initialization).
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification?.title == null) {
    final encodedString = json.encode(message.data);

    ///data class which will parse convert message to model data
    FCMDataModel notification = FCMDataModel.fromJson(message.data);

    ///background notification handler
    if (notification.image == null) {
      await notificationPlugin.showNotification(
          title: notification.title ?? message.notification?.title,
          body: notification.body ?? message.notification?.body,
          payload: encodedString);
    } else {
      await notificationPlugin.showNotificationWithAttachment(
          title: notification.title ?? message.notification?.title,
          body: notification.body ?? message.notification?.body,
          image: notification.image,
          payload: encodedString);
    }
  }
}
