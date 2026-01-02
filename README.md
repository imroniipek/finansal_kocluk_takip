# 📱 Cüzdanım360
## Kişisel Finans Yönetimi için Modern Flutter Uygulaması

**Cüzdanım360**, bireylerin günlük finansal hareketlerini sistematik ve anlaşılır bir şekilde takip edebilmeleri amacıyla geliştirilmiş, **Flutter tabanlı** bir kişisel finans yönetim uygulamasıdır.

Uygulama; **BLoC mimarisi ile state management**, **SQLite destekli kalıcı veri saklama**, **animasyonlu ve responsive kullanıcı arayüzü** ve **Clean Architecture yaklaşımı** ile profesyonel ölçekte bir mobil uygulama yapısını hedeflemektedir.

---

## 🎯 Projenin Amacı

Bu projenin temel amacı:

- Kullanıcıların gelir ve giderlerini **kategori bazlı** ve **periyodik** olarak takip edebilmesini sağlamak  
- Flutter ekosisteminde **ölçeklenebilir mimari** ve **temiz kod prensipleri** uygulamak  
- Gerçek hayatta kullanılabilecek bir finans uygulaması senaryosu oluşturmak  
- BLoC pattern ile sürdürülebilir ve test edilebilir bir yapı kurmak  

---

## ✨ Temel Özellikler

### 💰 Gelir & Gider Yönetimi
- Özel tasarlanmış, kullanıcı dostu **hesap makinesi arayüzü**
- Gelir ve giderler için ayrı akışlar
- Kategori bazlı işlem ekleme:
  - Gıda
  - Maaş
  - Sağlık
  - Ulaşım
  - Araç
  - Diğer
- İşlem açıklaması / not ekleyebilme
- Günlük, aylık ve yıllık periyot seçimi

---

### 🗄️ SQLite ile Kalıcı Veri Saklama
- `sqflite` paketi ile local database yönetimi
- Autoincrement ID yapısı
- CRUD operasyonları (Create, Read, Update, Delete)
- Toplam bakiye hesaplama
- Kategori ve tarih bazlı veri filtreleme
- Offline çalışabilme desteği

---

### 🎨 Modern ve Animasyonlu Kullanıcı Arayüzü
- `AnimatedContainer` ile yumuşak geçiş animasyonları
- `ExpansionTile` ile açılır gelir/gider kartları
- Kategori bazlı ikon ve renk kullanımı
- Responsive tasarım (farklı ekran boyutları için uyumlu)
- Material Design prensiplerine uygun UI/UX

---

### 🧠 BLoC Tabanlı State Management
- `flutter_bloc` kullanılarak yapılandırılmış mimari
- Event – State ayrımı
- Sayfa durumlarının merkezi olarak yönetilmesi:
  - `idle`
  - `loading`
  - `success`
  - `error`
- UI ile business logic’in net ayrımı

---

## 🏗️ Mimari Yapı

Proje **Clean Architecture** yaklaşımına uygun olarak modüler şekilde yapılandırılmıştır:


