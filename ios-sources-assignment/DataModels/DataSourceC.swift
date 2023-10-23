//
//  DataSourceC.swift
//  ios-sources-assignment
//
//  Created by amit azulay on 22/10/2023.
//  Copyright © 2023 Chegg. All rights reserved.
//

import Foundation

struct DataSourceC: Codable {
    let topLine: String
    let subLine1: String
    let subLine2: String
    let image: String
    
    enum CodingKeys: String, CodingKey {
        case topLine = "topLine"
        case subLine1 = "subLine1"
        case subLine2 = "subline2"
        case image = "image"
    }
    
    static func convert(from sourceCData: [CacheSourceC]) -> [DataSourceC] {
        return sourceCData.map { cacheSourceC in
            return DataSourceC(topLine: cacheSourceC.title ?? "",
                               subLine1: cacheSourceC.subTitle1 ?? "",
                               subLine2: cacheSourceC.subTitle2 ?? "",
                               image: cacheSourceC.imageUrl ?? "")
        }
    }
}

