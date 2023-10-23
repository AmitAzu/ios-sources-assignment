
//  Copyright © 2018 Chegg. All rights reserved.

import Foundation

let MAX_WAIT_TIME = 15.0
let API_BASE_URL = "http://chegg-mobile-promotions.cheggcdn.com/ios/home-assignments/"

public enum Datasource : String {
    case sourceA = "source_a.json"
    case sourceB = "source_b.json"
    case sourceC = "source_c.json"

    public func sourceUrl() -> String {
        return self.rawValue
    }
}

enum CacheEntity: String {
    case sourceA = "CacheSourceA"
    case sourceB = "CacheSourceB"
    case sourceC = "CacheSourceC"
    
    var timestamp: TimeInterval {
        switch self {
        case .sourceA: return 5 * 60
        case .sourceB: return 30 * 60
        case .sourceC: return 60 * 60
        }
    }
}
