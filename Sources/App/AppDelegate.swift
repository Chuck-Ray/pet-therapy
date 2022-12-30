import AppKit
import OnScreen
import Schwifty
import Yage

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        Logger.log("App", "Launched")
        OnScreen.show(with: AppState.global, assets: PetsAssetsProvider.shared)
        StatusBarCoordinator.shared.show()
    }

    func applicationDidChangeScreenParameters(_ notification: Notification) {
        Logger.log("App", "Screen params changed, relaunching species...")
        OnScreen.hide()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            OnScreen.show(with: AppState.global, assets: PetsAssetsProvider.shared)
        }
    }
}

extension AppState: DesktopSettings {}
