//
//  AppError.swift
//  userDefaultslab
//
//  Created by Ahad Islam on 12/25/19.
//  Copyright © 2019 Ahad Islam. All rights reserved.
//

import Foundation

enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode(Int)
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
    case networkClientError(Error)
    case decodingError(Error)
    case encodingError(Error)
    case imageDecodingError
    case noResponse
}
