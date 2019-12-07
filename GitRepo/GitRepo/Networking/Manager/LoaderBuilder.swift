//
//  LoaderBuilder.swift
//  GitRepo
//
//  Created by Дарья Витер on 07/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation

protocol LoaderBuilderProtocol: class {
	static func createLoader() -> LoaderProtocol
}

class LoaderBuilder: LoaderBuilderProtocol {
	static func createLoader() -> LoaderProtocol {
		let coreDataManagerService = ManagedObjectFromCoreDataService(withDeleting: false)
		let loader = Loader(coreDataService: coreDataManagerService)
		
		return loader
	}
}
