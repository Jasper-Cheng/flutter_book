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

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `sure`
  String get sure {
    return Intl.message(
      'sure',
      name: 'sure',
      desc: '',
      args: [],
    );
  }

  /// `date`
  String get date {
    return Intl.message(
      'date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `time`
  String get time {
    return Intl.message(
      'time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `delete`
  String get delete {
    return Intl.message(
      'delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `birthday`
  String get birthday {
    return Intl.message(
      'birthday',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `appointment`
  String get appointment {
    return Intl.message(
      'appointment',
      name: 'appointment',
      desc: '',
      args: [],
    );
  }

  /// `contact`
  String get contact {
    return Intl.message(
      'contact',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `note`
  String get note {
    return Intl.message(
      'note',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `task`
  String get task {
    return Intl.message(
      'task',
      name: 'task',
      desc: '',
      args: [],
    );
  }

  /// `delete appointment`
  String get appointment_list_alert_title {
    return Intl.message(
      'delete appointment',
      name: 'appointment_list_alert_title',
      desc: '',
      args: [],
    );
  }

  /// `are you sure to delete `
  String get appointment_list_alert_content_part1 {
    return Intl.message(
      'are you sure to delete ',
      name: 'appointment_list_alert_content_part1',
      desc: '',
      args: [],
    );
  }

  /// ` ?`
  String get appointment_list_alert_content_part2 {
    return Intl.message(
      ' ?',
      name: 'appointment_list_alert_content_part2',
      desc: '',
      args: [],
    );
  }

  /// `deleted appointment`
  String get appointment_list_alert_action_scaffold_content {
    return Intl.message(
      'deleted appointment',
      name: 'appointment_list_alert_action_scaffold_content',
      desc: '',
      args: [],
    );
  }

  /// `saved appointment`
  String get appointment_entry_save_scaffold_text {
    return Intl.message(
      'saved appointment',
      name: 'appointment_entry_save_scaffold_text',
      desc: '',
      args: [],
    );
  }

  /// `title`
  String get appointment_entry_list_title_hint_text {
    return Intl.message(
      'title',
      name: 'appointment_entry_list_title_hint_text',
      desc: '',
      args: [],
    );
  }

  /// `please enter title`
  String get appointment_entry_list_title_validator {
    return Intl.message(
      'please enter title',
      name: 'appointment_entry_list_title_validator',
      desc: '',
      args: [],
    );
  }

  /// `description`
  String get appointment_entry_list_description_hint_text {
    return Intl.message(
      'description',
      name: 'appointment_entry_list_description_hint_text',
      desc: '',
      args: [],
    );
  }

  /// `please enter description`
  String get appointment_entry_list_description_validator {
    return Intl.message(
      'please enter description',
      name: 'appointment_entry_list_description_validator',
      desc: '',
      args: [],
    );
  }

  /// `delete contact`
  String get contact_list_alert_title {
    return Intl.message(
      'delete contact',
      name: 'contact_list_alert_title',
      desc: '',
      args: [],
    );
  }

  /// `are you sure to delete `
  String get contact_list_alert_content_part1 {
    return Intl.message(
      'are you sure to delete ',
      name: 'contact_list_alert_content_part1',
      desc: '',
      args: [],
    );
  }

  /// ` ?`
  String get contact_list_alert_content_part2 {
    return Intl.message(
      ' ?',
      name: 'contact_list_alert_content_part2',
      desc: '',
      args: [],
    );
  }

  /// `deleted contact`
  String get contact_list_alert_action_scaffold_content {
    return Intl.message(
      'deleted contact',
      name: 'contact_list_alert_action_scaffold_content',
      desc: '',
      args: [],
    );
  }

  /// `saved contact`
  String get contact_entry_save_scaffold_text {
    return Intl.message(
      'saved contact',
      name: 'contact_entry_save_scaffold_text',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get contact_entry_list_name_hint_text {
    return Intl.message(
      'name',
      name: 'contact_entry_list_name_hint_text',
      desc: '',
      args: [],
    );
  }

  /// `please enter name`
  String get contact_entry_list_name_validator {
    return Intl.message(
      'please enter name',
      name: 'contact_entry_list_name_validator',
      desc: '',
      args: [],
    );
  }

  /// `phone`
  String get contact_entry_list_phone_hint_text {
    return Intl.message(
      'phone',
      name: 'contact_entry_list_phone_hint_text',
      desc: '',
      args: [],
    );
  }

  /// `please enter phone`
  String get contact_entry_list_phone_validator {
    return Intl.message(
      'please enter phone',
      name: 'contact_entry_list_phone_validator',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get contact_entry_list_email_hint_text {
    return Intl.message(
      'email',
      name: 'contact_entry_list_email_hint_text',
      desc: '',
      args: [],
    );
  }

  /// `please enter email`
  String get contact_entry_list_email_validator {
    return Intl.message(
      'please enter email',
      name: 'contact_entry_list_email_validator',
      desc: '',
      args: [],
    );
  }

  /// `take a picture`
  String get contact_entry_alert_library {
    return Intl.message(
      'take a picture',
      name: 'contact_entry_alert_library',
      desc: '',
      args: [],
    );
  }

  /// `take from gallery`
  String get contact_entry_alert_gallery {
    return Intl.message(
      'take from gallery',
      name: 'contact_entry_alert_gallery',
      desc: '',
      args: [],
    );
  }

  /// `delete note`
  String get note_list_alert_title {
    return Intl.message(
      'delete note',
      name: 'note_list_alert_title',
      desc: '',
      args: [],
    );
  }

  /// `are you sure to delete `
  String get note_list_alert_content_part1 {
    return Intl.message(
      'are you sure to delete ',
      name: 'note_list_alert_content_part1',
      desc: '',
      args: [],
    );
  }

  /// ` ?`
  String get note_list_alert_content_part2 {
    return Intl.message(
      ' ?',
      name: 'note_list_alert_content_part2',
      desc: '',
      args: [],
    );
  }

  /// `deleted note`
  String get note_list_alert_action_scaffold_content {
    return Intl.message(
      'deleted note',
      name: 'note_list_alert_action_scaffold_content',
      desc: '',
      args: [],
    );
  }

  /// `title`
  String get note_entry_list_title_hint_text {
    return Intl.message(
      'title',
      name: 'note_entry_list_title_hint_text',
      desc: '',
      args: [],
    );
  }

  /// `please enter title`
  String get note_entry_list_title_validator {
    return Intl.message(
      'please enter title',
      name: 'note_entry_list_title_validator',
      desc: '',
      args: [],
    );
  }

  /// `content`
  String get note_entry_list_content_hint_text {
    return Intl.message(
      'content',
      name: 'note_entry_list_content_hint_text',
      desc: '',
      args: [],
    );
  }

  /// `please enter content`
  String get note_entry_list_content_validator {
    return Intl.message(
      'please enter content',
      name: 'note_entry_list_content_validator',
      desc: '',
      args: [],
    );
  }

  /// `saved appointment`
  String get note_entry_save_scaffold_text {
    return Intl.message(
      'saved appointment',
      name: 'note_entry_save_scaffold_text',
      desc: '',
      args: [],
    );
  }

  /// `delete task`
  String get task_list_alert_title {
    return Intl.message(
      'delete task',
      name: 'task_list_alert_title',
      desc: '',
      args: [],
    );
  }

  /// `are you sure to delete`
  String get task_list_alert_content_part1 {
    return Intl.message(
      'are you sure to delete',
      name: 'task_list_alert_content_part1',
      desc: '',
      args: [],
    );
  }

  /// ` ?`
  String get task_list_alert_content_part2 {
    return Intl.message(
      ' ?',
      name: 'task_list_alert_content_part2',
      desc: '',
      args: [],
    );
  }

  /// `deleted task`
  String get task_list_alert_action_scaffold_content {
    return Intl.message(
      'deleted task',
      name: 'task_list_alert_action_scaffold_content',
      desc: '',
      args: [],
    );
  }

  /// `describe`
  String get task_entry_list_description_hint_text {
    return Intl.message(
      'describe',
      name: 'task_entry_list_description_hint_text',
      desc: '',
      args: [],
    );
  }

  /// `please enter describe`
  String get task_entry_list_description_validator {
    return Intl.message(
      'please enter describe',
      name: 'task_entry_list_description_validator',
      desc: '',
      args: [],
    );
  }

  /// `saved task`
  String get task_entry_save_scaffold_text {
    return Intl.message(
      'saved task',
      name: 'task_entry_save_scaffold_text',
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
      Locale.fromSubtags(languageCode: 'zh'),
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
