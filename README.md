# 🧠 SQL ile RFM Müşteri Segmentasyonu

Bu projede, bir perakende şirketinin müşteri verileri üzerinde **RFM (Recency, Frequency, Monetary)** analizi uygulanarak müşterilerin segmentlere ayrılması ve bu segmentlere özel pazarlama stratejilerinin geliştirilmesi amaçlanmıştır.

## 📌 İş Problemi

Şirket, hem online hem de offline alışveriş yapan müşterilerini daha yakından tanıyarak:
- En değerli ve sadık müşterileri belirlemek,
- Uzun süredir alışveriş yapmayan müşterileri geri kazanmak,
- Segmentlere özel kampanyalarla gelir artışı sağlamak istemektedir.

## 📊 Veri Seti Özeti

- **Zaman Aralığı:** 2020–2021  
- **Gözlem Sayısı:** 20.000  
- **Değişken Sayısı:** 13  
- **Kaynak:** Şirketin SQL veritabanı  

| Kolon Adı | Açıklama |
|-----------|----------|
| `master_id` | Eşsiz müşteri numarası |
| `order_channel` | Alışveriş yapılan kanal (Android, iOS, Desktop, Offline vb.) |
| `first_order_date` / `last_order_date` | İlk ve son alışveriş tarihleri |
| `order_num_total_ever_online` / `offline` | Kanal bazlı toplam sipariş sayısı |
| `customer_value_total_ever_online` / `offline` | Kanal bazlı toplam harcama |
| `interested_in_categories_12` | Son 12 ayda ilgi gösterilen kategoriler |

## ⚙️ Proje Aşamaları

### 1. Veri Anlama ve Hazırlama
- İlk 10 gözlem, eksik değer ve veri tipi kontrolleri yapıldı
- Toplam sipariş ve toplam harcama sütunları oluşturuldu
- Kanal bazlı kullanıcı davranışları analiz edildi

### 2. RFM Metriklerinin Hesaplanması
- **Recency:** Son alışverişten bu yana geçen gün sayısı (01.06.2021 baz alınarak)
- **Frequency:** Toplam sipariş sayısı
- **Monetary:** Toplam harcama tutarı

### 3. Skorlandırma ve Segmentasyon
- Her bir metriğe 1–5 arasında skor atandı (`NTILE` yöntemi ile)
- Recency ve Frequency skorları birleştirilerek `RF_SCORE` oluşturuldu
- RF skorlarına göre 10 farklı segment tanımlandı

### 4. Segmentler

| Segment | Tanım |
|---------|-------|
| `champions` | Son zamanlarda sık alışveriş yapanlar |
| `loyal_customers` | Düzenli alışveriş yapan sadık müşteriler |
| `new_customers` | Yeni gelen fakat henüz aktif olmayanlar |
| `hibernating` | Uzun süredir alışveriş yapmayanlar |
| `cant_loose` | Eskiden değerli olup şimdi pasifleşenler |
| ... | ... |

### 5. Pazarlama İçin Aksiyon Planı

#### Senaryo A – Yeni Kadın Ayakkabı Markası
- Segment: `champions`, `loyal_customers`
- Ortalama harcaması 250 TL üzeri olan,
- Kadın kategorisine ilgi duyan müşteriler hedeflenmiştir.

#### Senaryo B – Erkek & Çocuk Ürünlerinde İndirim
- Segment: `cant_loose`, `hibernating`, `new_customers`
- Erkek ve çocuk kategorisiyle ilgilenen, ancak uzun süredir alışveriş yapmamış veya yeni gelen müşteriler hedeflenmiştir.

## 🛠 Kullanılan Teknolojiler

- SQL (Transact-SQL)
- Microsoft SQL Server / Playground ortamı

## 📁 Dosya

- `RFM SEGMENTATION.sql`: Projenin tüm SQL sorgularını içeren dosyadır.
