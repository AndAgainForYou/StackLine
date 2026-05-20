import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local_storage_service.dart';
import 'app_theme_variant.dart';

class ThemeCubit extends Cubit<AppThemeVariant> {
  ThemeCubit(this._storage) : super(AppThemeVariant.dark);

  final LocalStorageService _storage;

  void load() {
    emit(_storage.getThemeVariant());
  }

  Future<void> setVariant(AppThemeVariant variant) async {
    emit(variant);
    await _storage.saveThemeVariant(variant.id);
  }
}
