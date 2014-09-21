import SpriteKit

class GameScene: SKScene {
    var history: Array<String> = []

    override func didMoveToView(view: SKView) {
        backgroundColor = NSColor.whiteColor()

        view.window!.makeFirstResponder(self)
    }

    override func mouseMoved(theEvent: NSEvent!) {
        let center  = theEvent.locationInNode(self)
        let smasher = Smasher(point: NSPoint(x: center.x + 256, y: center.y))

        addChild(smasher.generateNode())
    }

    override func keyDown(theEvent: NSEvent!) {
        let characters = theEvent.characters
        if let _ = characters.rangeOfString("[A-Za-z0-9]", options: .RegularExpressionSearch) {
            addLabel(characters)
        } else if characters == " " {
            addShape()
        }
    }

    override func mouseDown(theEvent: NSEvent!) {
        addShape()
    }

    private func addLabel(label: String) {
        history.append(label)

        let word = history.reduce("", +)
        if word == "quit" {
            NSApplication.sharedApplication().terminate(self)
        } else {
            let smasher = Smasher(label: label)
            addChild(smasher.generateNode())
        }

        if history.count > 3 {
            history.removeAtIndex(0)
        }
    }

    private func addShape() {
        let smasher = Smasher(shape: .Face)
        addChild(smasher.generateNode())
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
