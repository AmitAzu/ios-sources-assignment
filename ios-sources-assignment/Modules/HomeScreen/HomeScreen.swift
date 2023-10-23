//
//  HomeScreen.swift
//  ios-sources-assignment
//
//  Created by amit azulay on 22/10/2023.
//  Copyright © 2023 Chegg. All rights reserved.
//

import SwiftUI

struct HomeScreen: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        if viewModel.hasError {
            ErrorView() {
                Task {
                    await viewModel.fetchData()
                }
            }
        } else {
            List {
                ForEach(viewModel.data) { item in
                    CustomCellView(item: item)
                }
                .mask(RoundedRectangle(cornerRadius: 6))
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 6, style: .continuous))
                .shadow(color: .black.opacity(0.2), radius: 10, x: 2, y: 3)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 38, trailing: 4))
            }
            .listStyle(.grouped)
            .overlay(content: {
                if viewModel.fetching {
                    ProgressView("Fetching data, please wait...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                }
            })
            .animation(.easeInOut, value: viewModel.data)
            .task {
                await viewModel.fetchData()
            }
        }
    }
}
