//
//  HomeCell.swift
//  ios-sources-assignment
//
//  Created by amit azulay on 22/10/2023.
//  Copyright © 2023 Chegg. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomCellView: View {
    let item: MergedDataItem
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 6.0)
                .fill(Color.white)
                .frame(height: 140)
            
            HStack(spacing: 6) {
                WebImage(url: item.imageUrl)
                    .resizable()
                    .placeholder(Image(systemName: "photo"))
                    .frame(width: 140, height: 140)
                    .scaledToFit()
                    .cornerRadius(6)
                    
                VStack(alignment: .leading,spacing: 14) {
                    Text(item.title)
                        .font(.title)
                        .fontWeight(.semibold)
                    RoundedRectangle(cornerRadius: 0.0)
                        .fill(Color.clear)
                        .frame(height: 6)
                    Text(item.subTitle)
                        .font(.title3)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    RoundedRectangle(cornerRadius: 0.0)
                        .fill(Color.clear)
                        .frame(height: 30)
                }
            }
        }
    }
}

