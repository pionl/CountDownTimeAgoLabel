//
//  CountDownLabel.swift
//  Pods
//
//  Created by Martin Kluska on 01.06.16.
//
//

import Foundation

/// The finish block
public typealias CountDownFinishBlock = (countDown: CountDown) -> Void

@IBDesignable
/// Desibganle count down label
public class CountDownLabel: UILabel, CountDownProtocol {
    
    /// Create the countdown interface, readonly
    private(set) public var countDown: CountDown?
    
    
    /// The logic style
    @IBInspectable var logic: String? {
        didSet {
            if logic != nil {
                countDown?.logic = CountDownLogic(rawValue: logic!.lowercaseString)!
            }
        }
    }
    
    /// The time style for the formmater. Only on supported formatter
    @IBInspectable var timeStyle: String? {
        didSet {
            if timeStyle != nil {
                let enumValue = CountDownFormatStyle(rawValue: timeStyle!.lowercaseString)!
                
                if let formatter = countDown?.formatter as? CountDownBaseFormatter {
                    formatter.timeStyle = enumValue
                }
            }
        }
    }
    
    /// Set the date style for the countdown
    @IBInspectable var dateStyle: String? {
        didSet {
            if dateStyle != nil {
                let enumValue = CountDownFormatStyle(rawValue: dateStyle!.lowercaseString)!
                
                if let formatter = countDown?.formatter as? CountDownBaseFormatter {
                    formatter.dateStyle = enumValue
                }
            }
        }
    }
    
    /// Set the autostart
    @IBInspectable var autoStartOnDate: Bool? {
        didSet {
            if autoStartOnDate != nil {
                countDown?.autoStartOnDate = autoStartOnDate!
            }
        }
    }
    
    /// Countdown date, in default will trigger the start of the countdown
    public var date: NSDate? {
        set(value) {
            countDown?.date = value!
        }
        get {
            return countDown?.date
        }
    }
    
    /// Triggered when logic is set on CountDown (default) and the countdown has finished
    public var onFinishBlock: CountDownFinishBlock? = nil
    
    /// Add a text before the desired format. Must add a space if desired
    @IBInspectable public var prefixText: String?
    
    /// Add a text after the format. Must add a space if desired
    @IBInspectable public var suffixText: String?
    
    /// Show the prefix on finished state
    @IBInspectable public var showPrefixOnFinish: Bool = false
    
    /// Show the suffix on finished state
    @IBInspectable public var showSuffixOnFinish: Bool = false
    
    // MARK: - INIT
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    // MARK: - Deinit
    
    deinit {
        countDown?.stop()
    }
    
    public override func removeFromSuperview() {
        super.removeFromSuperview()
        countDown?.stop()
    }
    
    
    /**
     Setups the basic countdown
     */
    func setup() {
        countDown = CountDown(aDelegate: self)
    }
    
    // MARK: - CountDown protocol
    
    /**
     Update the text
     
     - parameter countDown:
     - parameter format:
     */
    public func countDownChanged(countDown: CountDown, format: String) {
        var finalText = ""
        
        appendTextIfCan(&finalText, countDown: countDown, canShowOnFinished: showPrefixOnFinish, text: prefixText)
        
        finalText += format
        
        appendTextIfCan(&finalText, countDown: countDown, canShowOnFinished: showSuffixOnFinish, text: suffixText)
        
        text = finalText
    }
    
    /**
     Checks if we cann add suffix/prefix text into the final text
     
     - parameter target:
     - parameter countDown:
     - parameter text:
     */
    private func appendTextIfCan(inout target: String, countDown: CountDown, canShowOnFinished: Bool, text: String?) {
        // add only if text is provided and if the countdown is not in finish state (if the
        // not set differently)
        if text != nil && (!countDown.hasFinished || canShowOnFinished) {
            target += text!
        }
    }
    
    /**
     Handle the finished state.
     
     - parameter countDown:
     */
    public func countDownFinished(countDown: CountDown) {
        if onFinishBlock != nil {
            onFinishBlock!(countDown: countDown)
        }
    }
    
    // MARK: - Interface
    
    public override func prepareForInterfaceBuilder() {
        countDown?.autoStartOnDate = true
        countDown?.logic = .Static
        countDown?.date = NSDate(timeIntervalSinceNow: 100000000)
    }
}
