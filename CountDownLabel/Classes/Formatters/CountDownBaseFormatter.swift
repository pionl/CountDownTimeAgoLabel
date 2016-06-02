//
//  CountDownBaseFormatter.swift
//  CountDownLabel
//
//  Created by Martin Kluska on 30.05.16.
//  Copyright © 2016 iMakers, s.r.o. All rights reserved.
//

import Foundation

/**
 The countdown components
 
 - Year:
 - Month:
 - Day:
 - Hour:
 - Minute:
 - Second: 
 */
public enum CountDownFormatComponent: String {
    case Year = "countdown_year"
    case Month = "countdown_month"
    case Day = "countdown_day"
    case Hour = "countdown_hour"
    case Minute = "countdown_minute"
    case Second = "countdown_second"
}

/**
 Renders the part of date in given style
 
 - Full:  Shows full style with localized string: 2 seconds
 - ISO:   Shows the ISO format: 12:30:23
 - Short: Shows the shorten version of string: 2m 2s
 - None:  The rendering is skipped
 */
public enum CountDownFormatStyle: String {
    case Full = "full"
    case ISO = "iso"
    //case ISOCustom()
    case Short = "short"
    case None = "none"
}


/// Enables the base formating via the value and the key. Ideal for subclassing

public class CountDownBaseFormatter : NSObject, CountDownFormatProtocol {
    
    /// Separator used to join the date and time together. Default is space
    public var dateTimeSeparator = " "
    
    // MARK: - Time
    
    /// Time separator to join the time components together
    public var timeSeparator = " "
    
    /// Returns or sets the time style with correct setup of the formatter
    public var timeStyleObject: CountDownStyleProtocol? {
        didSet {
            // setup the style
            timeStyleObject!.setup(self)
        }
    }
    
    /// The stored time style
    private var _timeStyle: CountDownFormatStyle?
    
    /// Represents the style for the time. Used only for cunstructing the correct style object
    public var timeStyle: CountDownFormatStyle {
        // we must use set/get to enable creating the style object in init
        set(timeStyle) {
            _timeStyle = timeStyle
            
            switch timeStyle {
                
            case .Full:
                timeStyleObject = CountDownFullTimeStyle()
                break
                
            case .ISO:
                timeStyleObject = CountDownISOTimeStyle()
                break
                
            default:
                timeStyleObject = createSharedStyleObject(timeStyle)
                break
            }
        }
        get {
            return _timeStyle!
        }
    }
    
    // MARK: - Date
    
    /// Date separator to join the year, month, day together
    public var dateSeparator = " "
    
    /// Returns or sets the date style with correct setup of the formatter
    public var dateStyleObject: CountDownStyleProtocol? {
        didSet {
            // setup the style
            dateStyleObject!.setup(self)
        }
    }
    
    /// The stored date style.
    private var _dateStyle: CountDownFormatStyle?
    
    /// Represents the style for the date. Used only for cunstructing the correct style object
    public var dateStyle: CountDownFormatStyle {
        // we must use set/get to enable creating the style object in init
        set(dateStyle) {
            _dateStyle = dateStyle
            
            switch dateStyle {
                
            case .Full:
                dateStyleObject = CountDownFullDateStyle()
                break
                
            case .ISO:
                dateStyleObject = CountDownISODateStyle()
                break
                
            default:
                dateStyleObject = createSharedStyleObject(dateStyle)
                break
            }
        }
        get {
            return _dateStyle!
        }
    }
    
    // MARK: - Init
    
    /**
     Init method
     
     - returns: 
     */
    public override init() {
        super.init()
        
        timeStyle = .Full
        dateStyle = .Full
    }
    
    // MARK: - Public
    
    /**
     Formates the components with parts of date that are set
     
     - parameter components:
     
     - returns:
     */
    public func format(components: NSDateComponents) -> String {
        var values = [String]()
        
        // tries to append the date components
        values.append(formatDate(components))
        values.append(formatTime(components))
        
        return values.joinWithSeparator(dateTimeSeparator)
    }
    
    
    
    /**
     Returns the components to be parsed on formating
     
     - returns:
     */
    public func dateComponents() -> NSCalendarUnit {
        return [
            NSCalendarUnit.Year,
            NSCalendarUnit.Month,
            NSCalendarUnit.Day,
            NSCalendarUnit.Hour,
            NSCalendarUnit.Minute,
            NSCalendarUnit.Second,
        ]
    }
    
    // MARK: - Format
    
    /**
     Formates the date components
     
     - parameter components:
     
     - returns: 
     */
    func formatDate(components: NSDateComponents) -> String {
        var values = [String]()
        
        // tries to append the date components
        appendComponentTo(&values, component: .Year, value: components.year)
            .appendComponentTo(&values, component: .Month, value: components.month)
            .appendComponentTo(&values, component: .Day, value: components.day)
        
        return values.joinWithSeparator(dateSeparator)
    }
    
    /**
     Formates the time components and joins them
     
     - parameter components:
     
     - returns:
     */
    func formatTime(components: NSDateComponents) -> String {
        var values = [String]()
        
        appendComponentTo(&values, component: .Hour, value: components.hour)
            .appendComponentTo(&values, component: .Minute, value: components.minute)
            .appendComponentTo(&values, component: .Second, value: components.second)
        
        return values.joinWithSeparator(timeSeparator)
    }
    
    /**
     Formates the component if the value is valide
     
     - parameter component:
     - parameter value:
     
     - returns:
     */
    func formatComponent(component: CountDownFormatComponent, value: Int) -> String? {
        
        if canFormatComponent(component, value: value) {
            return formatComponentsValue(component, value: value)
        }
        
        return nil
    }
    
    /**
     Formates the component with given number
     
     - parameter component:
     - parameter value:
     
     - returns:
     */
    func formatComponentsValue(component: CountDownFormatComponent, value: Int) -> String {
        return styleFor(component).format(component, value: value)
    }
    
    /**
     Checks if the components value can be formated
     
     - parameter component:
     - parameter value:
     
     - returns:
     */
    func canFormatComponent(component: CountDownFormatComponent, value: Int) -> Bool {
        return styleFor(component).canFormatComponent(component, value: value)
    }
    
    /**
     Test the formated component and if not valid, it will add the value into the data source
     
     - parameter values:
     - parameter component:
     - parameter value:
     
     - returns:
     */
    func appendComponentTo(inout values: [String], component: CountDownFormatComponent, value: Int) -> Self {
        if let string = formatComponent(component, value: value) {
            values.append(string)
        }
        return self
    }
    
    /**
     Returns the style object for given component
     
     - parameter component:
     
     - returns:
     */
    private func styleFor(component: CountDownFormatComponent) -> CountDownStyleProtocol {
        switch component {
        case .Minute, .Hour, .Second:
            return timeStyleObject!
        default:
            return dateStyleObject!;
        }
    }
    
    /**
     Creates the share style for time or date
     
     - parameter style:
     
     - returns:
     */
    private func createSharedStyleObject(style: CountDownFormatStyle) -> CountDownStyleProtocol {
        if (style == .None) {
            return CountDownNoStyle()
        } else {
            return CountDownShortStyle()
        }
    }
}