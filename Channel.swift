//
//  Channel.swift
//  Test
//
//  Created by Miguel Angel Ortuno Ortuno on 21/9/15.
//  Copyright © 2015 Miguel Angel Ortuno Ortuno. All rights reserved.
//

import Foundation

class Channel<T> {
    
    private var channelValue: (value: T?, error: NSError?)
    
    private let sendSemaphore = dispatch_semaphore_create(0)
    private let recvSemaphore = dispatch_semaphore_create(0)
    
    func send(value value: T) {
        channelValue = (value, nil)
        dispatch_semaphore_signal(sendSemaphore)
        dispatch_semaphore_wait(recvSemaphore, DISPATCH_TIME_FOREVER)
    }
    
    func send(error error: NSError) {
        channelValue = (nil, error)
        dispatch_semaphore_signal(sendSemaphore)
        dispatch_semaphore_wait(recvSemaphore, DISPATCH_TIME_FOREVER)
    }
    
    func recv() throws -> T {
        dispatch_semaphore_wait(sendSemaphore, DISPATCH_TIME_FOREVER)
        dispatch_semaphore_signal(recvSemaphore)
        guard let value = channelValue.value else { throw channelValue.error! }
        return value
    }
}
