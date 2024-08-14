import SwiftyBeaver
import Foundation

class Log {
    static func initialize() {
        let console = ConsoleDestination()
        console.format = "$DHH:mm:ss$d $L $M"
        let bundleIdentifier = Bundle(for: Log.self).bundleIdentifier
        if let bundleIdentifier {
            console.logPrintWay = .logger(subsystem: bundleIdentifier, category: "CORE")
        }
        let log = SwiftyBeaver.self
        log.addDestination(console)
    }
}
