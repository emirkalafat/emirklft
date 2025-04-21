# Features

Her feature kendi içinde aşağıdaki yapıyı barındırmalıdır:

```
feature_name/
├── models/         # Veri modelleri
├── views/          # UI bileşenleri
├── viewmodels/    # İş mantığı ve state yönetimi
└── repositories/  # Veri erişim katmanı (opsiyonel)
```

Örnek feature klasör yapısı:
```
auth/
├── models/
│   └── user_model.dart
├── views/
│   ├── login_view.dart
│   └── register_view.dart
├── viewmodels/
│   └── auth_view_model.dart
└── repositories/
    └── auth_repository.dart
```
