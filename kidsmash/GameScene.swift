import SpriteKit

class GameScene: SKScene {
    var history: Array<String> = []
    var currentZPosition: CGFloat = 1
    lazy var background: SKSpriteNode = self.initialBackground()

    func initialBackground() -> SKSpriteNode {
        return SKSpriteNode(color: NSColor.whiteColor(), size: view!.window!.frame.size)
    }

    override func didMoveToView(view: SKView) {
        backgroundColor = NSColor.whiteColor()

        background.alpha = 0.1
        background.position = CGPoint(x: background.frame.size.width / 2, y: background.frame.size.height / 2)
        colorizeBackground()
        addChild(background)

        view.window!.makeFirstResponder(self)
    }

    override func mouseMoved(theEvent: NSEvent!) {
        let center  = theEvent.locationInWindow
        addSmash(Smasher(point: NSPoint(x: center.x, y: center.y)))
    }

    override func keyDown(theEvent: NSEvent!) {
        let characters = theEvent.characters
        if let _ = characters.rangeOfString("[A-Za-z0-9]", options: .RegularExpressionSearch) {
            addLabel(characters)
        } else if characters == " " {
            addSmash(Smasher(shape: .Face))
        }
    }

    override func mouseDown(theEvent: NSEvent!) {
        addSmash(Smasher(shape: .Face))
    }

    private func colorizeBackground() {
        var action = SKAction.colorizeWithColor(Random.color(), colorBlendFactor: 1.0, duration: 15)

        background.runAction(action, completion: {
            self.colorizeBackground()
        })
    }

    private func addSmash(smasher: Smasher) {
        let node = smasher.generateNode()
        node.zPosition = currentZPosition
        currentZPosition++
        addChild(node)
    }

    private func addLabel(label: String) {
        history.append(label)

        let word = history.reduce("", +)
        if word == "quit" {
            NSApplication.sharedApplication().terminate(self)
        } else {
            addSmash(Smasher(label: label))
        }

        if history.count > 3 {
            history.removeAtIndex(0)
        }
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
