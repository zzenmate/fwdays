# language: ru

Функционал: Тест екшена генерации и проверки билетов
    Тестируем создание билета с QR-кодом

    Сценарий: Проверяем не созданный или неоплаченный билет
        Допустим я вхожу в учетную запись с именем "user@fwdays.com" и паролем "qwerty"
        Допустим я оплатил билет для "user@fwdays.com"
        И я перехожу на "/event/zend-framework-day-2011/ticket"
        Тогда код ответа сервера должен быть 200
        И это PDF-файл

#inactive - no payment
    Сценарий: Проверяем активный и неоплаченный билет
        Допустим я вхожу в учетную запись с именем "admin@fwdays.com" и паролем "qwerty"
#        Допустим я не оплатил билет для "admin@fwdays.com"
        И я перехожу на "/ticket/8/check/b6babfa119ea9428b9835c2b51ff11a6"
        И я должен видеть "Билет №8 не оплочен"
#inactive - have payment
    Сценарий: Проверяем не активный и оплаченный билет
        Допустим я вхожу в учетную запись с именем "admin@fwdays.com" и паролем "qwerty"
        Допустим я оплатил билет для "admin@fwdays.com"
        И я перехожу на "/ticket/8/check/b6babfa119ea9428b9835c2b51ff11a6"
        И я должен видеть "Билет №8 был использован"
#inactive - pending
    Сценарий: Проверяем не активный и ожыдает оплаты билет
        Допустим я вхожу в учетную запись с именем "admin@fwdays.com" и паролем "qwerty"
        Допустим я ожыдаю оплаты билета для "admin@fwdays.com"
        И я перехожу на "/ticket/8/check/b6babfa119ea9428b9835c2b51ff11a6"
        И я должен видеть "Билет №8 не оплочен"
#active - have payment
    Сценарий: Проверяем активный и оплоченый билет
        Допустим я вхожу в учетную запись с именем "admin@fwdays.com" и паролем "qwerty"
        Допустим я оплатил билет для "admin@fwdays.com"
        И я перехожу на "/ticket/8/check/b6babfa119ea9428b9835c2b51ff11a6"
        И я должен видеть "Все ок. Билет №8 отмечаем как использованный"

    Сценарий: Проверяем не созданный или неоплаченный билет
        Допустим я вхожу в учетную запись с именем "user@fwdays.com" и паролем "qwerty"
        Допустим я не оплатил билет для "user@fwdays.com"
        И я перехожу на "/event/zend-framework-day-2011/ticket"
        Тогда код ответа сервера должен быть 402
        И я должен видеть "Вы не оплачивали участие в \"Zend Framework Day\""

    #Тестируем проверку билета с QR-кодом
    Сценарий: Проверяем регистрацию билета в системе не администратором
        Допустим я вхожу в учетную запись с именем "user@fwdays.com" и паролем "qwerty"
        И я перехожу на страницу регистрации для "user@fwdays.com"
        Тогда код ответа сервера должен быть 403

    Сценарий: Проверяем регистрацию билета в системе администратором
        Допустим я вхожу в учетную запись с именем "admin@fwdays.com" и паролем "qwerty"
        И я перехожу на страницу регистрации для "user@fwdays.com"
        Тогда код ответа сервера должен быть 200
        И я должен видеть "Все ок"
        #Пробуем зарегестрироваться еще раз
        И я перехожу на страницу регистрации для "user@fwdays.com"
        Тогда код ответа сервера должен быть 409
        И я должен видеть "был использован"
        #Пробуем зарегестрироваться с неправильным хешем
        И я перехожу на страницу регистрации для "user@fwdays.com" с битым хешем
        Тогда код ответа сервера должен быть 403
        И я должен видеть "Невалидный хеш для билета"
