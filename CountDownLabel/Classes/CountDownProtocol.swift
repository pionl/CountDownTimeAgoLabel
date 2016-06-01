//
//  CountDownProtocol.swift
//  CountDownLabel
//
//  Created by Martin Kluska on 30.05.16.
//  Copyright © 2016 iMakers, s.r.o. All rights reserved.
//

import Foundation

public protocol CountDownProtocol: class {
    
    /**
     Triggered when the count down has changed
     
     - parameter countDown:
     - parameter format:
     */
    func countDownChanged(countDown: CountDown, format: String)
    
    /**
     Fired when the countdown has finished
     
     - parameter countDown:
     */
    func countDownFinished(countDown: CountDown)
}

// MARK: - Optional methods
public extension CountDownProtocol {
    func countDownFinished(countDown: CountDown) {
        // defaulty do nothing
    }
}