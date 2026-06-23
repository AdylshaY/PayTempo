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

  @override
  String get categoryStreaming => 'Akış';

  @override
  String get categoryMusic => 'Müzik';

  @override
  String get categoryVideo => 'Video';

  @override
  String get categoryCloud => 'Bulut';

  @override
  String get categoryAi => 'Yapay Zeka';

  @override
  String get categoryProductivity => 'Verimlilik';

  @override
  String get categoryGaming => 'Oyun';

  @override
  String get categoryNews => 'Haber';

  @override
  String get currencyTRY => 'Türk Lirası';

  @override
  String get currencyUSD => 'Amerikan Doları';

  @override
  String get currencyEUR => 'Euro';

  @override
  String get currencyGBP => 'İngiliz Sterlini';

  @override
  String get currencyJPY => 'Japon Yeni';

  @override
  String get currencyCNY => 'Çin Yuanı';

  @override
  String get currencyCAD => 'Kanada Doları';

  @override
  String get currencyAUD => 'Avustralya Doları';

  @override
  String get currencyCHF => 'İsviçre Frangı';

  @override
  String get presetServiceSettings => 'Hazır Servis Ayarları';

  @override
  String get newSubscription => 'Yeni Abonelik';

  @override
  String get avatarLabel => 'Profil Resmi';

  @override
  String get presetAvatarDesc =>
      'Bu, seçilen servise dayalı hazır bir profil resmidir.';

  @override
  String get tapToSelectAvatarDesc =>
      'Bir simge, emoji veya renk seçmek için dokunun.';

  @override
  String get categoryLabel => 'Kategori';

  @override
  String get priceLabel => 'Fiyat';

  @override
  String get priceHint => 'Örnek: 9.99';

  @override
  String get priceRequired => 'Fiyat alanı zorunludur.';

  @override
  String get currencyLabel => 'Para Birimi';

  @override
  String get monthlyLabel => 'Aylık';

  @override
  String get yearlyLabel => 'Yıllık';

  @override
  String get firstPaymentDateLabel => 'İlk Ödeme Tarihi';

  @override
  String get saveSubscriptionLabel => 'Aboneliği Kaydet';

  @override
  String get enterValidAmount => 'Lütfen geçerli bir tutar girin.';

  @override
  String get failedToSaveSubscription =>
      'Abonelik kaydedilemedi. Lütfen tekrar deneyin.';

  @override
  String get presetServicesTitle => 'Hazır Servisler';

  @override
  String get pickServiceSubtitle =>
      'Bir servis seçin. Fiyatı bir sonraki ekranda girebilirsiniz.';

  @override
  String get addManuallyLabel => 'Manuel Ekle';

  @override
  String get iconTabLabel => 'Simge';

  @override
  String get emojiTabLabel => 'Emoji';

  @override
  String get colorPaletteTitle => 'Renk Paleti';

  @override
  String get iconSelectionTitle => 'Simge Seçimi';

  @override
  String get selectEmojiTitle => 'Emoji Seçin';

  @override
  String get saveSelectionLabel => 'Seçimi Kaydet';

  @override
  String get changeCurrencyTitle => 'Para birimini değiştir';

  @override
  String get changeDisplayCurrencyTitle =>
      'Görüntüleme para birimi değiştirilsin mi?';

  @override
  String confirmChangeCurrencyContent(String newCurrency) {
    return 'Temel para biriminiz $newCurrency olarak değiştirilecek. Tüm geçmiş ödemeler, kaydedildikleri tarihteki geçmiş döviz kuru kullanılarak yeniden hesaplanacaktır.';
  }

  @override
  String get cancelButtonLabel => 'İptal';

  @override
  String get changeButtonLabel => 'Değiştir';

  @override
  String currencyChangedSuccess(String newCurrency, int count) {
    return 'Para birimi $newCurrency olarak değiştirildi. $count ödeme yeniden hesaplandı.';
  }

  @override
  String get failedToChangeCurrency =>
      'Para birimi değiştirilemedi. Lütfen tekrar deneyin.';

  @override
  String get baseCurrencyTitle => 'Ana Para Birimi';

  @override
  String get selectBaseCurrencyDesc =>
      'Lütfen ana para biriminizi seçin. Bu, uygulamadaki tüm hesaplamalar ve gösterimler için kullanılacaktır.';

  @override
  String get failedToSaveBaseCurrency =>
      'Ana para birimi kaydedilemedi. Lütfen tekrar deneyin.';

  @override
  String get selectBaseCurrencyHint => 'Ana para birimi seçin';

  @override
  String get warningBannerText =>
      'Uyarı: Bu seçim daha sonra değiştirilemez. Lütfen dikkatli seçin.';

  @override
  String get continueButtonLabel => 'Devam Et';

  @override
  String get filterPaymentsTitle => 'Ödemeleri Filtrele';

  @override
  String get fromDateLabel => 'Başlangıç Tarihi';

  @override
  String get toDateLabel => 'Bitiş Tarihi';

  @override
  String get clearLabel => 'Temizle';

  @override
  String get applyLabel => 'Uygula';

  @override
  String get markAsPaid => 'Ödendi olarak işaretle';

  @override
  String get markPaidSuccess =>
      'Bu abonelik bu ay için zaten ödendi olarak işaretlenmiş.';

  @override
  String get markPaidFailed => 'Ödeme kaydedilemedi. Lütfen tekrar deneyin.';

  @override
  String get paymentDateLabel => 'Ödeme Tarihi';

  @override
  String get amountLabel => 'Tutar';

  @override
  String get savePaymentLabel => 'Ödemeyi Kaydet';

  @override
  String get equivalentLabel => 'Karşılığı';

  @override
  String get billingCycleLabel => 'Ödeme Periyodu';

  @override
  String get nextPaymentLabel => 'Sonraki Ödeme';

  @override
  String get anchorDayLabel => 'Hesap Günü';

  @override
  String get alreadyPaidThisMonth => 'Bu ay için zaten bir ödeme kaydettiniz.';

  @override
  String get recentPaymentsTitle => 'Son Ödemeler';

  @override
  String countRecorded(int count) {
    return '$count kaydedildi';
  }

  @override
  String get weeklyLabel => 'Haftalık';

  @override
  String get quarterlyLabel => 'Üç Aylık';

  @override
  String get paymentsMadeTitle => 'Yapılan Ödemeler';

  @override
  String get noPaymentsRecordedThisMonth => 'Bu ay henüz ödeme kaydedilmedi.';

  @override
  String get paymentsCompletedDesc => 'Mevcut ay için tamamlanan ödemeler.';

  @override
  String get unknownSubscriptionLabel => 'Bilinmeyen Abonelik';

  @override
  String get upgradeToProTitle => 'Pro\'ya Yükselt';

  @override
  String get proBenefitsTitle => 'Pro Özellikleri';

  @override
  String get proBenefit1 => 'Yerel verileriniz için bulut yedekleme';

  @override
  String get proBenefit2 => 'Cihazlarınız arasında senkronizasyon';

  @override
  String get proBenefit3 => 'Telefon değiştirirken daha güvenli kurtarma';

  @override
  String get proOfflineDisclaimer =>
      'Mevcut uygulamanız tamamen çevrimdışı çalışmaya devam eder. Pro yalnızca isteğe bağlı senkronizasyon ve yedekleme ekler.';

  @override
  String get proUpgradeSoon => 'Pro satın alma akışı yakında sunulacaktır.';

  @override
  String get continueToProLabel => 'Pro\'ya Devam Et';

  @override
  String get analyticsScreenPlaceholder => 'Analiz Ekranı';

  @override
  String get thisMonth => 'Bu Ay';

  @override
  String get thisMonthSubtitle => 'Beklenen ve ödenmiş olanları görün.';

  @override
  String get proUnlockMessage =>
      'Harcama dağılımınızı ve aylık eğilimlerinizi görmek için Pro\'yu etkinleştirin.';

  @override
  String get proUnlockedSuccess => 'PayTempo Pro özellikleri açıldı!';

  @override
  String get spendingByCategory => 'Kategoriye Göre Harcama';

  @override
  String get monthlyTrends => 'Aylık Trendler';

  @override
  String get noDataForAnalytics => 'Bu ay için ödeme verisi bulunmamaktadır.';

  @override
  String get last6Months => 'Son 6 Ay';

  @override
  String get totalSpending => 'Toplam Harcama';

  @override
  String get billingCycleBreakdown => 'Faturalandırma Periyodu Analizi';

  @override
  String get monthlySubscriptions => 'Aylık Abonelikler';

  @override
  String get yearlySubscriptions => 'Yıllık Abonelikler';

  @override
  String get equivalentMonthlyTotal => 'Aylık Ortalama Tutar';

  @override
  String get equivalentYearlyTotal => 'Yıllık Ortalama Tutar';

  @override
  String get monthlyCycleLabel => 'Aylık';

  @override
  String get yearlyCycleLabel => 'Yıllık';

  @override
  String get potentialSavingsTitle => 'Tasarruf Fırsatlarını Yakala';

  @override
  String get potentialSavingsDesc =>
      'Aylık aboneliklerinizi yıllık ödemeye geçirerek yılda yaklaşık %20 tasarruf edebilirsiniz.';

  @override
  String get manageCategories => 'Özel Kategoriler';

  @override
  String get manageCategoriesSubtitle =>
      'Özel abonelik kategorileri ekleyin veya silin.';

  @override
  String get addCategory => 'Kategori Ekle';

  @override
  String get deleteCategory => 'Kategoriyi Sil';

  @override
  String get deleteCategoryConfirm =>
      'Bu kategoriyi silmek istediğinize emin misiniz? Bu kategoriyi kullanan abonelikler kategori ismini korur ancak varsayılan simgeye döner.';

  @override
  String get categoryNameLabel => 'Kategori Adı';

  @override
  String get categoryNameRequired => 'Kategori adı zorunludur.';

  @override
  String get categoryNameMinLength =>
      'Kategori adı en az 2 karakter olmalıdır.';

  @override
  String get categoryNameExists => 'Bu isimde bir kategori zaten mevcut.';

  @override
  String get addCategoryLabel => 'Özel Kategori Ekle';

  @override
  String get categoryIconLabel => 'Simge Seçin';

  @override
  String get categorySavedSuccess => 'Kategori başarıyla oluşturuldu.';

  @override
  String get failedToSaveCategory => 'Kategori oluşturulamadı.';

  @override
  String get categoryDeletedSuccess => 'Kategori silindi.';

  @override
  String get noCustomCategoriesYet =>
      'Henüz özel kategori eklenmedi. Eklemek için \'+\' simgesine dokunun.';

  @override
  String get searchTemplates => 'Servislerde ara...';

  @override
  String get allLabel => 'Tümü';

  @override
  String get notification1DayBeforeTitle => 'Yaklaşan Ödeme';

  @override
  String notification1DayBeforeBody(
    String name,
    String price,
    String currency,
  ) {
    return '$name aboneliğinizin ödemesi yarın yapılacak ($price $currency).';
  }

  @override
  String get notificationDueTodayTitle => 'Ödeme Günü';

  @override
  String notificationDueTodayBody(String name, String price, String currency) {
    return '$name aboneliğinizin ödemesi bugün yapılacak ($price $currency).';
  }

  @override
  String get notificationsLabel => 'Bildirimler';

  @override
  String get notificationsSubtitle =>
      'Yaklaşan ödemeler için hatırlatıcıları açın veya kapatın.';

  @override
  String get notificationsEnabledSubtitle =>
      'Bu abonelik için hatırlatıcılar planlandı.';

  @override
  String get notificationsDisabledSubtitle =>
      'Bu abonelik için hatırlatıcılar kapatıldı.';
}
