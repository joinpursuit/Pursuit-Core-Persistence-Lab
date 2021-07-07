//
//  FileManager+Extension.swift
//  PersistanceLab
//
//  Created by Liubov Kaper  on 1/19/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import Foundation

// FileManager is responsible for accessing
extension FileManager {
    // functions gets url pass to documents directory
    // FileManager.getDocumentsDirectory() // type method
    // let fileManager = FileManager()
     // fileManager.getDocumentsDirectory() // instance merhod
    // documents/
    static func getDocumentsDirectory() -> URL {
        // going to user's documents directory and accessing user
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] // always [0]
    }
    
    // documents/schedules.plist "schedules.plist"
    static func pathToDocumentsDirectory(with filename: String) ->URL {
        return getDocumentsDirectory().appendingPathComponent(filename)
    }
}
