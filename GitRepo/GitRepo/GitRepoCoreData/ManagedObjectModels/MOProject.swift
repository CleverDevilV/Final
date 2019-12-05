//
//  MOProject.swift
//  GitRepo
//
//  Created by Дарья Витер on 05/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation
import CoreData

@objc(MOProject)
internal class MOProject: NSManagedObject {
	
	@NSManaged var projectName: String
	@NSManaged var repositoryURL: String?
	
	// Relationships
	@NSManaged var repository: MORepository?
	@NSManaged var tasks: NSSet?
}

