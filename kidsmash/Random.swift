import Cocoa

struct Random {
    static func double(max: Double) -> Double {
        return Double(arc4random_uniform(UInt32(max)))
    }

    static func color() -> NSColor {
        let randomComponent = { () -> CGFloat in
            return CGFloat(self.double(255) / 255)
        }

        return NSColor(calibratedRed: randomComponent(), green: randomComponent(), blue: randomComponent(), alpha: 1.0)
    }

    static func point() -> CGPoint {
        let xMargin = 50.0
        let yMargin = 75.0
        let width   = Double(NSScreen.mainScreen().frame.size.width)
        let height  = Double(NSScreen.mainScreen().frame.size.height)

        var xPos = 0.0
        var yPos = 0.0

        while xPos < xMargin || xPos > width - xMargin ||
            yPos < yMargin || yPos > height - yMargin {

                xPos = double(width)
                yPos = double(height)
        }

        return CGPoint(x: xPos - xMargin, y: yPos - yMargin)
    }
}