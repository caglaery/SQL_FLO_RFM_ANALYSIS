/*
###############################################################
# RFM ile Müşteri Segmentasyonu (Customer Segmentation with RFM)
###############################################################

###############################################################
# Iş Problemi (Business Problem)
###############################################################
# Bir parakende şirketi müşterilerini segmentlere ayırıp bu segmentlere göre pazarlama stratejileri belirlemek istiyor.
# Buna yönelik olarak müşterilerin davranışlarını tanımlayacağız ve bu davranışlarda öbeklenmelere göre gruplar oluşturacağız.

###############################################################
# Veri Seti Hikayesi
###############################################################

# Veri seti son alışverişlerini 2020 - 2021 yıllarında OmniChannel(hem online hem offline) olarak yapan müşterilerin geçmiş alışveriş davranışlarından
# elde edilen bilgilerden oluşmaktadır.

# 20.000 gözlem, 13 değişken

# master_id: Eşsiz müşteri numarası
# order_channel : Alışveriş yapılan platforma ait hangi kanalın kullanıldığı (Android, ios, Desktop, Mobile, Offline)
# last_order_channel : En son alışverişin yapıldığı kanal
# first_order_date : Müşterinin yaptığı ilk alışveriş tarihi
# last_order_date : Müşterinin yaptığı son alışveriş tarihi
# last_order_date_online : Muşterinin online platformda yaptığı son alışveriş tarihi
# last_order_date_offline : Muşterinin offline platformda yaptığı son alışveriş tarihi
# order_num_total_ever_online : Müşterinin online platformda yaptığı toplam alışveriş sayısı
# order_num_total_ever_offline : Müşterinin offline'da yaptığı toplam alışveriş sayısı
# customer_value_total_ever_offline : Müşterinin offline alışverişlerinde ödediği toplam ücret
# customer_value_total_ever_online : Müşterinin online alışverişlerinde ödediği toplam ücret
# interested_in_categories_12 : Müşterinin son 12 ayda alışveriş yaptığı kategorilerin listesi
# store_type : 3 farklı companyi ifade eder. A company'sinden alışveriş yapan kişi B'dende yaptı ise A,B şeklinde yazılmıştır.

###############################################################
# GÖREVLER
###############################################################

# GÖREV 1: Veriyi Anlama (Data Understanding) ve Hazırlama
           # 1. Flo verisine SQL databaseden ulaşın.
           # 2. Veri setinde
                     # a. ılk 10 gözlem,
                     # b. Değişken isimleri,
                     # c. Boş değer,
                     # d. Değişken tipleri, incelemesi yapınız.
           # 3. Omnichannel müşterilerin hem online'dan hemde offline platformlardan alışveriş yaptığını ifade etmektedir. Herbir müşterinin toplam
           # alışveriş sayısı ve harcaması için yeni değişkenler oluşturun.
           # 4. Değişken tiplerini inceleyiniz.
           # 5. Alışveriş kanallarındaki müşteri sayısının, ortalama alınan ürün sayısının ve ortalama harcamaların dağılımına bakınız.
           # 6. En fazla kazancı getiren ilk 10 müşteriyi sıralayınız.
           # 7. En fazla siparişi veren ilk 10 müşteriyi sıralayınız.

# GÖREV 2: RFM Metriklerinin Hesaplanması

# GÖREV 3: RF ve RFM Skorlarının Hesaplanması

# GÖREV 4: RF Skorlarının Segment Olarak Tanımlanması

# GÖREV 5: Aksiyon zamanı!
           # 1. Segmentlerin recency, frequnecy ve monetary ortalamalarını inceleyiniz.
           # 2. RFM analizi yardımı ile 2 case için ilgili profildeki müşterileri bulunuz.
                   # a. FLO bünyesine yeni bir kadın ayakkabı markası dahil ediyor. Dahil ettiği markanın ürün fiyatları genel müşteri tercihlerinin üstünde. Bu nedenle markanın
                   # tanıtımı ve ürün satışları için ilgilenecek profildeki müşterilerle özel olarak iletişime geçeilmek isteniliyor. Sadık müşterilerinden(champions,loyal_customers),
                   # ortalama 250 TL üzeri ve kadın kategorisinden alışveriş yapan kişiler özel olarak iletişim kuralacak müşteriler. Bu müşterilerin id numaralarını getiriniz.

                   # b. Erkek ve Çoçuk ürünlerinde %40'a yakın indirim planlanmaktadır. Bu indirimle ilgili kategorilerle ilgilenen geçmişte iyi müşteri olan ama uzun süredir
                   # alışveriş yapmayan kaybedilmemesi gereken müşteriler, uykuda olanlar ve yeni gelen müşteriler özel olarak hedef alınmak isteniliyor. Uygun profildeki müşterilerin id'lerini getiriniz.
 */


