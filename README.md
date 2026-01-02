# 📱 Cüzdanım360
## Kişisel Finans Yönetim Uygulaması

Cüzdanım360, kullanıcıların kişisel gelir ve giderlerini etkin bir şekilde yönetebilmeleri için geliştirilmiş modern bir **Flutter** mobil uygulamasıdır.

Uygulama; **BLoC tabanlı state management**, **SQLite ile kalıcı veri saklama**, **animasyonlu kullanıcı arayüzü** ve **modüler mimari yaklaşımı** ile profesyonel bir finans takip çözümü sunar.

---

## ✨ Özellikler

### 💰 Gelir & Gider Yönetimi
- Özel tasarlanmış hesap makinesi arayüzü  
- Kategori bazlı işlem ekleme *(Gıda, Maaş, Sağlık, Ulaşım, Araç vb.)*  
- İşlem notu ekleyebilme  
- Günlük, aylık ve yıllık periyotlara göre kayıt oluşturma  

---

### 🗄️ SQLite ile Kalıcı Veri Saklama
- Gelir ve giderlerin local database’de saklanması  
- Autoincrement ID yapısı  
- CRUD operasyonları  
- Veritabanı üzerinden toplam bakiye ve kategori bazlı hesaplama  

---

### 🎨 Modern & Animasyonlu Kullanıcı Arayüzü
- `AnimatedContainer` ile akıcı geçişler  
- `ExpansionTile` ile açılır gelir / gider kartları  
- Kategori ikonları ve renkli göstergeler  
- Responsive ve dark mode uyumlu tasarım  

---

### 🧠 BLoC Mimarisi
- Tüm state yönetimi **flutter_bloc** kullanılarak yapılandırılmıştır  
- Event – State ayrımı  
- Sayfa durumları:
  - `idle`
  - `loading`
  - `success`
  - `error`

---

## 🛠️ Kullanılan Teknolojiler

| Teknoloji | Açıklama |
|----------|----------|
| Flutter | Mobil UI geliştirme |
| Dart | Programlama dili |
| BLoC | State management |
| SQLite | Local veritabanı |
| Sqflite | SQLite Flutter paketi |
| Google Fonts | Tipografi |
| Clean Architecture | Modüler yapı |

---

## 📱 Uygulama Ekran Görüntüleri

> `assets/screenshots/` klasörü altına ekran görüntülerini ekleyebilirsiniz.

| Ana Sayfa | Gelir Ekle | Gider Ekle |
|----------|-----------|------------|
| ![](assets/screenshots/home.png) | ![](assets/screenshots/add_income.png) | ![](assets/screenshots/add_expense.png) |

| İstatistikler |
|--------------|
| ![](assets/screenshots/stats.png) |

---

## 🚀 Proje Amacı

Bu proje aşağıdaki hedefler doğrultusunda geliştirilmiştir:

- Flutter’da **profesyonel mimari** kullanımı  
- BLoC pattern ile ölçeklenebilir state yönetimi  
- Gerçek hayata uygun finans senaryoları  
- Temiz, sürdürülebilir ve okunabilir kod yapısı  

---

## 👤 Geliştirici

**Roni İpek**  
Flutter Developer

---

## ⭐ Not

Bu proje aktif olarak geliştirilmektedir.  
Geri bildirimler ve katkılar memnuniyetle karşılanır.
