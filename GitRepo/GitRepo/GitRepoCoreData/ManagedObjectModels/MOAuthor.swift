//
//  MOAuthor.swift
//  GitRepo
//
//  Created by Дарья Витер on 05/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation
import CoreData

@objc(MOAuthor)
internal class MOAuthor: NSManagedObject {
	
	@NSManaged var date: String
	@NSManaged var email: String?
	@NSManaged var name: String
}
