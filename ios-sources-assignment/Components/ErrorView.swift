//
//  ErrorView.swift
//  ios-sources-assignment
//
//  Created by amit azulay on 22/10/2023.
//  Copyright © 2023 Chegg. All rights reserved.
//

import SwiftUI

struct ErrorView: View {
    var onRetry: () -> Void
    
    var body: some View {
        
        VStack {
            Text("Failed to fetch data. Please try again later.")
                .foregroundColor(Color.accentColor)
                .padding()
            Button {
                onRetry()
            } label: {
                Text("Try Again")
                    .foregroundColor(Color.accentColor)
                    .padding()
                    .background(Color.primary)
                    .cornerRadius(10)
            }
        }
    }
}
