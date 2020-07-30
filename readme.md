# Travel match IOS

### Папки и файлы
```
Travel Match/        главный проект
Core/                системный модуль Core
UI/                  системный модуль UI
Services/            сервисы, используемые в приложении
Modules/
    Auth/            модуль Auth
    OnBoarding/      модуль OnBoarding
    Questions/       модуль Questions
    Locals/          модуль Locals
    Offers/          модуль Offers
```

### Зависимости

Для управления зависимостями используем Swift Package Manager. Зависимости линкуются as static libraries.

[PhoneNumberKit](https://github.com/marmelroy/PhoneNumberKit) – библиотека для работы с номерами телефонов. Используется в полях ввода номеа телефона в формах авторизации и в профиле.
[SDWebImage](https://github.com/SDWebImage/SDWebImage) – асинхронная работа с изображениями. Используется в UI/ImageView.
[CVCalendar](https://github.com/CVCalendar/CVCalendar) – отображение календарей
