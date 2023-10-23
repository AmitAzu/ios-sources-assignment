//
//  MergedData.swift
//  ios-sources-assignment
//
//  Created by amit azulay on 22/10/2023.
//  Copyright © 2023 Chegg. All rights reserved.
//

import Foundation

struct MergedDataItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let title: String
    let subTitle: String
    let imageUrl: URL
    
    static func == (lhs: MergedDataItem, rhs: MergedDataItem) -> Bool {
        return lhs.id == rhs.id
    }
}

struct MergedData: Codable {
    let items: [MergedDataItem]

    init(fromSourceA sourceA: DataSourceA,
         fromSourceB sourceB: DataSourceB,
         fromSourceC sourceC: [DataSourceC]) {
    
        var mergedItems: [MergedDataItem] = []

        mergedItems += sourceA.stories.map { story in
            return MergedDataItem(
                title: story.title,
                subTitle: story.subTitle,
                imageUrl: URL(string: story.imageUrl) ?? URL(string: "https://pbs.twimg.com/profile_images/658218628127588352/v0ZLUBrt.jpg")!
            )
        }

        mergedItems += sourceB.metaData.innerData.map { story in
            return MergedDataItem(
                title: story.articleWrapper.header,
                subTitle: story.articleWrapper.description,
                imageUrl: URL(string: story.picture) ?? URL(string: "https://pbs.twimg.com/profile_images/658218628127588352/v0ZLUBrt.jpg")!
            )
        }

        mergedItems += sourceC.map { story in
            return MergedDataItem(
                title: story.topLine,
                subTitle: story.subLine1 + story.subLine2,
                imageUrl: URL(string: story.image) ?? URL(string: "https://pbs.twimg.com/profile_images/658218628127588352/v0ZLUBrt.jpg")!
            )
        }

        items = mergedItems
    }
}

