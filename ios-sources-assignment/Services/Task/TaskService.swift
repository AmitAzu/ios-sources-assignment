//
//  TaskService.swift
//  ios-sources-assignment
//
//  Created by amit azulay on 23/10/2023.
//  Copyright © 2023 Chegg. All rights reserved.
//

import Foundation
import CoreData

protocol ITaskService {
    func fetchMergedData() async -> MergedData?
}

class TaskService: ITaskService {
    
    let networkService: INetworkService
    let cacheService: ICacheService
    
    init(networkService: INetworkService, cacheService: ICacheService) {
        self.networkService = networkService
        self.cacheService = cacheService
    }
    
    func fetchMergedData() async -> MergedData? {
        do {
            let sourceAData = try await fetchDataFromSourceA()
            let sourceBData = try await fetchDataFromSourceB()
            let sourceCData = try await fetchDataFromSourceC()
            
            guard let mergedData = mergeData(sourceAData: sourceAData, sourceBData: sourceBData, sourceCData: sourceCData) else {
                return nil
            }
            
            return mergedData
        }
        catch {
            print("Error fetching and merging data: \(error)")
            return nil
        }
    }

    private func fetchDataFromSourceA() async throws -> DataSourceA? {
        guard cacheService.isCacheExpired(forEntityName: .sourceA),
              let sourceA = try await networkService.fetchData(DataSourceA.self, from: .sourceA)
        else {
            return DataSourceA.convert(from: cacheService.fetchData(CacheSourceA.self))
        }

        updateCacheForSourceA(sourceA)
        return sourceA
    }

   
    private func fetchDataFromSourceB() async throws -> DataSourceB? {
        guard cacheService.isCacheExpired(forEntityName: .sourceB),
              let sourceB = try await networkService.fetchData(DataSourceB.self, from: .sourceB)
        else {
            return DataSourceB.convert(from: cacheService.fetchData(CacheSourceB.self))
        }

        updateCacheForSourceB(sourceB)
        return sourceB
    }
    
    private func fetchDataFromSourceC() async throws -> [DataSourceC]? {
        guard cacheService.isCacheExpired(forEntityName: .sourceC),
              let sourceC = try await networkService.fetchData([DataSourceC].self, from: .sourceC)
        else {
            return DataSourceC.convert(from: cacheService.fetchData(CacheSourceC.self))
        }

        updateCacheForSourceC(sourceC)
        return sourceC
    }

    private func updateCacheForSourceA(_ sourceA: DataSourceA) {
        sourceA.stories.forEach { dataSourceA in
            let cacheObject = cacheService.createOrUpdate(CacheSourceA.self, entityName: .sourceA, title: dataSourceA.title)
            cacheObject.title = dataSourceA.title
            cacheObject.subTitle = dataSourceA.subTitle
            cacheObject.imageUrl = dataSourceA.imageUrl
            cacheObject.timestamp = Date()
        }
        cacheService.saveContext()
    }

    private func updateCacheForSourceB(_ sourceB: DataSourceB) {
        sourceB.metaData.innerData.forEach { dataSourceB in
            let cacheObject = cacheService.createOrUpdate(CacheSourceB.self, entityName: .sourceB, title: dataSourceB.articleWrapper.header)
            cacheObject.title = dataSourceB.articleWrapper.header
            cacheObject.subTitle = dataSourceB.articleWrapper.description
            cacheObject.imageUrl = dataSourceB.picture
            cacheObject.timestamp = Date()
        }
        cacheService.saveContext()
    }

    private func updateCacheForSourceC(_ sourceC: [DataSourceC]) {
        sourceC.forEach { dataSourceC in
            let cacheObject = cacheService.createOrUpdate(CacheSourceC.self, entityName: .sourceC, title: dataSourceC.topLine)
            cacheObject.title = dataSourceC.topLine
            cacheObject.subTitle1 = dataSourceC.subLine1
            cacheObject.subTitle2 = dataSourceC.subLine2
            cacheObject.imageUrl = dataSourceC.image
            cacheObject.timestamp = Date()
        }
        cacheService.saveContext()
    }

    private func mergeData(sourceAData: DataSourceA?, sourceBData: DataSourceB?, sourceCData: [DataSourceC]?) -> MergedData? {
        guard let dataSourceA = sourceAData,
              let dataSourceB = sourceBData,
              let dataSourceC = sourceCData
        else {
            return nil
        }

        let mergedData = MergedData(fromSourceA: dataSourceA, fromSourceB: dataSourceB, fromSourceC: dataSourceC)
        return mergedData
    }
}
