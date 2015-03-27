//
//  File.swift
//  Entity
//
//  Created by Aaron Taylor on 3/27/15.
//  Copyright (c) 2015 Aaron Taylor. All rights reserved.
//

import Foundation
import CoreData

@objc(File)
class File: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var file_id: NSNumber

}
