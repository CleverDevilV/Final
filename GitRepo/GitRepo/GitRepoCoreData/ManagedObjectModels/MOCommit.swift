//
//  MOCommit.swift
//  GitRepo
//
//  Created by Дарья Витер on 05/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation
import CoreData

@objc(MOCommit)
internal class MOCommit: NSManagedObject {
	
	@NSManaged var author: String?
	@NSManaged var date: String?
	@NSManaged var html_url: String?
	@NSManaged var message: String?
	@NSManaged var sha: String
	@NSManaged var url: String
	
	// Relationships
	@NSManaged var repository: MORepository
}
