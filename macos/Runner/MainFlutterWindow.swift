import Cocoa
import FlutterMacOS
import bitsdojo_window_macos

class MainFlutterWindow: BitsdojoWindow {
  override func bitsdojo_window_configure() -> UInt {
    return BDW_CUSTOM_FRAME | BDW_HIDE_ON_STARTUP
  }
    
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController.init()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)
//      flutterViewController.view.window!.standardWindowButton(NSWindow.ButtonType.closeButton)!.isHidden = true
//      flutterViewController.view.window!.standardWindowButton(NSWindow.ButtonType.miniaturizeButton)!.isHidden = true
//      flutterViewController.view.window!.standardWindowButton(NSWindow.ButtonType.zoomButton)!.isHidden = true
       
      let customToolbar = NSToolbar(identifier: "main")
    
      customToolbar.showsBaselineSeparator = false
      
      flutterViewController.view.window?.toolbar = customToolbar

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
