//
//  PersistanceHelper.swift
//  PersistanceLab
//
//  Created by Liubov Kaper  on 1/19/20.
//  Copyright © 2020 Luba Kaper. All rights reserved.
//

import Foundation

enum DataPersistanceError: Error { // conforming to the Error protocol
    case savingError(Error) // associative value
    case fileDoesNotExist(String)
    case noData
    case decodingError(Error)
    case deletingError(Error)
}

class PersistanceHelper {
    
    //CRUD: - create, read, update, delete
    
    // array of events
    private static var images = [Hit]()
    
    // creating filename here to use in function bekow, unstead of hardcoding it
    private static let filename = "schedules.plist"
    
    private static func save() throws {
        // step 1
               // get url path to file, that the event will be saved to
               let url = FileManager.pathToDocumentsDirectory(with: filename)
               
               
               // events array will be object being converted to Data
               // we will use the Data object and write or save it to documents directory
               do {
                   // step 3
                   // converts or serializes the events array to Data
                   let data = try PropertyListEncoder().encode(images)
                   
                   // step 4
                   // writes data  to documents directory
                   try data.write(to: url, options: .atomic)
               } catch {
                   // step 5
                   throw DataPersistanceError.savingError(error)
               }
    }
    
    // DRY - don't repeat yourself
    
    // create - save item to dicuments directory
    // marking with throws, to make sure it throws error if there is one
    static func save(image: Hit) throws {
        
       // step 2
       // append new event to the events appary
       images.append(image)
        do {
           try save()
        } catch {
            throw DataPersistanceError.savingError(error)
        }
        
    }
    
    
    // read - load (retrieve) items from document directory
    
    static func loadImages()throws -> [Hit] {
        // we need access to filename URL that we are reading from
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        // check if file exists
        // to convert url to String we use .path on the URL
        if FileManager.default.fileExists(atPath: url.path) {
            
            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    images = try PropertyListDecoder().decode([Hit].self, from: data)
                } catch {
                    throw DataPersistanceError.decodingError(error)
                }
                
            } else {
                throw DataPersistanceError.noData
            }
            
        } else {
            throw DataPersistanceError.fileDoesNotExist(filename)
        }
        return images
    }
    
    // update -
    
    // delete - remove item from document directory
    static func delete(image index: Int) throws {
        
        // remove item from events array
        images.remove(at: index)
        // save our events array to the documents directory
        do {
            try save()
        } catch {
            throw DataPersistanceError.deletingError(error)
        }
    }
}
