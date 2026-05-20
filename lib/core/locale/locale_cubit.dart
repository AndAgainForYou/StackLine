import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local_storage_service.dart';
import 'app_locale.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(this._storage) : super(AppLocale.english.locale);

  final LocalStorageService _storage;

  void load() {
    final savedId = _storage.getLocaleId();
    if (savedId != null) {
      emit(AppLocale.fromId(savedId).locale);
      return;
    }

    final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
    emit(AppLocale.resolve(deviceLocale).locale);
  }

  Future<void> setLocale(AppLocale appLocale) async {
    emit(appLocale.locale);
    await _storage.saveLocaleId(appLocale.id);
  }
}