/*
###############################################################
# GÖREV 1: Veriyi  Hazırlama ve Anlama (Data Understanding)
###############################################################
#Veri setinde;
        # a. ılk 10 gözlem,
        # b. Değişken isimleri,
        # c. Boyut,
        # d. Boş değer,
        # e. Değişken tipleri, incelemesi yapınız.

*/

-- GÖREV-1
 --a. ılk 10 gözlem,
SELECT TOP 10 *
FROM flodb.dbo.flo

 --B.Değişken isimleri,
SELECT COLUMN_NAME AS DEGISKEN_ISMI
FROM flodb.INFORMATION_SCHEMA.COLUMNS

 --c.Boyut,
SELECT COUNT(*) AS KOLON_SAYİSİ
FROM flodb.dbo.flo
SELECT COUNT(COLUMN_NAME) AS DEGİSKEN_SAYİSİ
FROM flodb.INFORMATION_SCHEMA.COLUMNS

--d. Boş değer,
SELECT * FROM flodb.dbo.flo WHERE master_id IS NULL
SELECT * FROM flodb.dbo.flo WHERE order_channel IS NULL
SELECT * FROM flodb.dbo.flo WHERE last_order_channel IS NULL
SELECT * FROM flodb.dbo.flo WHERE first_order_date IS NULL
SELECT * FROM flodb.dbo.flo WHERE last_order_date IS NULL
SELECT * FROM flodb.dbo.flo WHERE last_order_date_online IS NULL
SELECT * FROM flodb.dbo.flo WHERE last_order_date_offline IS NULL
SELECT * FROM flodb.dbo.flo WHERE order_num_total_ever_online IS NULL
SELECT * FROM flodb.dbo.flo WHERE order_num_total_ever_offline IS NULL
SELECT * FROM flodb.dbo.flo WHERE customer_value_total_ever_online IS NULL
SELECT * FROM flodb.dbo.flo WHERE customer_value_total_ever_offline IS NULL
SELECT * FROM flodb.dbo.flo WHERE interested_in_categories_12 IS NULL

-- e. Değişken tipleri, incelemesi yapınız.
SELECT COLUMN_NAME,DATA_TYPE FROM flodb.INFORMATION_SCHEMA.COLUMNS

-- f. Kısıtlı Databaseden, Playground da tablo olusturma
SELECT * FROM flodb.dbo.flo
SELECT * INTO flo_rfm
FROM flodb.dbo.flo

-- Herbir müşterinin toplam alışveriş sayısı ve harcaması için yeni değişkenler oluşturun.
ALTER TABLE flo_rfm ADD order_num_total AS (order_num_total_ever_online+ order_num_total_ever_offline);
SELECT * FROM flo_rfm

ALTER TABLE flo_rfm ADD customer_value_total_ever AS (customer_value_total_ever_online+customer_value_total_ever_offline)

