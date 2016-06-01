//
//  ViewController.swift
//  CountDownLabel
//
//  Created by Martin Kluska on 05/30/2016.
//  Copyright (c) 2016 Martin Kluska. All rights reserved.
//

import UIKit
import CountDownLabel

class ViewController: UIViewController, CountDownProtocol {
    
    @IBOutlet weak var testLabel: UILabel!
   
    @IBOutlet weak var customLabel: CountDownLabel!

    @IBOutlet weak var customLabel5: CountDownLabel!
    @IBOutlet weak var customLabel4: CountDownLabel!
    @IBOutlet weak var customLabel3: CountDownLabel!
    @IBOutlet weak var customLabel2: CountDownLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let countDown = CountDown(aDelegate: self)
        //countDown.logic = .Automatic
        countDown.start = NSDate(timeIntervalSinceNow: 20)
        
        let formatter = countDown.formatter as? CountDownBaseFormater
        formatter?.dateStyle = .Full // this value is default
        formatter?.timeStyle = .Full // this value is default
        
        customLabel.date = NSDate(timeIntervalSinceNow: 100000)
        customLabel2.date = NSDate(timeIntervalSinceNow: 1000000)
        customLabel4.date = NSDate(timeIntervalSinceNow: 1000000)
        customLabel3.date = NSDate(timeIntervalSinceNow: -100000)
        customLabel5.date = NSDate(timeIntervalSinceNow: 100000)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - CountDownDelegate

    func countDownChanged(countDown: CountDown, format: String) {
        testLabel.text = format
    }
    
    func countDownFinished(countDown: CountDown) {
        print("ended at", countDown.date!)
    }
}

