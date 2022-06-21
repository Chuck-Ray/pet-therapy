//
// Pet Therapy.
//

import Foundation
import Biosphere

extension Pet {
    
    static let snail = Pet(
        id: "snail",
        capabilities: [
            LinearMovement.self,
            WallCrawler.self
        ],
        frameTime: 0.4,
        movementPath: .idleFront,
        dragPath: .idleFront,
        speed: 0.2
    )
    
    static let nickySnail = Pet.snail.shiny(id: "snail_nicky")
}
