//
//  PersistenceHelper.swift
//  fileManagerProject
//
//  Created by Ahad Islam on 2/4/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import Foundation

struct PersistenceHelper<T: Codable> {
    func getObjects() throws -> [T] {
        guard let data = FileManager.default.contents(atPath: url.path) else {
            return []
        }
        return try PropertyListDecoder().decode([T].self, from: data)
    }
    
    func save(newElement: T) throws {
        var elements = try getObjects()
        elements.append(newElement)
        let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    func clear() throws {
        var elements = [T]()
        let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    private let fileName: String
    
    private var url: URL {
        filePathFromDocumentsDirectory(filename: fileName)
    }
    
    private func documentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func filePathFromDocumentsDirectory(filename: String) -> URL {
        documentsDirectory().appendingPathComponent(filename)
    }
}

struct PixPersistenceHelper {
    static let manager = PixPersistenceHelper()
    
    func save(newPix: Pix) throws {
        try persistenceHelper.save(newElement: newPix)
    }
    
    func clear() throws {
        try persistenceHelper.clear()
    }
    
    func getPix() throws -> [Pix] {
        try persistenceHelper.getObjects()
    }
    
    private let persistenceHelper = PersistenceHelper<Pix>(fileName: "pix.plist")
    
    private init() {}
}
