import Foundation

// model

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


class Clock {
    func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
}


// Протокол для представления (View)
protocol ConsoleView {
    func displayStopwatchStarted()
    func displayStopwatchStopped()
    func displayStopwatchReset()
    func displayTimerStarted(duration: TimeInterval)
    func displayTimerStopped()
    func displayAlarmSet(for time: Date)
    func displayAlarmTimeReached()
    func displayAlarmNotReached()
    func displayCurrentTime(_ time: String)
}


// Реализация консольного представления
class ConsoleViewImplementation: ConsoleView {
    func displayStopwatchStarted() {
        print("Stopwatch started")
    }
    
    func displayStopwatchStopped() {
        print("Stopwatch stopped")
    }
    
    func displayStopwatchReset() {
        print("Stopwatch reset")
    }
    
    func displayTimerStarted(duration: TimeInterval) {
        print("Timer started for \(duration) seconds")
    }
    
    func displayTimerStopped() {
        print("Timer stopped")
    }
    
    func displayAlarmSet(for time: Date) {
        print("Alarm set for \(time)")
    }
    
    func displayAlarmTimeReached() {
        print("Alarm time reached!")
    }
    
    func displayAlarmNotReached() {
        print("Alarm not yet reached")
    }
    
    func displayCurrentTime(_ time: String) {
        print("Current time is: \(time)")
    }
}

// Обновленный контроллер с поддержкой представления
class ConsoleController {
    let stopwatch = Stopwatch()
    let timerModel = TimerModel()
    let alarm = Alarm()
    let clock = Clock()
    let view: ConsoleView
    
    init(view: ConsoleView) {
        self.view = view
    }

    func startStopwatch() {
        stopwatch.start()
        view.displayStopwatchStarted()
    }
    
    func stopStopwatch() {
        stopwatch.stop()
        view.displayStopwatchStopped()
    }
    
    func resetStopwatch() {
        stopwatch.reset()
        view.displayStopwatchReset()
    }
    
    func startTimer(duration: TimeInterval, completion: @escaping () -> Void) {
        timerModel.startTimer(duration: duration, completion: completion)
        view.displayTimerStarted(duration: duration)
    }
    
    func stopTimer() {
        timerModel.stopTimer()
        view.displayTimerStopped()
    }
    
    func setAlarm(time: Date) {
        alarm.setAlarm(time: time)
        view.displayAlarmSet(for: time)
    }
    
    func checkAlarm() {
        if alarm.checkAlarm() {
            view.displayAlarmTimeReached()
        } else {
            view.displayAlarmNotReached()
        }
    }
    
    func getCurrentTime() {
        let currentTime = clock.getCurrentTime()
        view.displayCurrentTime(currentTime)
    }
}

// Создание экземпляра ConsoleViewImplementation
let consoleView = ConsoleViewImplementation()

// Создание экземпляра ConsoleController с поддержкой представления
let controller = ConsoleController(view: consoleView)

// Использование функционала: методы контроллера теперь уведомлят представление о результатах операций.
controller.startStopwatch()
sleep(5)
controller.stopStopwatch()

controller.startTimer(duration: 10) {
    print("Timer completion block executed")
}

let alarmTime = Date().addingTimeInterval(10)
controller.setAlarm(time: alarmTime)
sleep(10)
controller.checkAlarm()

controller.getCurrentTime()
