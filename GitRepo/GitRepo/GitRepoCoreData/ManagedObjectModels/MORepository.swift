//
//  MORepository.swift
//  GitRepo
//
//  Created by Дарья Витер on 05/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation
import CoreData

@objc(MORepository)
internal class MORepository: NSManagedObject {
	
	@NSManaged var branchesLink: String?
	@NSManaged var changesLink: String?
	@NSManaged var collaboratorsLink: String?
	@NSManaged var languageOfRepository: String?
	@NSManaged var lastChange: String?
	@NSManaged var name: String?
	@NSManaged var owner: String?
	@NSManaged var repositoryLink: String?
	
	// Relationships
	@NSManaged var branches: NSSet?
	@NSManaged var collaborators: NSSet?
	@NSManaged var commits: NSSet?
//	@NSManaged var project: NSSet?
}
