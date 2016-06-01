//
//  CountDownStyleProtocol.swift
//  Pods
//
//  Created by Martin Kluska on 01.06.16.
//
//

import Foundation

public protocol CountDownStyleProtocol {
    
    /**
     Checks if we can format the compontent
     
     - parameter component:
     - parameter value:
     
     - returns:
     */
    func canFormatComponent(component: CountDownFormatComponent, value: Int) -> Bool
    
    /**
     Setups the formatter to match the style if needed
     
     - parameter formatter:
     */
    func setup(formatter: CountDownBaseFormatter)
    
    /**
     Formates the components value
     
     - parameter component:
     - parameter value:
     */
    func format(component: CountDownFormatComponent, value: Int) -> String
}