-- Alışveriş kanallarındaki müşteri sayısının, ortalama alınan ürün sayısının ve ortalama harcamaların dağılımına bakınız.
SELECT order_channel AS siparis_kanali, COUNT(master_id) AS musteri_sayisi,
AVG(order_num_total) AS ort_urun_sayisi,
ROUND(AVG(customer_value_total_ever),3) AS harcanan_para
FROM flo_rfm
GROUP BY order_channel;

-- En fazla kazancı getiren ilk 10 müşteriyi sıralayınız.
SELECT TOP 10 master_id,customer_value_total_ever FROM flo_rfm  ORDER BY customer_value_total_ever DESC;

 --En fazla siparişi veren ilk 10 müşteriyi sıralayınız.
 SELECT TOP 10 master_id, order_num_total FROM flo_rfm ORDER BY order_num_total DESC

--# GÖREV 2: RFM Metriklerinin Hesaplanması [analysis_date = (2021,6,1)]
-- customer_id, recency, frequnecy ve monetary değerlerinin yer aldığı yeni bir rfm adında tablo oluşturunuz.
SELECT (master_id) as CustomerID,
DATEDIFF(DAY,last_order_date,'20210601') AS Recency,
(order_num_total) AS Frequency,
(customer_value_total_ever) AS Monetary,
NULL RECENCY_SCR,
NULL FREQUENCY_SCR
INTO flo_rfm_table
FROM flo_rfm

SELECT * FROM flo_rfm_table

--# GÖREV 3: RF ve RFM Skorlarının Hesaplanması (Calculating RF and RFM Scores)
--###############################################################
--#  Recency ve Frequency metriklerinin 1-5 arasında skorlara çevrilmesi ve
--# Bu skorları recency_score ve frequency_score olarak kaydedilmesi,

UPDATE flo_rfm_table SET RECENCY_SCR = r.RSCORE FROM flo_rfm_table
JOIN (
        SELECT CustomerID, NTILE(5) OVER (ORDER BY Recency DESC) AS RSCORE
        FROM flo_rfm_table) r ON r.CustomerID = flo_rfm_table.CustomerID ;


UPDATE flo_rfm_table SET FREQUENCY_SCR = f.FSCORE FROM flo_rfm_table
JOIN ( SELECT CustomerID, NTILE(5) OVER (ORDER BY Frequency ASC)AS FSCORE
FROM flo_rfm_table) f ON f.CustomerID=flo_rfm_table.CustomerID;
SELECT * FROM flo_rfm_table


-- # RECENCY_SCORE ve FREQUENCY_SCORE’u tek bir değişken olarak ifade edilmesi ve RF_SCORE olarak kaydedilmesi
ALTER TABLE flo_rfm_table ADD RF_SCORE AS CONVERT(VARCHAR,RECENCY_SCR)+CONVERT(VARCHAR,FREQUENCY_SCR)

/*
###############################################################
# GÖREV 4: RF Skorlarının Segment Olarak Tanımlanması
###############################################################
# Oluşturulan RFM skorların daha açıklanabilir olması için segment tanımlama ve RF_SCORE'u segmentlere çevirme
*/

