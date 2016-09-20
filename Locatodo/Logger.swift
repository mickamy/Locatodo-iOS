//
//  Logger.swift
//  Locatodo
//
//  Created by Tetsuro Mikami on 9/20/16.
//  Copyright © 2016 Tetsuro Mikami. All rights reserved.
//

import XCGLogger

class Logger {
    
    fileprivate static let log = XCGLogger.default
    
    fileprivate static var needsSetup = true
    
    class func setup() {
        self.log.setup(
            level: .debug,
            showThreadName: true,
            showLevel: true,
            showFileNames: true,
            showLineNumbers: true
        )
    }
}

var log: XCGLogger {
    if Logger.needsSetup {
        Logger.setup()
        Logger.needsSetup = false
    }
    return Logger.log
}
