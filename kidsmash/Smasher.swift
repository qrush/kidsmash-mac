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

    private let eyes   = [":", ";", "X", "=", "8"]
    private let mouths = [")", "P", "D", "]", "|"]

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
            node.position = Random.point()
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
        node.fontColor = Random.color()
        return node
    }

    private func generatePointer() -> SKNode {
        let node = SKSpriteNode(imageNamed: "Pointer")
        node.color = Random.color()
        node.colorBlendFactor = 1.0
        return node
    }

    private func generateShape() -> SKNode {
        let node = SKShapeNode()

        switch Random.double(3) {
        case 0:
            node.path = CGPathCreateWithEllipseInRect(CGRect(x: 0, y: 0, width: 150, height: 150), nil)
        case 1:
            node.path = CGPathCreateWithRoundedRect(CGRect(x: 0, y: 0, width: 150, height: 150), 10, 10, nil)
        default:
            var triangle = CGPathCreateMutable()
            CGPathMoveToPoint(triangle, nil, 0, 0)
            CGPathAddLineToPoint(triangle, nil, 80, 160)
            CGPathAddLineToPoint(triangle, nil, 160, 0)
            CGPathAddLineToPoint(triangle, nil, 0, 0)

            node.path = triangle
        }

        node.antialiased = true
        node.fillColor = Random.color()
        node.lineWidth = 0

        let label = SKLabelNode(fontNamed:"Comic Sans MS")
        label.fontColor = NSColor.blackColor()
        label.fontSize = 75
        label.position = CGPoint(x: 50, y: 70)

        let eye = eyes[Int(Random.double(Double(eyes.count)))]
        let mouth = mouths[Int(Random.double(Double(mouths.count)))]
        label.text = "\(eye)\(mouth)"

        label.zRotation = -CGFloat(M_PI_2)
        node.addChild(label)

        return node
    }
}