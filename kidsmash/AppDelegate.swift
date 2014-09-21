import Cocoa
import SpriteKit
import CoreGraphics
import QuartzCore
import ApplicationServices

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var skView: SKView!

    override func awakeFromNib() {
        // Lock app in full screen mode
        var presentationOptions = NSApplicationPresentationOptions.HideDock.rawValue |
            NSApplicationPresentationOptions.HideMenuBar.rawValue |
            NSApplicationPresentationOptions.DisableAppleMenu.rawValue |
            //NSApplicationPresentationOptions.DisableProcessSwitching.rawValue |
            NSApplicationPresentationOptions.DisableForceQuit.rawValue |
            NSApplicationPresentationOptions.DisableSessionTermination.rawValue |
            NSApplicationPresentationOptions.DisableHideApplication.rawValue

        var fullScreenOptions = [NSFullScreenModeApplicationPresentationOptions: presentationOptions]
        window.contentView.enterFullScreenMode(NSScreen.mainScreen(), withOptions: fullScreenOptions)
    }

    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        /* Pick a size for the scene */
        if let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene {
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            self.skView!.presentScene(scene)
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            self.skView!.ignoresSiblingOrder = true
            
            self.skView!.showsFPS = true
            self.skView!.showsNodeCount = true

            window.acceptsMouseMovedEvents = true
            window.makeFirstResponder(skView.scene)

            CGDisplayHideCursor(0)
        }
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(sender: NSApplication) -> Bool {
        return true
    }
}
