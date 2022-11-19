const List<Map<String, dynamic>> versions = [
  {
    'id': '1',
    'versions': [
      {
        'version': '0.4.3',
        'date': '2022-11-07',
        'changes': [],
        'fixed bugs': [
          'Daha fazla hata düzeltmeleri xd.',
        ],
      },
      {
        'version': '0.4.2',
        'date': '2022-11-01',
        'changes': [],
        'fixed bugs': [
          'Genel hata düzeltmeleri.',
        ],
      },
      {
        'version': '0.4.1-Release',
        'date': '2022-10-31',
        'changes': [
          'Arama ekranında yemek tariflerini malzeme listesine göre sıralama özelliği getirildi.',
          'Giriş ve hesap oluşturma ekranlarına yeniden tasarlandı.',
        ],
        'fixed bugs': [],
      },
      {
        'version': '0.4.0-OpenTest1',
        'date': '2022-10-29',
        'changes': [
          'Yemek tarifi yükleme ekranı yenilendi.',
          'Artık malzeme eklerken malzeme adı, miktarı ve ölçü birimini girmeniz gereklili.',
          'Ayrıca yemeğin hazırlanış adımlarını süreleriyle beraber ekleme özelliği eklendi.\nUygulama bütün adımların sürelerini toplayıp hazırlama süresini hesaplayacak.',
        ],
        'fixed bugs': [],
      },
      {
        'version': '0.3.2',
        'date': '2022-08-31',
        'changes': [
          'Yemek incelemeleri silme ve onaylama özellikleri yenilendi.',
          'Uygulamanın teması değiştirildi.'
        ],
        'fixed bugs': [
          'Başka kullanıcının profil ekranında takip ettiği kişileri görme özelliği düzeltildi.',
          'Flutter 3.3 yükseltmesi yapıldı bazı takılmaları çözmesini umuyorum.'
        ],
      },
      {
        'version': '0.3.1',
        'date': '2022-08-30',
        'changes': [
          'Uygulama içi reklam sistemi yenilendi.',
        ],
        'fixed bugs': [],
      },
      {
        'version': '0.3.0-Release',
        'date': '2022-08-29',
        'changes': [
          'Kullanıcı bilgileri düzenleme ekranına profil fotoğrafı ekleme özelliği getirildi.',
          'Kullanıcı şifresi sıfırlama özelliği eklendi.'
        ],
        'fixed bugs': [
          'Yemek paylaşırken oluşan hata düzeltildi.',
          'Sunucu tabanlı hata düzeltmeleri.'
        ],
      },
      {
        'version': '0.2.5-OpenBeta4',
        'date': '2022-08-27',
        'changes': [
          'Her kullanıcı yemek paylaşabilecek şekilde uygulama yenilendi.',
        ],
        'fixed bugs': [
          'Yazarların yemek paylaşma tuşuna basınca oluşan hata giderildi.',
        ],
      },
      {
        'version': '0.2.4-OpenBeta3',
        'date': '2022-08-26',
        'changes': [
          'Kullanıcı bilgileri düzenleme ekranına görüntülenen ismi değiştirme özelliği eklendi.',
        ],
        'fixed bugs': [
          'Kullanıcı bilgilerini düzeltme ekranında kullanıcının önceden sahip olduğu değerlerin otomatik doldurulması sırasında oluşan hata düzeltildi.',
          'Yine aynı ekranda kullanıcının o an mevcut olan doğum tarihi bilgisinin yanına güncellenecek olan verinin görüntülenmesi sağlandı. Böylece karmaşanın önüne geçildi.'
        ],
      },
      {
        'version': '0.2.3-OpenBeta2',
        'date': '2022-08-25',
        'changes': [],
        'fixed bugs': [
          'Genel hata düzeltmeleri.',
        ],
      },
      {
        'version': '0.2.2-OpenBeta1',
        'date': '2022-08-25',
        'changes': [
          'Uygulama Açık beta sürümüne geçti.',
        ],
        'fixed bugs': [
          'Sunucu tarafında geliştirmeler yapıldı.',
        ],
      },
      {
        'version': '0.2.1-ClosedTest6',
        'date': '2022-08-24',
        'changes': [
          'Tariflerden isimlere tıklayarak kullanıcı profiline gidilebiliyor.',
        ],
        'fixed bugs': [
          '"Kullanıcı Profil Ekranı" gerçekten çalışıyor...',
        ],
      },
      {
        'version': '0.2.0-ClosedTest5',
        'date': '2022-08-23',
        'changes': [
          '"Kullanıcı Profil Ekranı" eklendi.',
          'Tariflere çoklu fotoğraf koyma desteği eklendi.'
        ],
        'fixed bugs': [],
      },
      {
        'version': '0.1.1-ClosedTest4',
        'date': '2022-08-22',
        'changes': [
          '',
        ],
        'fixed bugs': [
          'Misafir kullanıcıların tariflere değerlendirme yazması engellendi.',
          'Profil ekranında Misafir olarak giriş yapıldğında oluşan hata giderildi.',
        ],
      },
      {
        'version': '0.1.0-ClosedTest3',
        'date': '2022-08-20',
        'changes': [
          'Profil ekranında kullanıcının doğum tarihi doğru formata getirildi.',
          'Kullanıcılar tariflere değerlendirme yazabilecekler.',
          ' Karanlık ve aydınlık mod arasında geçiş yapma özelliği eklendi. (!Geliştirmeye devam ediliyor!)',
        ],
        'fixed bugs': [],
      },
      {
        'version': '0.0.5-ClosedTest2',
        'date': '2022-08-20',
        'changes': [
          'Giriş ve kayıt ekranlarında şifrelerin gizleme ve görünür yapma tuşu eklendi.',
          'Ana ekranda gözüken tarif kartlarının kenar boşlukları değiştirildi.',
          'Kayıt ekranında güvenleğin iyileştirilmesi amacıyla şifre kullanıcıya iki kere sorulacak. ',
          'Şimdilik Google ile giriş kapalı üzerinde çalışmaya devam ediyorum. İsteyenler gmail adreslerini yazarak kaydolabilir.',
        ],
        'fixed bugs': [
          'Misafir olarak giriş yapıldığında profil ekranının yüklemede takılma sorunu giderildi.',
        ],
      },
      {
        'version': '0.0.4-ClosedTest1',
        'date': '2022-08-16',
        'changes': [
          'Ana ekrana tarifleri sıralama özelliği eklendi.',
        ],
        'fixed bugs': [
          'Bu sefer gerçekten arama ekranını düzelttim.',
        ],
      },
      {
        'version': '0.0.3-Internal',
        'date': '2022-08-14',
        'changes': [
          'Arayüzde genel yenilemeler yapıldı.',
          'Kullanıcının bilgi olarak ülke ve doğum tarihi belitme özelliği eklendi.',
          'Ana sayfada var olan tarif kartlarının görüntüsü değiştirildi.'
        ],
        'fixed bugs': [
          'Arama Ekranı düzeltildi (Umarım).',
          'Reklam Banner\'ları aktive edildi.'
        ],
      },
      {
        'version': '0.0.2-Internal',
        'date': '2022-08-11',
        'changes': [
          'Teknik hatalar nedeniyle Google ile giriş yöntemi devredışı bırakıldı.',
        ],
        'fixed bugs': [
          'Bir çok ekranda görsel düzenleme yapıldı.',
          'Bazı hatalar giderildi.',
        ],
      },
      {
        'version': '0.0.1-Internal',
        'date': '2022-08-11',
        'changes': [
          'İlk sürüm yayınlandı.',
        ],
        'fixed bugs': [],
      },
    ],
  },
  {
    'id': '2',
    'versions': [
      {
        'version': '1.0.0-Release',
        'date': '2022-11-18',
        'changes': [
          'İlk sürüm yayınlandı.',
        ],
        'fixed bugs': [],
      },
    ]
  },
];

/**TEMPLATE
  {
      'version': '',
      'date': '',
      'changes': [
        '',
      ],
      'fixed bugs': [
        '',
      ],
    },

 */
