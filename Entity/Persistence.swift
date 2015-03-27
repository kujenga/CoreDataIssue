//
//  Persistence.swift
//  Entity
//
//  Created by Aaron Taylor on 3/27/15.
//  Copyright (c) 2015 Aaron Taylor. All rights reserved.
//

import Foundation
import Cocoa
import CoreData

struct Persistence {
    // handles unwrapping passed in MOC, or returns the default AppDelegate MOC
    private static func validateMOC(mocIn: NSManagedObjectContext?) -> NSManagedObjectContext {
        if let moc = mocIn {
            return moc
        } else {
            let appDel = NSApplication.sharedApplication().delegate as AppDelegate
            return appDel.managedObjectContext!
        }
    }
    
    private static func saveMOC(moc: NSManagedObjectContext, funcName: String) {
        var err = NSErrorPointer()
        moc.save(err)
        if err != nil {
            NSLog("%@: Error saving Managed Object Context: %@", funcName, err.memory!)
        }
    }
    
    static func createFile(mocIn: NSManagedObjectContext?, name: NSString) {
        let moc = self.validateMOC(mocIn)
        
        let newEntity: AnyObject = NSEntityDescription.insertNewObjectForEntityForName("File", inManagedObjectContext: moc)
        let newFile = newEntity as File
        
        newFile.name = name
        
        self.saveMOC(moc, funcName: __FUNCTION__)
    }
    
    static func getAllFiles(mocIn: NSManagedObjectContext?) -> [File]? {
        let moc = self.validateMOC(mocIn)
        
        var fetchRequest = NSFetchRequest(entityName: "File")
        
        var err = NSErrorPointer()
        let results = moc.executeFetchRequest(fetchRequest, error: err)
        if err != nil {
            NSLog("%@ fetch request error: %@", __FUNCTION__, err.memory!)
            return nil
        }
        if let r = results {
            if r.count > 0 {
                return r as? [File]
            }
        }
        return nil
    }
}