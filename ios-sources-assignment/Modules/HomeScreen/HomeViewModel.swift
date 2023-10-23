//
//  HomeViewModel.swift
//  ios-sources-assignment
//
//  Created by amit azulay on 22/10/2023.
//  Copyright © 2023 Chegg. All rights reserved.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var data: [MergedDataItem] = []
    @Published var fetching = false
    @Published var hasError = false
    let taskService: ITaskService
    
    init(taskService: ITaskService) {
        self.taskService = taskService
    }
    
    @MainActor
    func fetchData() async {

        fetching = true

        guard let mergedData = await taskService.fetchMergedData() else {
            hasError = true
            fetching = false
            return
        }
        data = mergedData.items
        fetching = false
    }
}


