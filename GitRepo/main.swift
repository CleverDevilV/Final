//
//  main.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import UIKit

//???
let isRunningTests = NSClassFromString("XCTestCase") != nil
let appDelegateClass = isRunningTests ? NSStringFromClass(FakeAppDelegate.self) : NSStringFromClass(AppDelegate.self)
let args = UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc))
UIApplicationMain(
	CommandLine.argc, CommandLine.unsafeArgv,
	nil, appDelegateClass)
//UIApplicationMain(CommandLine.argc, args, nil, appDelegateClass)
