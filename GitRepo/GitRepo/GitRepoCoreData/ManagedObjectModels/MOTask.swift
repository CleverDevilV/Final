//
//  MOTask.swift
//  GitRepo
//
//  Created by Дарья Витер on 05/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation
import CoreData

@objc(MOTask)
internal class MOTask: NSManagedObject {
	
	@NSManaged var taskContent: String
	
	@NSManaged var project: MOProject
	
}