--SEGMENT adında yeni bir kolon oluşturma
ALTER TABLE flo_rfm_table ADD RF_SEGMENT VARCHAR (50) 
--SEGMENTLERİ TANIMLAMA
UPDATE flo_rfm_table SET RF_SEGMENT = 'hibernating' WHERE RECENCY_SCR LIKE '[1-2]%' AND FREQUENCY_SCR LIKE'[1-2]%'
UPDATE flo_rfm_table SET RF_SEGMENT ='at_risk' WHERE RECENCY_SCR LIKE'[1-2]%' AND FREQUENCY_SCR LIKE '[3-4]%'
UPDATE flo_rfm_table SET RF_SEGMENT ='cant_loose' WHERE RECENCY_SCR LIKE '[1-2]%' AND FREQUENCY_SCR LIKE '[5]%'
UPDATE flo_rfm_table SET RF_SEGMENT ='about_to_sleep' WHERE RECENCY_SCR LIKE '[3]%' AND FREQUENCY_SCR LIKE '[1-2]%'
UPDATE flo_rfm_table SET RF_SEGMENT ='need_attention' WHERE RECENCY_SCR LIKE '[3]%' AND FREQUENCY_SCR LIKE '[3]%'
UPDATE flo_rfm_table SET RF_SEGMENT ='loyal_customers' WHERE RECENCY_SCR LIKE '[3-4]%' AND FREQUENCY_SCR LIKE '[4-5]%'
UPDATE flo_rfm_table SET RF_SEGMENT ='promising' WHERE RECENCY_SCR LIKE '[4]%' AND FREQUENCY_SCR LIKE '[1]%'
UPDATE flo_rfm_table SET RF_SEGMENT ='new_customers' WHERE RECENCY_SCR LIKE '[5]%' AND FREQUENCY_SCR LIKE '[1]%'
UPDATE flo_rfm_table SET RF_SEGMENT ='potential_loyalists' WHERE RECENCY_SCR LIKE '[4-5]%' AND FREQUENCY_SCR LIKE '[2-3]%'
UPDATE flo_rfm_table SET RF_SEGMENT ='champions' WHERE RECENCY_SCR LIKE '[5]%' AND FREQUENCY_SCR LIKE '[4-5]%'

SELECT * FROM  flo_rfm_table

/* # GÖREV 5: Aksiyon zamanı!
###############################################################
# 1. Segmentlerin recency, frequnecy ve monetary ortalamalarını inceleyiniz.
*/
SELECT RF_SEGMENT, 
COUNT(RECENCY) AS count_recency,
AVG(RECENCY) AS avg_recency,
COUNT(FREQUENCY) AS count_frequency,
ROUND(AVG(FREQUENCY),3) AS avg_frequency,
COUNT(MONETARY) AS count_monetary,
ROUND(AVG(MONETARY),3) as avg_monetary 
FROM flo_rfm_table
GROUP BY RF_SEGMENT;
/*
# 2. RFM analizi yardımı ile 2 case için ilgili profildeki müşterileri bulunuz.

# a. FLO bünyesine yeni bir kadın ayakkabı markası dahil ediyor. Dahil ettiği markanın ürün fiyatları genel müşteri tercihlerinin üstünde. Bu nedenle markanın
# tanıtımı ve ürün satışları için ilgilenecek profildeki müşterilerle özel olarak iletişime geçilmek isteniliyor. Bu müşterilerin sadık, ortalama 250 TL üzeri ve
# kadın kategorisinden alışveriş yapan kişiler olması planlandı. Müşterilerin id numaralarını getiriniz.
*/ 

SELECT DISTINCT(CustomerID), d.interested_in_categories_12
FROM flo_rfm_table f JOIN dbo.flo_rfm d  ON f.CustomerID=d.master_id
WHERE (customer_value_total_ever/order_num_total_ever_offline) > 250 
AND  f.RF_SEGMENT IN ('champions','loyal_customers')
AND d.interested_in_categories_12 LIKE '%KADIN%';


/*
# b. Erkek ve Çoçuk ürünlerinde %40'a yakın indirim planlanmaktadır. Bu indirimle ilgili kategorilerle ilgilenen geçmişte iyi müşterilerden olan ama uzun süredir
# alışveriş yapmayan ve yeni gelen müşteriler özel olarak hedef alınmak isteniliyor. Uygun profildeki müşterilerin id'lerini getiriniz.CANT LOOSE,HİBERNATİNG , NEW CUSTOMER

*/

SELECT CustomerID,d.interested_in_categories_12
FROM flo_rfm_table f JOIN flo_rfm d ON f.CustomerID=d.master_id
WHERE f.RF_SEGMENT IN ('cant_loose','hibernating','new_customers')
AND d.interested_in_categories_12 LIKE '%ERKEK%' OR d.interested_in_categories_12 LIKE '%COCUK%'





