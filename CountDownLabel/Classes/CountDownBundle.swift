//
//  CountDownBundle.swift
//  Pods
//
//  Created by Martin Kluska on 30.05.16.
//
//

import Foundation

class CountDownBundle: NSObject {
    
    /// Returns the shared bundle
    static let shared = CountDownBundle()
    
    /// Holds the current bundle for the resources
    var resourcesBundle: NSBundle?
    
    override init() {
        super.init()
        
        // must load the frameowkr bundle
        let frameworkBundle = NSBundle(forClass: self.classForCoder)
        
        // we must get the bundle with resources
        let path = frameworkBundle.pathForResource("CountDownLabel", ofType: "bundle")
        
        // we must load the bundle
        resourcesBundle = NSBundle(path: path!)!
    }
    
    static func resourceBundle() -> NSBundle {
        return shared.resourcesBundle!
    }
}