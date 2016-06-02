# CountDownLabel

[![Version](https://img.shields.io/cocoapods/v/CountDownTimeAgoLabel.svg?style=flat)](http://cocoapods.org/pods/CountDownTimeAgoLabel)
[![License](https://img.shields.io/cocoapods/l/CountDownTimeAgoLabel.svg?style=flat)](http://cocoapods.org/pods/CountDownTimeAgoLabel)
[![Platform](https://img.shields.io/cocoapods/p/CountDownTimeAgoLabel.svg?style=flat)](http://cocoapods.org/pods/CountDownTimeAgoLabel)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* Swift 2.0

## Installation

CountDownLabel is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CountDownLabel"
```

## Author

Martin Kluska, martin.kluska@imakers.cz

## License

CountDownLabel is available under the MIT license. See the LICENSE file for more info.

## Usage

Import the module

    import CountDownTimeAgoLabel

When the date is set to label/countdown objects, the timer will start (if the formatter is set). You can create `CountDown` object for a custom UI or you can create a `CountDownLabel` with automatic text updating

Via own delegate 

    let countDown = CountDown(aDelegate: self)
    countDown.date = NSDate(...)

    ...
    func countDownChanged(countDown: CountDown, format: String) {
        testLabel.text = format
    }

Via label (code)

    let label = CountDownLabel(frame: CGRectZero)
    ...
    label = NSDate(...)

Manualy start the timer

    let countDown = CountDown(aDelegate: self)
    countDown.autoStartOnDate = false
    countDown.date = NSDate(...)
    countDown.start()
    ...
    countDown.stop()


### Formattes styles (with CountDownBaseFormatter)

In default uses the CountDownBaseFormatter with custom styles for date or time.

You can set it by accessing the formatter object.

    let formatter = countDown.formatter as? CountDownBaseFormater
    formatter?.dateStyle = .Full // this value is default
    formatter?.timeStyle = .Full // this value is default

**CountDownFormatStyle**

Renders the part of date/time in given style

* .Full:  Shows full style with localized string: 2 seconds
* .ISO:   Shows the ISO format: 12:30:23
* .Short: Shows the shorten version of string: 2m 2s
* .None:  The rendering is skipped

### CountDown logic

You can set the logic how the label is rendered by setting the `countDown.logic` 


**CountDownLogic**

* .Static: Show only current time diff in selected format
* .CountDown: Count downs to the end date
* .Automatic: Supports future/past diff times


### IB Interface
Drag a UILabel to your view and set the class to `CountDownLabel`. In your attributes tab you can change the 
settings for the label. This will change the countdowns properties.

You can access the labels CountDown object via `label.countDown`.

#### Logic

* automatic
* static
* countdown

#### style
* full
* iso
* short
* none

## CountDown

**You can set:**

* date
* timeInterval *for the timer*
* autoStartOnDate *to turn on/off automatic start on date set*
* formatter *for formatting the date*
* delegate *to respond on changes*
* logic *to decide which timer logic to use*
* finishedMessage *to customize the finish text*
* hasFinished

**You can call:**

* start() *to create timer and trigger formating*
* stop() *to end the timer*
* currentFormat() *to return current text*
* updateCountDown *to trigger update*

## CountDownLabel

**You can set:**

* date *to set the starting date and trigger start*
* onFinishBlock *to handle the finish of the countdown*
* prefixText and suffixText to add custom text format, must add a space if desired

**You can call:**

All UILabel methods, also you can access to the countDown instance via `label.countDown`

## Todo
- update readme with how to
- change the example project
- add suport for "ago" text with custom stringsdict (becouse of czech language)
- add more languages
- add custom ISO formats
- *unit tests*

## Customizations

You can create a custom style logic for the base formatter (`CountDownBaseFormatter`) by using `CountDownStyleProtocol` or you can create your own formatter via protocol `CountDownFormatProtocol`

## Contributions

Are welcome :) 
