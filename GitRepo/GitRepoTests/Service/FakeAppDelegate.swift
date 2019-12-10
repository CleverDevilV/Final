//
//  FakeAppDelegate.swift
//  GitRepoTests
//
//  Created by Дарья Витер on 08/12/2019.
//  Copyright © 2019 Viter. All rights reserved.
//

import Foundation
 /// FakeAppDelegate - [FakeAppDelegate](x-source-tag://FakeAppDelegate)
/// - Tag: FakeAppDelegate
class FakeAppDelegate: NSObject {
	
	static var t = "mock"
	
	private let filename = "log_tests.txt"
	
	private var filepath: URL {
		guard let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { fatalError() }
		return path.appendingPathComponent(filename)
	}
	
	private var logMessageData: Data {
		let timestamp = Date().timeIntervalSince1970
		let textMessage = "Test started at \(timestamp)"
		guard let data = "\(textMessage)\n".data(using: .utf8, allowLossyConversion: false) else { fatalError() }
		return data
	}
	
	override init() {
		super.init()
		
		writeTestLog()
	}
	
	private func writeTestLog() {
		if FileManager.default.fileExists(atPath: filepath.path) {
			appendLog()
		} else {
			writeFirstLog()
		}
	}
	
	private func appendLog() {
		if let fileHandle = FileHandle(forWritingAtPath: filepath.path) {
			fileHandle.seekToEndOfFile()
			fileHandle.write(logMessageData)
			fileHandle.closeFile()
		}
	}
	
	private func writeFirstLog() {
		do {
			try logMessageData.write(to: filepath, options: .atomicWrite)
		} catch { }
	}
}
