import Schwifty
import SwiftUI

class EntityRightClickHandler {
    static let shared = EntityRightClickHandler()
        
    weak var lastWindow: NSWindow?
    
    func onRightClick(with event: NSEvent) {
        lastWindow = event.window
        lastWindow?.contentView?.menu = petMenu()
    }

    private func petMenu() -> NSMenu {
        let menu = NSMenu(title: "MainMenu")
        menu.addItem(hideThisPetItem())
        menu.addItem(hideAllPetsItem())
        return menu
    }

    private func item(title: String, keyEquivalent: String, action: Selector, target: AnyObject) -> NSMenuItem {
        let item = NSMenuItem(
            title: NSLocalizedString("menu.\(title)", comment: title),
            action: action,
            keyEquivalent: keyEquivalent
        )
        item.target = self
        return item
    }

    private func hideThisPetItem() -> NSMenuItem {
        item(
            title: "hideThisPet",
            keyEquivalent: "",
            action: #selector(hideThisPet),
            target: self
        )
    }

    @objc func hideThisPet() {
        lastWindow?.close()
    }

    private func hideAllPetsItem() -> NSMenuItem {
        item(
            title: "hideAllPet",
            keyEquivalent: "",
            action: #selector(hideAllPets),
            target: self
        )
    }

    @objc func hideAllPets() {
        OnScreenCoordinator.hide()
    }
}
