## Kullanıcı Listesi Uygulaması

Bu uygulama, kullanıcıların listelendiği, arama yapılabildiği ve kullanıcı detaylarının gösterildiği bir Flutter uygulamasıdır. Uygulamada HTTP istekleri için `http` kütüphanesi ve durum yönetimi için `cubit` paketi kullanılmıştır.

## Özellikler

- Kullanıcıları listeleyen ana ekran.
- Kullanıcıları adlarına göre aramaya yarayan search işlevi.
- Kullanıcı detaylarının gösterildiği pop up.
  
## Performans Optimizasyonu

-Search ,list ve detail özellikleri için performans sağlaması açısından sadece bir kere api isteği yapılmaktadır. O istek sonucunda iki adet aynı tip model emit edilmektedir. Bunun sebebi search işleminin ardından yapılan clear işlemi sonrası, verilerin apiye istek atılmadan çekilmesini sağlamaktır. Böylece, aynı verilere tekrar tekrar istek atılmadan hızlı bir şekilde kullanıcılar arasında gezinebilirsiniz. Bu sayede hem backendi yormamış oluruz hem de bekleme süresi oluşturmamış oluruz.

-Bellek ve diğer sistem kaynaklarının verimli bir şekilde kullanılmasını sağlamak için http kütüphanesi Singleton bir sınıf olarak oluşturuldu.
  
-Textler static const olarak kullanılmıştır. Bu sayede textler uygulama başlatıldığında bir kere oluşturulup bellekte tutulurlar , tekrar tekrar oluşturma maliyeti ortadan kalkar ve performans artar.
