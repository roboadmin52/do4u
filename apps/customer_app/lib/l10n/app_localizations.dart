import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Do4U'**
  String get appName;

  /// No description provided for @needSomethingDone.
  ///
  /// In en, this message translates to:
  /// **'Need something done?'**
  String get needSomethingDone;

  /// No description provided for @createNewErrand.
  ///
  /// In en, this message translates to:
  /// **'Create New Errand'**
  String get createNewErrand;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select Category'**
  String get selectCategory;

  /// No description provided for @government.
  ///
  /// In en, this message translates to:
  /// **'Government'**
  String get government;

  /// No description provided for @shopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shopping;

  /// No description provided for @pickupDropoff.
  ///
  /// In en, this message translates to:
  /// **'Pick-Up & Drop-Off'**
  String get pickupDropoff;

  /// No description provided for @queueing.
  ///
  /// In en, this message translates to:
  /// **'Queueing'**
  String get queueing;

  /// No description provided for @carErrands.
  ///
  /// In en, this message translates to:
  /// **'Car Errands'**
  String get carErrands;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// No description provided for @errandDetails.
  ///
  /// In en, this message translates to:
  /// **'Errand Details'**
  String get errandDetails;

  /// No description provided for @subType.
  ///
  /// In en, this message translates to:
  /// **'Sub-type'**
  String get subType;

  /// No description provided for @instructions.
  ///
  /// In en, this message translates to:
  /// **'Detailed Instructions'**
  String get instructions;

  /// No description provided for @expressService.
  ///
  /// In en, this message translates to:
  /// **'Express Service (+40%)'**
  String get expressService;

  /// No description provided for @reviewPrice.
  ///
  /// In en, this message translates to:
  /// **'Review Price & Book'**
  String get reviewPrice;

  /// No description provided for @priceEstimate.
  ///
  /// In en, this message translates to:
  /// **'Price Estimate'**
  String get priceEstimate;

  /// No description provided for @baseFee.
  ///
  /// In en, this message translates to:
  /// **'Base Fee'**
  String get baseFee;

  /// No description provided for @peakSurcharge.
  ///
  /// In en, this message translates to:
  /// **'Peak Surcharge'**
  String get peakSurcharge;

  /// No description provided for @expressSurcharge.
  ///
  /// In en, this message translates to:
  /// **'Express Surcharge'**
  String get expressSurcharge;

  /// No description provided for @distanceSurcharge.
  ///
  /// In en, this message translates to:
  /// **'Distance Surcharge'**
  String get distanceSurcharge;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @confirmBook.
  ///
  /// In en, this message translates to:
  /// **'Confirm & Book Errand'**
  String get confirmBook;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @errands.
  ///
  /// In en, this message translates to:
  /// **'Errands'**
  String get errands;

  /// No description provided for @members.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get members;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
