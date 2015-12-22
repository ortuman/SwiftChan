//
//  SignalChannel.swift
//  Hooks
//
//  Created by Miguel Angel Ortuno Ortuno on 8/10/15.
//  Copyright © 2015 Hooks. All rights reserved.
//

import Foundation

class SignalChannel {
    
    private let sem = dispatch_semaphore_create(0)
    
    private var error: NSError?
    
    func signal() {
        dispatch_semaphore_signal(sem)
    }
    
    func signal(error error: NSError) {
        self.error = error
        dispatch_semaphore_signal(sem)
    }
    
    func wait() throws {
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER)
        guard self.error == nil else { throw self.error! }
    }
}