//
//  NetworkService.swift
//  ios-sources-assignment
//
//  Created by amit azulay on 22/10/2023.
//  Copyright © 2023 Chegg. All rights reserved.
//

import Foundation
import Alamofire

protocol INetworkService {
    func get(path: Datasource) async throws -> Data
    func fetchData<T: Decodable>(_ type: T.Type, from source: Datasource) async throws -> T?
}

class NetworkService: INetworkService {
    func get(path: Datasource) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                API_BASE_URL + path.sourceUrl(),
                requestModifier: { $0.timeoutInterval = MAX_WAIT_TIME }
            )
            .responseData { response in
                switch(response.result) {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }
        }
    }
    
    func fetchData<T: Decodable>(_ type: T.Type, from source: Datasource) async throws -> T? {
        do {
            let data = try await get(path: source)
            let result: T = try self.parseData(data: data)
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }

    private func parseData<T: Decodable>(data: Data) throws -> T{
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data)
        else {
            throw NSError(
                domain: "NetworkAPIError",
                code: 3,
                userInfo: [NSLocalizedDescriptionKey: "JSON decode error"]
            )
        }
        return decodedData
    }
    
    private func handleError(error: AFError) -> Error {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            
            if code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost {
                
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"
                let currentError = NSError(
                    domain: nserror.domain,
                    code: code,
                    userInfo: userInfo
                )
                return currentError
            }
        }
        return error
    }
}


