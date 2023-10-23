//
//  DataSourceA.swift
//  ios-sources-assignment
//
//  Created by amit azulay on 22/10/2023.
//  Copyright © 2023 Chegg. All rights reserved.
//

import Foundation

struct DataSourceAStory: Codable {
    let title: String
    let subTitle: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case subTitle = "subtitle"
        case imageUrl = "imageUrl"
    }
}

struct DataSourceA: Codable {
    let stories: [DataSourceAStory]
    
    static func convert(from sourceAData: [CacheSourceA]) -> DataSourceA {
        let stories = sourceAData.map { cacheSourceA in
            return DataSourceAStory(title: cacheSourceA.title ?? "",
                                    subTitle: cacheSourceA.subTitle ?? "",
                                    imageUrl: cacheSourceA.imageUrl ?? "")
        }
        return DataSourceA(stories: stories)
    }
}
