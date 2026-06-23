// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'PayTempo';

  @override
  String get settings => 'Ayarlar';

  @override
  String get settingsSubtitle =>
      'Profilinizi ve uygulama ayarlarınızı yönetin.';

  @override
  String get yourCurrency => 'Para Biriminiz';

  @override
  String get yourCurrencySubtitle =>
      'Toplamlar ve raporlar için seçilen para birimi.';

  @override
  String get appearance => 'Görünüm';

  @override
  String get appearanceSubtitle => 'Uygulama temanızı özelleştirin.';

  @override
  String get language => 'Dil';

  @override
  String get languageSubtitle => 'Tercih ettiğiniz dili seçin.';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeDark => 'Koyu';

  @override
  String get languageSystem => 'Sistem Varsayılanı';

  @override
  String get guestStatusTitle =>
      'Tüm verileriniz yalnızca bu cihazda saklanır. Verilerinizi buluta yedeklemek için Pro\'ya yükseltin.';

  @override
  String get tryPro => 'PayTempo Pro\'yu Dene';

  @override
  String get proFeature1 =>
      'Bulut yedekleme — cihaz değiştirirken bile güvende';

  @override
  String get proFeature2 =>
      'Gelişmiş analitikler — kategori ve trend grafikleri';

  @override
  String get proFeature3 => 'Özel kategoriler ve öncelikli destek';

  @override
  String get viewProPlans => 'Pro Planları İncele';

  @override
  String get proActiveTitle => 'PayTempo Pro';

  @override
  String get proActiveActiveBadge => 'Aktif';

  @override
  String get proActiveExpires => 'Bitiş / Yenilenme';

  @override
  String get proActivePlan => 'Plan';

  @override
  String get manageSubscription => 'Aboneliği Yönet (App Store / Play Store)';

  @override
  String get proFeatureCloudSync => 'Bulut Senkronizasyonu Aktif';

  @override
  String get proExpiredTitle => 'PayTempo Pro Süresi Doldu';

  @override
  String get proExpiredSubtitle =>
      'Verileriniz korunuyor, ancak bulut senkronizasyonu ve gelişmiş analitikler geçici olarak devre dışı bırakıldı.';

  @override
  String get expiredLabel => 'Süresi Dolan: ';

  @override
  String get renewPro => 'PayTempo Pro\'yu Yenile';

  @override
  String get noAccountCreated => 'Hesap oluşturulmadı';

  @override
  String get payments => 'Ödemeler';

  @override
  String get paymentsFailedToLoad => 'Ödemeler yüklenemedi.';

  @override
  String paymentsCount(int count) {
    return '$count ödeme';
  }

  @override
  String get noPaymentsForMonth => 'Bu ay için kaydedilmiş ödeme yok.';

  @override
  String get searchSubscription => 'Abonelik ismine göre ara';

  @override
  String get showingLast3Months => 'Son 3 ay gösteriliyor';

  @override
  String get showingFilteredRange => 'Filtrelenmiş tarih aralığı gösteriliyor';

  @override
  String get clearFilters => 'Filtreleri temizle';

  @override
  String get anyTime => 'Tüm zamanlar';

  @override
  String get noPaymentsMatchFilter =>
      'Mevcut filtrelere uyan ödeme bulunamadı.';

  @override
  String get noPaymentsRecordedYet => 'Henüz ödeme kaydedilmedi.';

  @override
  String get recordedLabel => 'Kaydedildi';

  @override
  String get dashboard => 'Panel';

  @override
  String get subscriptions => 'Abonelikler';

  @override
  String get profile => 'Profil';

  @override
  String get anonymousLocalData => 'Anonim · Yerel Veri';

  @override
  String get proPlanActive => 'Pro Plan · Aktif';

  @override
  String get proExpiredBadge => 'Pro Süresi Doldu';

  @override
  String get guestUser => 'Misafir Kullanıcı';

  @override
  String get user => 'Kullanıcı';

  @override
  String get analytics => 'Analitikler';

  @override
  String get paidThisMonth => 'Bu ay ödenen';

  @override
  String remainingFromActive(String amount, String currency) {
    return 'Kalan: Aktif aboneliklerden $amount $currency';
  }

  @override
  String get activeSubscriptionsFailed => 'Aktif abonelikler yüklenemedi.';

  @override
  String get activeSubscriptions => 'Aktif abonelikler';

  @override
  String get noActiveSubscriptions => 'Henüz aktif abonelik yok.';

  @override
  String totalItems(int count) {
    return 'Toplam $count';
  }

  @override
  String get paidLabel => 'Ödendi';

  @override
  String get alreadyRecordedThisMonth =>
      'Bu ay için zaten bir ödeme kaydettiniz.';

  @override
  String get overdue => 'Gecikmiş';

  @override
  String get dueToday => 'Bugün ödenecek';

  @override
  String get dueSoon => 'Yakında ödenecek';

  @override
  String get scheduled => 'Planlanmış';

  @override
  String dueSubtitle(String price, String currency, String date) {
    return '$price $currency • Son gün $date';
  }

  @override
  String get subscriptionNameLabel => 'Abonelik Adı';

  @override
  String get subscriptionNameHint => 'Örnek: Netflix';

  @override
  String get subscriptionNameRequired => 'Abonelik adı zorunludur.';

  @override
  String get subscriptionNameMinLength => 'Lütfen en az 2 karakter girin.';

  @override
  String get noteLabel => 'Açıklama / Not (İsteğe bağlı)';

  @override
  String get noteHint => 'Örnek: Eşimin hattı, kişisel hesap';
}
