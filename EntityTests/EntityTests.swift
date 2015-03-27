//
//  EntityTests.swift
//  EntityTests
//
//  Created by Aaron Taylor on 3/27/15.
//  Copyright (c) 2015 Aaron Taylor. All rights reserved.
//

import Cocoa
import XCTest
import Entity

class EntityTests: XCTestCase {
    
    // core data stack code from: http://alanduncan.me/blog/2014/09/28/swift-core-data-tests/
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("Entity", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
        }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application’s saved data."
        if coordinator!.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil, error: &error) == nil {
            coordinator = nil
            let dict = NSMutableDictionary()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application’s saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain:"ENTITY_ERROR", code: 9999, userInfo: dict)
            NSLog("Unresolved error (error), (error!.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        managedObjectContext = nil
        
        super.tearDown()
    }
    
    func testEntityCreation() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
        
        Persistence.createFile(self.managedObjectContext, name: "test")
    }
    
}
