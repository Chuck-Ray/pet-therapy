import Firebase
import FirebaseAnalytics
import Pets
import Schwifty

// MARK: - Setup

public struct Tracking {
    public static var isEnabled = false

    public static func setup(isEnabled: Bool) {
        let firebaseAvailable = FirebaseApp.setup()
        self.isEnabled = isEnabled && firebaseAvailable
    }
}

// MARK: - Events

public extension Tracking {
    static func didLaunchApp(
        gravityEnabled: Bool,
        petSize: CGFloat,
        launchAtLogin: Bool,
        selectedSpecies: [String]
    ) {
        log(AnalyticsEventAppOpen, with: [
            "gravity_enabled": gravityEnabled,
            "pet_size": petSize,
            "launch_at_login": launchAtLogin,
            "selected_pets": selectedSpecies.joined(separator: ", ")
        ])
    }

    static func didRestorePurchases() {
        log("did_restore_purchases")
    }

    static func didSelect(_ species: String) {
        log("did_select_pet", with: ["pet": species])
    }

    static func didRemove(_ species: String) {
        log("did_remove_pet", with: ["pet": species])
    }

    static func didEnterDetails(species: String, name: String, price: Double?, purchased: Bool) {
        log(AnalyticsEventViewItem, with: [
            AnalyticsParameterItemID: species,
            AnalyticsParameterItemName: name,
            AnalyticsParameterPrice: price ?? 0,
            "alreadyPurchased": price == nil || purchased
        ])
    }

    static func purchased(species: String, price: Double, success: Bool) {
        log(AnalyticsEventPurchase, with: [
            AnalyticsParameterItemID: species,
            AnalyticsParameterPrice: price,
            AnalyticsParameterSuccess: success
        ])
    }
}
