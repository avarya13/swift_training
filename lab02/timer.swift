import Foundation

// Модель секундомера
class Stopwatch {
    var isRunning: Bool = false
    var startTime: Date?
    var stopTime: Date?
    
    func start() {
        guard !isRunning else { return }
        startTime = Date()
        isRunning = true
    }
    
    func stop() {
        guard isRunning else { return }
        stopTime = Date()
        isRunning = false
    }
    
    func reset() {
        startTime = nil
        stopTime = nil
        isRunning = false
    }
}

// Модель таймера
class TimerModel {
    var timer: Timer?
    
    func startTimer(duration: TimeInterval, completion: @escaping () -> Void) {
        timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { _ in
            completion()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

// Будильник
class Alarm {
    var alarmTime: Date?
    
    func setAlarm(time: Date) {
        alarmTime = time
    }
    
    func checkAlarm() -> Bool {
        guard let alarmTime = alarmTime else { return false }
        let currentTime = Date()
        return currentTime >= alarmTime
    }
}

// Модель часов
class Clock {
    func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
}


// Контроллер
class ConsoleController {
    let stopwatch = Stopwatch()
    let timerModel = TimerModel()
    let alarm = Alarm()
    let clock = Clock()
    
    // Запуск секундомера
    func startStopwatch() {
        stopwatch.start()
        print("Stopwatch started")
    }
    
    // Остановка секундомера
    func stopStopwatch() {
        stopwatch.stop()
        print("Stopwatch stopped")
    }
    
    // Сброс секундомера
    func resetStopwatch() {
        stopwatch.reset()
        print("Stopwatch reset")
    }
    
    // Запуск таймера
    func startTimer(duration: TimeInterval, completion: @escaping () -> Void) {
        timerModel.startTimer(duration: duration, completion: completion)
        print("Timer started for \(duration) seconds")
    }
    
    // Остановка таймера
    func stopTimer() {
        timerModel.stopTimer()
        print("Timer stopped")
    }
    
    // Установка будильника
    func setAlarm(time: Date) {
        alarm.setAlarm(time: time)
        print("Alarm set for \(time)")
    }
    
    // Проверка будильника
    func checkAlarm() {
        if alarm.checkAlarm() {
            print("Alarm time reached!")
        } else {
            print("Alarm not yet reached")
        }
    }
    
    // Текущее время
    func getCurrentTime() -> String {
        let currentTime = clock.getCurrentTime()
        print("Current time is: \(currentTime)")
        return currentTime
    }
}

// Создание экземпляра ConsoleController
let controller = ConsoleController()

// Использование функционала секундомера
controller.startStopwatch() // Запуск секундомера
// Ждем некоторое время, например, 5 секунд, перед остановкой
sleep(5) // Задержка в 5 секунд для наглядности
controller.stopStopwatch() // Остановка секундомера

// Использование функционала таймера
controller.startTimer(duration: 10) {
    print("Timer completion block executed")
} // Запуск таймера на 10 секунд

// Использование функционала будильника
let alarmTime = Date().addingTimeInterval(10) // Устанавливаем будильник н1 30 секунд вперед
controller.setAlarm(time: alarmTime) // Установка будильника
sleep(10) // Задержка 10 секунд для наглядности
controller.checkAlarm() // Проверка сработал ли будильник

// Использование функционала часов
let currentTime = controller.getCurrentTime() // Получение текущего времени
print("Current time is: \(currentTime)")
