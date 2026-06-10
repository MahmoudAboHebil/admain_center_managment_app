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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Students`
  String get studentsPageTitle {
    return Intl.message(
      'Students',
      name: 'studentsPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search by name...`
  String get searchByName {
    return Intl.message(
      'Search by name...',
      name: 'searchByName',
      desc: '',
      args: [],
    );
  }

  /// `Total Students`
  String get totalStudents {
    return Intl.message(
      'Total Students',
      name: 'totalStudents',
      desc: '',
      args: [],
    );
  }

  /// `Active Classes`
  String get totalClasses {
    return Intl.message(
      'Active Classes',
      name: 'totalClasses',
      desc: '',
      args: [],
    );
  }

  /// `View Profile`
  String get showPortfolio {
    return Intl.message(
      'View Profile',
      name: 'showPortfolio',
      desc: '',
      args: [],
    );
  }

  /// `Delete Student`
  String get deleteStudent {
    return Intl.message(
      'Delete Student',
      name: 'deleteStudent',
      desc: '',
      args: [],
    );
  }

  /// `Attendance Record`
  String get attendanceList {
    return Intl.message(
      'Attendance Record',
      name: 'attendanceList',
      desc: '',
      args: [],
    );
  }

  /// `Search Results`
  String get searchResults {
    return Intl.message(
      'Search Results',
      name: 'searchResults',
      desc: '',
      args: [],
    );
  }

  /// `Show All Results`
  String get showAllResults {
    return Intl.message(
      'Show All Results',
      name: 'showAllResults',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edite {
    return Intl.message('Edit', name: 'edite', desc: '', args: []);
  }

  /// `Add New Student`
  String get addNewStudent {
    return Intl.message(
      'Add New Student',
      name: 'addNewStudent',
      desc: '',
      args: [],
    );
  }

  /// `Add Student`
  String get addStudent {
    return Intl.message('Add Student', name: 'addStudent', desc: '', args: []);
  }

  /// `Basic Information`
  String get primaryInfo {
    return Intl.message(
      'Basic Information',
      name: 'primaryInfo',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Example: Mohamed Ahmed Ali`
  String get nameExample {
    return Intl.message(
      'Example: Mohamed Ahmed Ali',
      name: 'nameExample',
      desc: '',
      args: [],
    );
  }

  /// `Student name is required`
  String get nameRequired {
    return Intl.message(
      'Student name is required',
      name: 'nameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get type {
    return Intl.message('Gender', name: 'type', desc: '', args: []);
  }

  /// `Contact Information`
  String get contactInfo {
    return Intl.message(
      'Contact Information',
      name: 'contactInfo',
      desc: '',
      args: [],
    );
  }

  /// `Student Phone Number`
  String get studentPhone {
    return Intl.message(
      'Student Phone Number',
      name: 'studentPhone',
      desc: '',
      args: [],
    );
  }

  /// `Parent Phone Number`
  String get parentPhone {
    return Intl.message(
      'Parent Phone Number',
      name: 'parentPhone',
      desc: '',
      args: [],
    );
  }

  /// `Home Phone Number`
  String get homePhone {
    return Intl.message(
      'Home Phone Number',
      name: 'homePhone',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email {
    return Intl.message('Email Address', name: 'email', desc: '', args: []);
  }

  /// `Invalid email address`
  String get emailNotValid {
    return Intl.message(
      'Invalid email address',
      name: 'emailNotValid',
      desc: '',
      args: [],
    );
  }

  /// `Parent's Job`
  String get parentJob {
    return Intl.message('Parent\'s Job', name: 'parentJob', desc: '', args: []);
  }

  /// `Job`
  String get job {
    return Intl.message('Job', name: 'job', desc: '', args: []);
  }

  /// `Academic Path`
  String get acadamicPath {
    return Intl.message(
      'Academic Path',
      name: 'acadamicPath',
      desc: '',
      args: [],
    );
  }

  /// `Class`
  String get studyClass {
    return Intl.message('Class', name: 'studyClass', desc: '', args: []);
  }

  /// `Group`
  String get group {
    return Intl.message('Group', name: 'group', desc: '', args: []);
  }

  /// `Payment Type`
  String get paymentType {
    return Intl.message(
      'Payment Type',
      name: 'paymentType',
      desc: '',
      args: [],
    );
  }

  /// `Per Month`
  String get byMonth {
    return Intl.message('Per Month', name: 'byMonth', desc: '', args: []);
  }

  /// `Per Class`
  String get byClass {
    return Intl.message('Per Class', name: 'byClass', desc: '', args: []);
  }

  /// `Additional Notes`
  String get additionalNotes {
    return Intl.message(
      'Additional Notes',
      name: 'additionalNotes',
      desc: '',
      args: [],
    );
  }

  /// `Any other student details...`
  String get anyStudentDetails {
    return Intl.message(
      'Any other student details...',
      name: 'anyStudentDetails',
      desc: '',
      args: [],
    );
  }

  /// `Incomplete Data`
  String get unCompleteDetails {
    return Intl.message(
      'Incomplete Data',
      name: 'unCompleteDetails',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect Information`
  String get informationNotCorrect {
    return Intl.message(
      'Incorrect Information',
      name: 'informationNotCorrect',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get wrongHappened {
    return Intl.message(
      'Something went wrong',
      name: 'wrongHappened',
      desc: '',
      args: [],
    );
  }

  /// `Could not complete the operation, please try again later`
  String get tryAgainLater {
    return Intl.message(
      'Could not complete the operation, please try again later',
      name: 'tryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `Student created successfully`
  String get studentCreated {
    return Intl.message(
      'Student created successfully',
      name: 'studentCreated',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Edit Student`
  String get editStudent {
    return Intl.message(
      'Edit Student',
      name: 'editStudent',
      desc: '',
      args: [],
    );
  }

  /// `Student updated successfully`
  String get studentEdited {
    return Intl.message(
      'Student updated successfully',
      name: 'studentEdited',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Late Payment`
  String get latePayment {
    return Intl.message(
      'Late Payment',
      name: 'latePayment',
      desc: '',
      args: [],
    );
  }

  /// `Apply Filters`
  String get applyFilters {
    return Intl.message(
      'Apply Filters',
      name: 'applyFilters',
      desc: '',
      args: [],
    );
  }

  /// `Filters`
  String get filterResults {
    return Intl.message('Filters', name: 'filterResults', desc: '', args: []);
  }

  /// `Reset Filters`
  String get reset {
    return Intl.message('Reset Filters', name: 'reset', desc: '', args: []);
  }

  /// `Active`
  String get active {
    return Intl.message('Active', name: 'active', desc: '', args: []);
  }

  /// `Inactive`
  String get inactive {
    return Intl.message('Inactive', name: 'inactive', desc: '', args: []);
  }

  /// `Student Profile`
  String get studentProfile {
    return Intl.message(
      'Student Profile',
      name: 'studentProfile',
      desc: '',
      args: [],
    );
  }

  /// `Attendance Rate`
  String get attendanceRate {
    return Intl.message(
      'Attendance Rate',
      name: 'attendanceRate',
      desc: '',
      args: [],
    );
  }

  /// `Class`
  String get className {
    return Intl.message('Class', name: 'className', desc: '', args: []);
  }

  /// `Not Provided`
  String get notAdded {
    return Intl.message('Not Provided', name: 'notAdded', desc: '', args: []);
  }

  /// `Lesson Schedule`
  String get classSchedule {
    return Intl.message(
      'Lesson Schedule',
      name: 'classSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Add New Note`
  String get addNewNote {
    return Intl.message('Add New Note', name: 'addNewNote', desc: '', args: []);
  }

  /// `Administrative Details`
  String get administrativeDetails {
    return Intl.message(
      'Administrative Details',
      name: 'administrativeDetails',
      desc: '',
      args: [],
    );
  }

  /// `Teacher Notes`
  String get teacherNotes {
    return Intl.message(
      'Teacher Notes',
      name: 'teacherNotes',
      desc: '',
      args: [],
    );
  }

  /// `Student deleted successfully`
  String get studentDeleted {
    return Intl.message(
      'Student deleted successfully',
      name: 'studentDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Results found`
  String get resultsFound {
    return Intl.message(
      'Results found',
      name: 'resultsFound',
      desc: '',
      args: [],
    );
  }

  /// `Students`
  String get students {
    return Intl.message('Students', name: 'students', desc: '', args: []);
  }

  /// `Clear Filters`
  String get clearFilters {
    return Intl.message(
      'Clear Filters',
      name: 'clearFilters',
      desc: '',
      args: [],
    );
  }

  /// `All Classes`
  String get allClasses {
    return Intl.message('All Classes', name: 'allClasses', desc: '', args: []);
  }

  /// `All Sections`
  String get allSections {
    return Intl.message(
      'All Sections',
      name: 'allSections',
      desc: '',
      args: [],
    );
  }

  /// `All Payment Types`
  String get allPaymentTypes {
    return Intl.message(
      'All Payment Types',
      name: 'allPaymentTypes',
      desc: '',
      args: [],
    );
  }

  /// `All Student Status`
  String get allStudentStatus {
    return Intl.message(
      'All Student Status',
      name: 'allStudentStatus',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Classes`
  String get classes {
    return Intl.message('Classes', name: 'classes', desc: '', args: []);
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message('Dashboard', name: 'dashboard', desc: '', args: []);
  }

  /// `Select All`
  String get selectAll {
    return Intl.message('Select All', name: 'selectAll', desc: '', args: []);
  }

  /// `Selected`
  String get selected {
    return Intl.message('Selected', name: 'selected', desc: '', args: []);
  }

  /// `Students`
  String get theStudents {
    return Intl.message('Students', name: 'theStudents', desc: '', args: []);
  }

  /// `Search Students`
  String get studentSearch {
    return Intl.message(
      'Search Students',
      name: 'studentSearch',
      desc: '',
      args: [],
    );
  }

  /// `Edit Details`
  String get editeDetails {
    return Intl.message(
      'Edit Details',
      name: 'editeDetails',
      desc: '',
      args: [],
    );
  }

  /// `Class has been deleted`
  String get classDeleted {
    return Intl.message(
      'Class has been deleted',
      name: 'classDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Register Attendance`
  String get registerAttendance {
    return Intl.message(
      'Register Attendance',
      name: 'registerAttendance',
      desc: '',
      args: [],
    );
  }

  /// `Monday`
  String get monday {
    return Intl.message('Monday', name: 'monday', desc: '', args: []);
  }

  /// `Tuesday`
  String get tuesday {
    return Intl.message('Tuesday', name: 'tuesday', desc: '', args: []);
  }

  /// `Wednesday`
  String get wednesday {
    return Intl.message('Wednesday', name: 'wednesday', desc: '', args: []);
  }

  /// `Thursday`
  String get thursday {
    return Intl.message('Thursday', name: 'thursday', desc: '', args: []);
  }

  /// `Friday`
  String get friday {
    return Intl.message('Friday', name: 'friday', desc: '', args: []);
  }

  /// `Saturday`
  String get saturday {
    return Intl.message('Saturday', name: 'saturday', desc: '', args: []);
  }

  /// `Sunday`
  String get sunday {
    return Intl.message('Sunday', name: 'sunday', desc: '', args: []);
  }

  /// `AM`
  String get am {
    return Intl.message('AM', name: 'am', desc: '', args: []);
  }

  /// `PM`
  String get bm {
    return Intl.message('PM', name: 'bm', desc: '', args: []);
  }

  /// `Schedule`
  String get timeSchedule {
    return Intl.message('Schedule', name: 'timeSchedule', desc: '', args: []);
  }

  /// `Classes per Week`
  String get weeklySections {
    return Intl.message(
      'Classes per Week',
      name: 'weeklySections',
      desc: '',
      args: [],
    );
  }

  /// `Registered Students`
  String get registeredStudents {
    return Intl.message(
      'Registered Students',
      name: 'registeredStudents',
      desc: '',
      args: [],
    );
  }

  /// `Student`
  String get student {
    return Intl.message('Student', name: 'student', desc: '', args: []);
  }

  /// `Academic Number`
  String get academicNumber {
    return Intl.message(
      'Academic Number',
      name: 'academicNumber',
      desc: '',
      args: [],
    );
  }

  /// `Absent`
  String get missing {
    return Intl.message('Absent', name: 'missing', desc: '', args: []);
  }

  /// `Class Details`
  String get classDetails {
    return Intl.message(
      'Class Details',
      name: 'classDetails',
      desc: '',
      args: [],
    );
  }

  /// `Number of Classes`
  String get classNumber {
    return Intl.message(
      'Number of Classes',
      name: 'classNumber',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get generalLook {
    return Intl.message('Overview', name: 'generalLook', desc: '', args: []);
  }

  /// `Class Management`
  String get classSettings {
    return Intl.message(
      'Class Management',
      name: 'classSettings',
      desc: '',
      args: [],
    );
  }

  /// `Please select at least one session.`
  String get classError {
    return Intl.message(
      'Please select at least one session.',
      name: 'classError',
      desc: '',
      args: [],
    );
  }

  /// `Please set the start time and end time for all selected days.`
  String get classError2 {
    return Intl.message(
      'Please set the start time and end time for all selected days.',
      name: 'classError2',
      desc: '',
      args: [],
    );
  }

  /// `Start time and end time cannot be the same.`
  String get classError3 {
    return Intl.message(
      'Start time and end time cannot be the same.',
      name: 'classError3',
      desc: '',
      args: [],
    );
  }

  /// `Add Class`
  String get addClass {
    return Intl.message('Add Class', name: 'addClass', desc: '', args: []);
  }

  /// `Step 1 of 2`
  String get stepOne {
    return Intl.message('Step 1 of 2', name: 'stepOne', desc: '', args: []);
  }

  /// `Class name is required.`
  String get classNameReq {
    return Intl.message(
      'Class name is required.',
      name: 'classNameReq',
      desc: '',
      args: [],
    );
  }

  /// `Class location is required.`
  String get classPlaceReq {
    return Intl.message(
      'Class location is required.',
      name: 'classPlaceReq',
      desc: '',
      args: [],
    );
  }

  /// `Class has been created`
  String get classCreated {
    return Intl.message(
      'Class has been created',
      name: 'classCreated',
      desc: '',
      args: [],
    );
  }

  /// `Next: Set Schedule`
  String get nextStep {
    return Intl.message(
      'Next: Set Schedule',
      name: 'nextStep',
      desc: '',
      args: [],
    );
  }

  /// `Add Session`
  String get addSection {
    return Intl.message('Add Session', name: 'addSection', desc: '', args: []);
  }

  /// `First Step`
  String get firstStep {
    return Intl.message('First Step', name: 'firstStep', desc: '', args: []);
  }

  /// `Create New Class`
  String get createNewClass {
    return Intl.message(
      'Create New Class',
      name: 'createNewClass',
      desc: '',
      args: [],
    );
  }

  /// `Add the basic information to define the new class.`
  String get informationHint {
    return Intl.message(
      'Add the basic information to define the new class.',
      name: 'informationHint',
      desc: '',
      args: [],
    );
  }

  /// `Class Name`
  String get className2 {
    return Intl.message('Class Name', name: 'className2', desc: '', args: []);
  }

  /// `Example: Advanced Mathematics - Group A`
  String get classNameExample {
    return Intl.message(
      'Example: Advanced Mathematics - Group A',
      name: 'classNameExample',
      desc: '',
      args: [],
    );
  }

  /// `Grade Level`
  String get classGrade {
    return Intl.message('Grade Level', name: 'classGrade', desc: '', args: []);
  }

  /// `Class`
  String get classTitle {
    return Intl.message('Class', name: 'classTitle', desc: '', args: []);
  }

  /// `First`
  String get first {
    return Intl.message('First', name: 'first', desc: '', args: []);
  }

  /// `Second`
  String get second {
    return Intl.message('Second', name: 'second', desc: '', args: []);
  }

  /// `Section`
  String get division {
    return Intl.message('Section', name: 'division', desc: '', args: []);
  }

  /// `Location`
  String get place {
    return Intl.message('Location', name: 'place', desc: '', args: []);
  }

  /// `Example: Room 104`
  String get placeExample {
    return Intl.message(
      'Example: Room 104',
      name: 'placeExample',
      desc: '',
      args: [],
    );
  }

  /// `Basic Identity`
  String get identity {
    return Intl.message('Basic Identity', name: 'identity', desc: '', args: []);
  }

  /// `Make sure the basic data is accurate before moving to scheduling.`
  String get informationHint2 {
    return Intl.message(
      'Make sure the basic data is accurate before moving to scheduling.',
      name: 'informationHint2',
      desc: '',
      args: [],
    );
  }

  /// `Second Step`
  String get secondStep {
    return Intl.message('Second Step', name: 'secondStep', desc: '', args: []);
  }

  /// `Select Times`
  String get selectDates {
    return Intl.message(
      'Select Times',
      name: 'selectDates',
      desc: '',
      args: [],
    );
  }

  /// `Select Weekdays`
  String get selectWeekDays {
    return Intl.message(
      'Select Weekdays',
      name: 'selectWeekDays',
      desc: '',
      args: [],
    );
  }

  /// `Session Details`
  String get sectionsDetails {
    return Intl.message(
      'Session Details',
      name: 'sectionsDetails',
      desc: '',
      args: [],
    );
  }

  /// `If the end time is earlier than the start time, the session will automatically be considered to continue into the next day.`
  String get sectionHint {
    return Intl.message(
      'If the end time is earlier than the start time, the session will automatically be considered to continue into the next day.',
      name: 'sectionHint',
      desc: '',
      args: [],
    );
  }

  /// `Start time and end time cannot be the same.`
  String get sectionHint2 {
    return Intl.message(
      'Start time and end time cannot be the same.',
      name: 'sectionHint2',
      desc: '',
      args: [],
    );
  }

  /// `h`
  String get hour {
    return Intl.message('h', name: 'hour', desc: '', args: []);
  }

  /// `m`
  String get minute {
    return Intl.message('m', name: 'minute', desc: '', args: []);
  }

  /// `Start Time`
  String get startTime {
    return Intl.message('Start Time', name: 'startTime', desc: '', args: []);
  }

  /// `End Time`
  String get endTime {
    return Intl.message('End Time', name: 'endTime', desc: '', args: []);
  }

  /// `Edit Class Information`
  String get editeClass {
    return Intl.message(
      'Edit Class Information',
      name: 'editeClass',
      desc: '',
      args: [],
    );
  }

  /// `Class has been updated`
  String get classEdited {
    return Intl.message(
      'Class has been updated',
      name: 'classEdited',
      desc: '',
      args: [],
    );
  }

  /// `Next: Edit Schedule`
  String get nextEditeSectionsDate {
    return Intl.message(
      'Next: Edit Schedule',
      name: 'nextEditeSectionsDate',
      desc: '',
      args: [],
    );
  }

  /// `Update Schedule`
  String get updateSchedule {
    return Intl.message(
      'Update Schedule',
      name: 'updateSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Update the basic information for the class.`
  String get updateClassHint {
    return Intl.message(
      'Update the basic information for the class.',
      name: 'updateClassHint',
      desc: '',
      args: [],
    );
  }

  /// `Make sure to review the classroom details and schedules before saving to avoid scheduling conflicts.`
  String get classHint {
    return Intl.message(
      'Make sure to review the classroom details and schedules before saving to avoid scheduling conflicts.',
      name: 'classHint',
      desc: '',
      args: [],
    );
  }

  /// `Oops!`
  String get error {
    return Intl.message('Oops!', name: 'error', desc: '', args: []);
  }

  /// `Would you like to create a new class?`
  String get addClassQus {
    return Intl.message(
      'Would you like to create a new class?',
      name: 'addClassQus',
      desc: '',
      args: [],
    );
  }

  /// `Add your classes and assign students with ease.`
  String get classInformation {
    return Intl.message(
      'Add your classes and assign students with ease.',
      name: 'classInformation',
      desc: '',
      args: [],
    );
  }

  /// `Add Class Now`
  String get addClassNow {
    return Intl.message(
      'Add Class Now',
      name: 'addClassNow',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Schedule`
  String get weekSchedule {
    return Intl.message(
      'Weekly Schedule',
      name: 'weekSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `First Term`
  String get firstTerm {
    return Intl.message('First Term', name: 'firstTerm', desc: '', args: []);
  }

  /// `Second Term`
  String get secondTerm {
    return Intl.message('Second Term', name: 'secondTerm', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Email is required`
  String get emailReq {
    return Intl.message(
      'Email is required',
      name: 'emailReq',
      desc: '',
      args: [],
    );
  }

  /// `Group name or code`
  String get codeOfGroup {
    return Intl.message(
      'Group name or code',
      name: 'codeOfGroup',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
