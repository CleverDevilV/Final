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
	@NSManaged var repositoryName: String?
	
	// Relationships
	@NSManaged var tasks: NSSet?
}

