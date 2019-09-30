//
//  AppError.swift
//  unit3ReviewProject
//
//  Created by Sam Roman on 9/18/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import Foundation

enum AppError: Error {
    case unauthenticated
    case invalidJSONResponse
    case couldNotParseJSON(rawError: Error)
    case noInternetConnection
    case badURL
    case badStatusCode
    case noDataReceived
    case notAnImage
    case other(rawError: Error)
}
