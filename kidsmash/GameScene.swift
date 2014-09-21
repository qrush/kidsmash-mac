import SpriteKit

class GameScene: SKScene {
    var history: Array<String> = []

    override func didMoveToView(view: SKView) {
        self.backgroundColor = NSColor.whiteColor()
    }

    override func keyDown(theEvent: NSEvent!) {
        let characters = theEvent.characters
        if let _ = characters.rangeOfString("[A-Za-z0-9]", options: .RegularExpressionSearch) {
            history.append(characters)

            let word = history.reduce("") { $0 + $1 }
            if word == "quit" {
                NSApplication.sharedApplication().terminate(self)
            } else {
                addLabel(characters)
            }

            if history.count > 3 {
                history.removeAtIndex(0)
            }
        }
    }

    func addLabel(characters: String) {
        let label = SKLabelNode(fontNamed:"Comic Sans MS")
        label.text = characters
        
        label.fontColor = generateColor()
        label.fontSize = 200
        label.position = generatePoint()
        
        let rotation = SKAction.scaleTo(1.5, duration: 2)
        label.runAction(rotation)
        
        label.runAction(SKAction.fadeOutWithDuration(4), completion: { () -> Void in
            label.removeFromParent()
        })
        self.addChild(label)
        
    }
    
    func generateRandom(max: Double) -> Double {
        return Double(arc4random_uniform(UInt32(max)))
    }
    
    func generateColor() -> NSColor {
        let randomComponent = { () -> CGFloat in
            return CGFloat(self.generateRandom(255) / 255)
        }

        return NSColor(calibratedRed: randomComponent(), green: randomComponent(), blue: randomComponent(), alpha: 1.0)
    }

    func generatePoint() -> CGPoint {
        let xMargin = 50.0
        let yMargin = 75.0
        let width   = Double(self.frame.size.width)
        let height  = Double(self.frame.size.height)

        var xPos = 0.0
        var yPos = 0.0

        while xPos < xMargin || xPos > width - xMargin ||
              yPos < yMargin || yPos > height - yMargin {

            xPos = generateRandom(width)
            yPos = generateRandom(height)
        }

        return CGPoint(x: xPos - xMargin, y: yPos - yMargin)
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
