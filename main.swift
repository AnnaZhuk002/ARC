import Foundation


enum Engine {
    case START_ENGINE
    case STOP_ENGINE
}

enum Window {
    case OPEN_WINDOW
    case CLOSE_WINDOW
}

enum UpdateVolume {
    case PUT_ONE_UNIT
    case TAKE_ONE_UNIT
}

struct SmallCar: Hashable {
    let mark: String
    let yearOfProd: Int
    let trunkVolume: Int
    var isEngineRun: Bool
    var isWindowsOpen: Bool
    var usedTrunkVolume: Int
    
    init(mark: String, yearOfProd: Int, trunkVolume: Int) {
        self.mark = mark
        self.yearOfProd = yearOfProd
        self.trunkVolume = trunkVolume
        self.isEngineRun = false
        self.isWindowsOpen = false
        self.usedTrunkVolume = 0
    }
    
    mutating func modifyEngineState(state: Engine) {
        switch state {
        case .START_ENGINE:
            self.isEngineRun = true
        case .STOP_ENGINE:
            self.isEngineRun = false
        }
    }
    
    mutating func modifyWindowState(state: Window) {
        switch state {
        case .OPEN_WINDOW:
            self.isWindowsOpen = true
        case .CLOSE_WINDOW:
            self.isWindowsOpen = false
        }
    }
    
    mutating func modifyVolume(state: UpdateVolume) {
        switch state {
        case .PUT_ONE_UNIT:
            if self.usedTrunkVolume < self.trunkVolume {
                self.usedTrunkVolume += 1
            }
        case .TAKE_ONE_UNIT:
            if self.usedTrunkVolume > 1 {
                self.usedTrunkVolume -= 1
            }
        }
    }
}

struct Truck: Hashable {
    let mark: String
    let yearOfProd: Int
    let trunkVolume: Int
    var isEngineRun: Bool
    var isWindowsOpen: Bool
    var usedTrunkVolume: Int
    
    init(mark: String, yearOfProd: Int, trunkVolume: Int) {
        self.mark = mark
        self.yearOfProd = yearOfProd
        self.trunkVolume = trunkVolume
        self.isEngineRun = false
        self.isWindowsOpen = false
        self.usedTrunkVolume = 0
    }
    
    mutating func modifyEngineState(state: Engine) {
        switch state {
        case .START_ENGINE:
            self.isEngineRun = true
        case .STOP_ENGINE:
            self.isEngineRun = false
        }
    }
    
    mutating func modifyWindowState(state: Window) {
        switch state {
        case .OPEN_WINDOW:
            self.isWindowsOpen = true
        case .CLOSE_WINDOW:
            self.isWindowsOpen = false
        }
    }
    
    mutating func modifyVolume(state: UpdateVolume) {
        switch state {
        case .PUT_ONE_UNIT:
            if self.usedTrunkVolume < self.trunkVolume {
                self.usedTrunkVolume += 1
            }
        case .TAKE_ONE_UNIT:
            if self.usedTrunkVolume > 1 {
                self.usedTrunkVolume -= 1
            }
        }
    }
}

var dadCar: Truck = Truck(mark: "Toyota", yearOfProd: 1980, trunkVolume: 10)
var motherCar: SmallCar = SmallCar(mark: "Honda", yearOfProd: 1990, trunkVolume: 1)
var sonCar: Truck = Truck(mark: "Hontoy", yearOfProd: 2005, trunkVolume: 5)

dadCar.modifyWindowState(state: .OPEN_WINDOW)
dadCar.modifyEngineState(state: .START_ENGINE)
motherCar.modifyEngineState(state: .START_ENGINE)
motherCar.modifyVolume(state: .PUT_ONE_UNIT)
sonCar.modifyWindowState(state: .OPEN_WINDOW)
sonCar.modifyVolume(state: .PUT_ONE_UNIT)
sonCar.modifyVolume(state: .PUT_ONE_UNIT)
sonCar.modifyVolume(state: .PUT_ONE_UNIT)

var dict: [AnyHashable: String] = [
    dadCar: dadCar.mark,
    motherCar: dadCar.mark,
    sonCar: dadCar.mark
]

sonCar.modifyVolume(state: .PUT_ONE_UNIT)

for (key, _) in dict {
    print(key)
}

// Capture List
var currentValue = 0

let closure = {
    [currentValue] in
    print("Current value is \(currentValue)")
}

currentValue = 10
closure()

// Capture List позволяет захватывать переменные из окружающего контекста.
// Этот механизм позваляет избежать утечек памяти из-за деаллокации объектов
// или вознекновения цикла сильных ссылок, который не даст удалить объекты.

class Car {
    
    // сделаем переменную driver слабой ссылкой, тем самым разорвём цикл сильных ссылок
    weak var driver: Man?
    
    deinit{ // Выведем в консоль сообщение о том, что объект удален
    
    print("машина удалена из памяти")
        
    }
}

class Man {
    
    var myCar: Car?
    
    deinit{ // Выведем в консоль сообщение о том, что объект удален
        print("мужчина удален из памяти")
        
    }
    
}
// Объявим переменные как опциональные, чтобы иметь возможность им nil
var car: Car? = Car()
var man: Man? = Man()

// попробуем сделать цикл ссылок
car?.driver = man
// а мужчина на машину
man?.myCar = car
// присвоим nil переменным, удалим эти ссылки

car = nil
man = nil
// мы исправили цикл сильных ссылок
