//
//  DataSourceB.swift
//  ios-sources-assignment
//
//  Created by amit azulay on 22/10/2023.
//  Copyright © 2023 Chegg. All rights reserved.
//

import Foundation

struct ArticleWrapper: Codable {
    let header: String
    let description: String
}

struct DataSourceBStory: Codable {
    let aticleId: Int
    let articleWrapper: ArticleWrapper
    let picture: String
    
    enum CodingKeys: String, CodingKey {
        case articleWrapper = "articlewrapper"
        case aticleId = "aticleId"
        case picture = "picture"
    }
}

struct Metadata: Codable {
    let this: String
    let innerData: [DataSourceBStory]
    
    enum CodingKeys: String, CodingKey {
        case innerData = "innerdata"
        case this = "this"
    }
}

struct DataSourceB: Codable {
    let metaData: Metadata
    
    enum CodingKeys: String, CodingKey {
        case metaData = "metadata"
    }
    
    static func convert(from sourceBData: [CacheSourceB]) -> DataSourceB {
        let innerData = sourceBData.map { cacheSourceB in
            return DataSourceBStory(aticleId: 0,
                                    articleWrapper: ArticleWrapper(header: cacheSourceB.title ?? "",
                                                                   description: cacheSourceB.subTitle ?? ""),
                                    picture: cacheSourceB.imageUrl ?? "")
        }
        let metadata = Metadata(this: "", innerData: innerData)
        return DataSourceB(metaData: metadata)
    }
}
