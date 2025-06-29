import AppKit
import Foundation

if CommandLine.arguments.count < 2 {
    print("Usage: chponk minutes [title]")
    exit(0)
}
let originalTime = Int(CommandLine.arguments[1])! * 60
var time = originalTime

let title = CommandLine.arguments.count > 2 ?  CommandLine.arguments[2...].joined(separator: " ") : ""

let app = NSApplication.shared
let statusItem = NSStatusBar.system
  .statusItem(withLength: NSStatusItem.variableLength)

let menu = NSMenu()
menu.addItem(
  NSMenuItem(
    title: "Repeat \(formatTime(time:originalTime))",
    action: #selector(app.again),
    keyEquivalent: ""))
menu.addItem(
  NSMenuItem(
    title: "Stop",
    action: #selector(app.reset),
    keyEquivalent: ""))
menu.addItem(
  NSMenuItem(
    title: "Quit",
    action: #selector(app.quit),
    keyEquivalent: ""))
statusItem.menu = menu

app.again()
app.setActivationPolicy(.prohibited)
app.run()

extension NSApplication {
    @objc func again() {
        time = originalTime
        startTimer()
        refreshStatusBar()
    }

    @objc func reset() {
        time = 0
        refreshStatusBar()
    }

    @objc func quit() {
        exit(0)
    }
}

func refreshStatusBar() {
    if (time > 0) {
        statusItem.button?.title = "\(title) \(formatTime(time:time)) \u{1F3C3}"
    } else {
        statusItem.button?.title = "\u{1F6B6}"
    }
}

func startTimer() {
    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
        timer in
        time -= 1
        refreshStatusBar()
        if (time <= 0) {
            NSSound(named: NSSound.Name("Purr"))?.play()
            timer.invalidate()
        }
    }
}

func formatTime(time: Int) -> String {
        let minutes = String(format: "%.02d", time / 60)
        let seconds = String(format: "%.02d", time % 60)
        return "\(minutes):\(seconds)"
}
