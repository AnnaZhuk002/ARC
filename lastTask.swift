import Foundation

class Man {
    
    var passport: (() -> Passport?)? // По заданию weak или unowned запрещено ставить

    deinit {
        // выведем в консоль сообщение о том, что объект удален
        print("мужчина удален из памяти")
    }
}

class Passport {
    let man: Man
    init(man: Man){
        self.man = man
    }
    deinit {
        // выведем в консоль сообщение о том, что объект удален
        print("паспорт удален из памяти")
    }
}

var man: Man? = Man()
var passport: Passport? = Passport(man: man!)
man?.passport = { [weak passport] in
    return passport
}
passport = nil // объект еще не удален, его удерживает мужчина
man = nil // Теперь удалены оба объекта
