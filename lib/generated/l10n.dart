// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Phone number is required`
  String get phoneNumberReq {
    return Intl.message(
      'Phone number is required',
      name: 'phoneNumberReq',
      desc: '',
      args: [],
    );
  }

  /// `invalid text`
  String get notValideText {
    return Intl.message(
      'invalid text',
      name: 'notValideText',
      desc: '',
      args: [],
    );
  }

  /// `Too short`
  String get textError1 {
    return Intl.message(
      'Too short',
      name: 'textError1',
      desc: '',
      args: [],
    );
  }

  /// `Password Error`
  String get passwordsError {
    return Intl.message(
      'Password Error',
      name: 'passwordsError',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneEnter {
    return Intl.message(
      'Phone number',
      name: 'phoneEnter',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get enter {
    return Intl.message(
      'Submit',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code`
  String get code {
    return Intl.message(
      'Enter the code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Change phone number`
  String get changePhoneNumber {
    return Intl.message(
      'Change phone number',
      name: 'changePhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `verify phone number`
  String get varifyPhoneNumber {
    return Intl.message(
      'verify phone number',
      name: 'varifyPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Number of contacts`
  String get NumberOfContacts {
    return Intl.message(
      'Number of contacts',
      name: 'NumberOfContacts',
      desc: '',
      args: [],
    );
  }

  /// `Can't connect to the server to refresh data`
  String get CantConnectToTheServer {
    return Intl.message(
      'Can\'t connect to the server to refresh data',
      name: 'CantConnectToTheServer',
      desc: '',
      args: [],
    );
  }

  /// `Not feeling good`
  String get NotFeelingGood {
    return Intl.message(
      'Not feeling good',
      name: 'NotFeelingGood',
      desc: '',
      args: [],
    );
  }

  /// `Uploading your data`
  String get UploadingYourData {
    return Intl.message(
      'Uploading your data',
      name: 'UploadingYourData',
      desc: '',
      args: [],
    );
  }

  /// `Phone verified`
  String get phoneVerified {
    return Intl.message(
      'Phone verified',
      name: 'phoneVerified',
      desc: '',
      args: [],
    );
  }

  /// `Email verified`
  String get emailVerified {
    return Intl.message(
      'Email verified',
      name: 'emailVerified',
      desc: '',
      args: [],
    );
  }

  /// `Current number of our users`
  String get currentNumberOfOurUsers {
    return Intl.message(
      'Current number of our users',
      name: 'currentNumberOfOurUsers',
      desc: '',
      args: [],
    );
  }

  /// `What will happen now`
  String get whatWillHappenNow {
    return Intl.message(
      'What will happen now',
      name: 'whatWillHappenNow',
      desc: '',
      args: [],
    );
  }

  /// `Now we will upload all your scanned data, this will send all the data to the server for analyse and for notifying who you made contact with.`
  String get uploadingInformation1 {
    return Intl.message(
      'Now we will upload all your scanned data, this will send all the data to the server for analyse and for notifying who you made contact with.',
      name: 'uploadingInformation1',
      desc: '',
      args: [],
    );
  }

  /// `Please notice that all your data been saved on your device, this include your location data and your contact information.`
  String get uploadingInformation2 {
    return Intl.message(
      'Please notice that all your data been saved on your device, this include your location data and your contact information.',
      name: 'uploadingInformation2',
      desc: '',
      args: [],
    );
  }

  /// `Contact information`
  String get contactInformation {
    return Intl.message(
      'Contact information',
      name: 'contactInformation',
      desc: '',
      args: [],
    );
  }

  /// `Declare`
  String get declare {
    return Intl.message(
      'Declare',
      name: 'declare',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `User phone`
  String get userPhone {
    return Intl.message(
      'User phone',
      name: 'userPhone',
      desc: '',
      args: [],
    );
  }

  /// `User email`
  String get userEmail {
    return Intl.message(
      'User email',
      name: 'userEmail',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Mon`
  String get Mon {
    return Intl.message(
      'Mon',
      name: 'Mon',
      desc: '',
      args: [],
    );
  }

  /// `Tus`
  String get Tus {
    return Intl.message(
      'Tus',
      name: 'Tus',
      desc: '',
      args: [],
    );
  }

  /// `Thur`
  String get Thur {
    return Intl.message(
      'Thur',
      name: 'Thur',
      desc: '',
      args: [],
    );
  }

  /// `Web`
  String get Wed {
    return Intl.message(
      'Web',
      name: 'Wed',
      desc: '',
      args: [],
    );
  }

  /// `Fri`
  String get Fri {
    return Intl.message(
      'Fri',
      name: 'Fri',
      desc: '',
      args: [],
    );
  }

  /// `Sat`
  String get Sat {
    return Intl.message(
      'Sat',
      name: 'Sat',
      desc: '',
      args: [],
    );
  }

  /// `Sun`
  String get Sun {
    return Intl.message(
      'Sun',
      name: 'Sun',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get Today {
    return Intl.message(
      'Today',
      name: 'Today',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Users meet me per day`
  String get UsersMetMePerDay {
    return Intl.message(
      'Users meet me per day',
      name: 'UsersMetMePerDay',
      desc: '',
      args: [],
    );
  }

  /// `Users meet me reported`
  String get UsersMeetMeReport {
    return Intl.message(
      'Users meet me reported',
      name: 'UsersMeetMeReport',
      desc: '',
      args: [],
    );
  }

  /// `Users near me reported`
  String get UsersNearMeReported {
    return Intl.message(
      'Users near me reported',
      name: 'UsersNearMeReported',
      desc: '',
      args: [],
    );
  }

  /// `Reported cases`
  String get ReportedCases {
    return Intl.message(
      'Reported cases',
      name: 'ReportedCases',
      desc: '',
      args: [],
    );
  }

  /// `Invite others`
  String get InviteOthers {
    return Intl.message(
      'Invite others',
      name: 'InviteOthers',
      desc: '',
      args: [],
    );
  }

  /// `Current situation`
  String get CurrentSituation {
    return Intl.message(
      'Current situation',
      name: 'CurrentSituation',
      desc: '',
      args: [],
    );
  }

  /// `Please valid your basic info first`
  String get UploadingError {
    return Intl.message(
      'Please valid your basic info first',
      name: 'UploadingError',
      desc: '',
      args: [],
    );
  }

  /// `This week report`
  String get ContactThisWeek {
    return Intl.message(
      'This week report',
      name: 'ContactThisWeek',
      desc: '',
      args: [],
    );
  }

  /// `Anti Covid`
  String get AppName {
    return Intl.message(
      'Anti Covid',
      name: 'AppName',
      desc: '',
      args: [],
    );
  }

  /// `Radar`
  String get Radar {
    return Intl.message(
      'Radar',
      name: 'Radar',
      desc: '',
      args: [],
    );
  }

  /// `Connections`
  String get Connections {
    return Intl.message(
      'Connections',
      name: 'Connections',
      desc: '',
      args: [],
    );
  }

  /// `Reported`
  String get Reported {
    return Intl.message(
      'Reported',
      name: 'Reported',
      desc: '',
      args: [],
    );
  }

  /// `Feedback`
  String get Feedback {
    return Intl.message(
      'Feedback',
      name: 'Feedback',
      desc: '',
      args: [],
    );
  }

  /// `My full report`
  String get GetMyFullReport {
    return Intl.message(
      'My full report',
      name: 'GetMyFullReport',
      desc: '',
      args: [],
    );
  }

  /// `This month report`
  String get ThisMonthReport {
    return Intl.message(
      'This month report',
      name: 'ThisMonthReport',
      desc: '',
      args: [],
    );
  }

  /// `No connections yet`
  String get NoConnectionsYet {
    return Intl.message(
      'No connections yet',
      name: 'NoConnectionsYet',
      desc: '',
      args: [],
    );
  }

  /// `Users`
  String get Users {
    return Intl.message(
      'Users',
      name: 'Users',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get User {
    return Intl.message(
      'User',
      name: 'User',
      desc: '',
      args: [],
    );
  }

  /// `CIN`
  String get CIN {
    return Intl.message(
      'CIN',
      name: 'CIN',
      desc: '',
      args: [],
    );
  }

  /// `My State`
  String get MyCovidState {
    return Intl.message(
      'My State',
      name: 'MyCovidState',
      desc: '',
      args: [],
    );
  }

  /// `Exposures`
  String get Exposures {
    return Intl.message(
      'Exposures',
      name: 'Exposures',
      desc: '',
      args: [],
    );
  }

  /// `Report exposure`
  String get ReportExposure {
    return Intl.message(
      'Report exposure',
      name: 'ReportExposure',
      desc: '',
      args: [],
    );
  }

  /// `Current status`
  String get CurrentStatus {
    return Intl.message(
      'Current status',
      name: 'CurrentStatus',
      desc: '',
      args: [],
    );
  }

  /// `Report yourself as positive`
  String get ReportYourselfAsPositive {
    return Intl.message(
      'Report yourself as positive',
      name: 'ReportYourselfAsPositive',
      desc: '',
      args: [],
    );
  }

  /// `Positive`
  String get Positive {
    return Intl.message(
      'Positive',
      name: 'Positive',
      desc: '',
      args: [],
    );
  }

  /// `No positive`
  String get NoPositive {
    return Intl.message(
      'No positive',
      name: 'NoPositive',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get Report {
    return Intl.message(
      'Report',
      name: 'Report',
      desc: '',
      args: [],
    );
  }

  /// `ExposureID`
  String get ExposureID {
    return Intl.message(
      'ExposureID',
      name: 'ExposureID',
      desc: '',
      args: [],
    );
  }

  /// `If you notified of a possible exposure to COVID-19, We need the ID to get information about him, this ID can be find in the full report, under the last week section, Copy the ID, and put it below.`
  String get ExposureReportBody1 {
    return Intl.message(
      'If you notified of a possible exposure to COVID-19, We need the ID to get information about him, this ID can be find in the full report, under the last week section, Copy the ID, and put it below.',
      name: 'ExposureReportBody1',
      desc: '',
      args: [],
    );
  }

  /// `This will upload the ID to the server, and it will add the exposure in the reported list for all their contact, therefore notifying them, The detector will remain anonymous, and your status remains unchanged.`
  String get ExposureReportBody2 {
    return Intl.message(
      'This will upload the ID to the server, and it will add the exposure in the reported list for all their contact, therefore notifying them, The detector will remain anonymous, and your status remains unchanged.',
      name: 'ExposureReportBody2',
      desc: '',
      args: [],
    );
  }

  /// `Playing your part in alerting others in your network helps people get ahead of the spread and protect themselves.`
  String get ExposureReportBody3 {
    return Intl.message(
      'Playing your part in alerting others in your network helps people get ahead of the spread and protect themselves.',
      name: 'ExposureReportBody3',
      desc: '',
      args: [],
    );
  }

  /// `I don't have his ID`
  String get DontHaveID {
    return Intl.message(
      'I don\'t have his ID',
      name: 'DontHaveID',
      desc: '',
      args: [],
    );
  }

  /// `If a contact tracer alerts you of a positive exposure, you can anonymously notify your network.`
  String get NoExposureMessageReport {
    return Intl.message(
      'If a contact tracer alerts you of a positive exposure, you can anonymously notify your network.',
      name: 'NoExposureMessageReport',
      desc: '',
      args: [],
    );
  }

  /// `We don't have any exposures in your current contact`
  String get NoExposureMessage {
    return Intl.message(
      'We don\'t have any exposures in your current contact',
      name: 'NoExposureMessage',
      desc: '',
      args: [],
    );
  }

  /// `The ANTI COVID`
  String get HowAppWorks1 {
    return Intl.message(
      'The ANTI COVID',
      name: 'HowAppWorks1',
      desc: '',
      args: [],
    );
  }

  /// `We are keeping you update for each notification about any of the contacts that you reported to us, which if they are POSITIVE means you are exposed to the virus, therefore you must do a test, and alert all your contact about your current situation, throw our app all done anonymously, just keep your distance and stay safe.`
  String get ExposureMessage {
    return Intl.message(
      'We are keeping you update for each notification about any of the contacts that you reported to us, which if they are POSITIVE means you are exposed to the virus, therefore you must do a test, and alert all your contact about your current situation, throw our app all done anonymously, just keep your distance and stay safe.',
      name: 'ExposureMessage',
      desc: '',
      args: [],
    );
  }

  /// `will show the number of users that you are connected to, and it save them into the app database, which is encrypted, and all the information are the location of the contact, the user info, and when the contact happen`
  String get HowAppWorks2 {
    return Intl.message(
      'will show the number of users that you are connected to, and it save them into the app database, which is encrypted, and all the information are the location of the contact, the user info, and when the contact happen',
      name: 'HowAppWorks2',
      desc: '',
      args: [],
    );
  }

  /// `Start async GPS`
  String get TrackingGPSStart {
    return Intl.message(
      'Start async GPS',
      name: 'TrackingGPSStart',
      desc: '',
      args: [],
    );
  }

  /// `Stop async GPS`
  String get TrackingGPSStop {
    return Intl.message(
      'Stop async GPS',
      name: 'TrackingGPSStop',
      desc: '',
      args: [],
    );
  }

  /// `GPS report`
  String get GPSReport {
    return Intl.message(
      'GPS report',
      name: 'GPSReport',
      desc: '',
      args: [],
    );
  }

  /// `Async GPS`
  String get AsyncGPSTitle {
    return Intl.message(
      'Async GPS',
      name: 'AsyncGPSTitle',
      desc: '',
      args: [],
    );
  }

  /// `Date of`
  String get DateOf {
    return Intl.message(
      'Date of',
      name: 'DateOf',
      desc: '',
      args: [],
    );
  }

  /// `My sessions`
  String get MySessions {
    return Intl.message(
      'My sessions',
      name: 'MySessions',
      desc: '',
      args: [],
    );
  }

  /// `My full reports`
  String get MyFullReports {
    return Intl.message(
      'My full reports',
      name: 'MyFullReports',
      desc: '',
      args: [],
    );
  }

  /// `This months contacts`
  String get MyFullContactsThisMonth {
    return Intl.message(
      'This months contacts',
      name: 'MyFullContactsThisMonth',
      desc: '',
      args: [],
    );
  }

  /// `This is for creating nodes for each connection via the GPS, while the app running, and the data will be saved and secured in the database, for each contact will be saved in the database, and showing for you with whom you made contact in that node`
  String get TrackingGPSMessage1 {
    return Intl.message(
      'This is for creating nodes for each connection via the GPS, while the app running, and the data will be saved and secured in the database, for each contact will be saved in the database, and showing for you with whom you made contact in that node',
      name: 'TrackingGPSMessage1',
      desc: '',
      args: [],
    );
  }

  /// `The node is any contact you made in the GPS data collection, this will help to know with whom you made contact, when, where, beside to the danger state of the contact`
  String get TrackingGPSMessage2 {
    return Intl.message(
      'The node is any contact you made in the GPS data collection, this will help to know with whom you made contact, when, where, beside to the danger state of the contact',
      name: 'TrackingGPSMessage2',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
