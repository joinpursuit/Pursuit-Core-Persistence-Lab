//
//  PersistenceHelper.swift
//  PersistenceLab
//
//  Created by Cameron Rivera on 1/16/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

struct PersistenceHelper<T: Codable & Equatable>{

    func getObjects() throws -> [T]{
        guard let data = FileManager.default.contents(atPath: url.path) else {
            return []
        }
        return try PropertyListDecoder().decode([T].self, from: data)
    }
    
    func saveObjects(_ object: T) throws {
        var savedData = try getObjects()
        savedData.append(object)
        let serializedData = try PropertyListEncoder().encode(savedData)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
    func removeObject(_ object: T) throws {
        let savedData = try getObjects()
    }
    
    
    init(fileName: String){
        self.fileName = fileName
    }
    
    private var fileName: String
    
    private var url: URL {
        return filePathFromDocumentsDirectory(fileName)
    }
    
    private func documentsDirectory() -> URL{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func filePathFromDocumentsDirectory(_ filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
