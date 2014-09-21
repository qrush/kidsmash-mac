import SpriteKit

class Smasher {
    enum Shape {
        case Letter
        case Pointer
        case Face
    }

    let shape: Shape
    let label: String
    let point: CGPoint

    var node: SKNode {
        switch shape {
        case .Letter:
            return generateLetter()
        case .Pointer:
            return generatePointer()
        case .Face:
            return generateShape()
        }
    }

    init(shape: Shape, label: String, point: CGPoint) {
        self.shape = shape
        self.label = label
        self.point = point
    }

    convenience init(point: CGPoint) {
        self.init(shape: .Pointer, label: "", point: point)
    }

    convenience init(label: String) {
        self.init(shape: .Letter, label: label, point: CGPointZero)
    }

    convenience init(shape: Shape) {
        self.init(shape: shape, label: "", point: CGPointZero)
    }

    func generateNode() -> SKNode {
        var node = self.node

        if point == CGPointZero {
            node.position = generatePoint()
        } else {
            node.position = point
        }

        node.runAction(SKAction.waitForDuration(1), completion: {
            node.runAction(SKAction.fadeOutWithDuration(2), completion: {
                node.removeFromParent()
            })
        })

        return node
    }



    private func generateLetter() -> SKNode {
        let node = SKLabelNode(fontNamed:"Comic Sans MS")
        node.text = label
        node.fontSize = 150
        node.fontColor = generateColor()
        return node
    }

    private func generatePointer() -> SKNode {
        let node = SKSpriteNode(imageNamed: "Pointer")
        node.color = generateColor()
        node.colorBlendFactor = 1.0
        return node
    }

    private func generateShape() -> SKNode {
        let node = SKShapeNode()

        switch generateRandom(3) {
        case 0:
            node.path = CGPathCreateWithEllipseInRect(CGRect(x: 0, y: 0, width: 150, height: 150), nil)
        case 1:
            node.path = CGPathCreateWithRoundedRect(CGRect(x: 0, y: 0, width: 150, height: 150), 10, 10, nil)
        default:
            var triangle = CGPathCreateMutable()
            CGPathMoveToPoint(triangle, nil, 0, 0)
            CGPathAddLineToPoint(triangle, nil, 75, 150)
            CGPathAddLineToPoint(triangle, nil, 150, 0)
            CGPathAddLineToPoint(triangle, nil, 0, 0)

            node.path = triangle
        }

        node.antialiased = true
        node.fillColor = generateColor()
        node.lineWidth = 0

        let label = SKLabelNode(fontNamed:"Comic Sans MS")
        label.fontColor = NSColor.blackColor()
        label.fontSize = 75
        label.position = CGPoint(x: 50, y: 60)

        switch generateRandom(8) {
        case 0:
            label.text = ":o"
        case 1:
            label.text = ":D"
        case 2:
            label.text = ";)"
        case 3:
            label.text = "8D"
        case 4:
            label.text = "XD"
        case 5:
            label.text = ":]"
        case 6:
            label.text = ":P"
        default:
            label.text = ":)"
        }

        label.zRotation = -CGFloat(M_PI_2)
        node.addChild(label)

        return node
    }

    private func generateRandom(max: Double) -> Double {
        return Double(arc4random_uniform(UInt32(max)))
    }

    private func generateColor() -> NSColor {
        let randomComponent = { () -> CGFloat in
            return CGFloat(self.generateRandom(255) / 255)
        }

        return NSColor(calibratedRed: randomComponent(), green: randomComponent(), blue: randomComponent(), alpha: 1.0)
    }

    private func generatePoint() -> CGPoint {
        let xMargin = 50.0
        let yMargin = 75.0
        let width   = Double(NSScreen.mainScreen().frame.size.width)
        let height  = Double(NSScreen.mainScreen().frame.size.height)

        var xPos = 0.0
        var yPos = 0.0

        while xPos < xMargin || xPos > width - xMargin ||
              yPos < yMargin || yPos > height - yMargin {

                xPos = generateRandom(width)
                yPos = generateRandom(height)
        }

        return CGPoint(x: xPos - xMargin, y: yPos - yMargin)
    }

}