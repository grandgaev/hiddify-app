import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hiddify/core/model/environment.dart';

part 'app_info_entity.freezed.dart';

@freezed
class AppInfoEntity with _$AppInfoEntity {
  const AppInfoEntity._();

  const factory AppInfoEntity({
    required String name,
    required String version,
    required String buildNumber,
    required Release release,
    required String operatingSystem,
    required String operatingSystemVersion,
    required Environment environment,
  }) = _AppInfoEntity;

  // RedHead-fork UA: контрол-сервер фильтрует подписку по токену `redhead`
  // в UA (см. vpn-control/main.py:_ALLOWED_SUB_UA_TOKENS). Если изменить
  // префикс — обнови whitelist там же, иначе клиент получит 404 на /sub.
  // Сохраняем хвост `like HiddifyNext ...` чтобы heuristic-based парсеры
  // (на стороне некоторых subscription-агрегаторов) распознавали клиента
  // как VLESS/Reality-совместимый.
  String get userAgent => "RedHeadClient/$version ($operatingSystem) like HiddifyNext ClashMeta v2ray sing-box";

  String get presentVersion => environment == Environment.prod ? version : "$version ${environment.name}";

  /// formats app info for sharing
  String format() =>
      '''
$name v$version ($buildNumber) [${environment.name}]
${release.name} release
$operatingSystem [$operatingSystemVersion]''';
}
