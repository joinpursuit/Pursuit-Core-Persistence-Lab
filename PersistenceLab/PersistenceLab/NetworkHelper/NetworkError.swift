//
//  NetworkError.swift
//  PersistenceLab
//
//  Created by Cameron Rivera on 1/16/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

enum NetworkError: Error{
    case badURL(String)
    case networkClientError(Error)
    case badData
    case noResponse
    case decodingError(Error)
    case encodingError(Error)
    case badStatusCode(Int)
}
