import '../../../../core/constants/strings.dart';
import '../../../../core/helpers/storage_helper.dart';

abstract class SettingsLocalDataSource {
 int? loadThemeIndex();

  Future<bool> saveThemeIndex(int themeIndex);

}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final StorageHelper storage;

  SettingsLocalDataSourceImpl({required this.storage});

  @override
  int? loadThemeIndex() {
    final themeIndex = storage.getInt(themeModeKey);
    return themeIndex;
  }

  @override
  Future<bool> saveThemeIndex(int themeIndex) {
    return storage.setInt(themeModeKey, themeIndex);
  }
}
