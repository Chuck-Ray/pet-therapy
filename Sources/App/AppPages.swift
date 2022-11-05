import SwiftUI

enum AppPage: String, CaseIterable {
    case about
    case game
    case home
    case none
    case settings
}

extension AppPage: CustomStringConvertible {
    var description: String {
        switch self {
        case .about: return Lang.Page.about
        case .game: return Lang.Page.game
        case .home: return Lang.Page.home
        case .none: return ""
        case .settings: return Lang.Page.settings
        }
    }
}

extension AppPage {
    var icon: String {
        switch self {
        case .about, .none: return "info.square.fill"
        case .game: return "gamecontroller.fill"
        case .home: return "circle.grid.3x3.fill"
        case .settings: return "gearshape.fill"
        }
    }
}

