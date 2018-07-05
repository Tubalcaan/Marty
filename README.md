<h3 align="center"><img src="marty_logo.png" width=300></h3>
<br>

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-green.svg?style=flat)](https://github.com/Carthage/Carthage)
<!--[![Cocoapods compatible](https://img.shields.io/badge/Cocoapods-compatible-green.svg?style=flat)](https://github.com/CocoaPods/CocoaPods)-->

[![Swift 4](https://img.shields.io/badge/Swift-4.1-blue.svg?style=flat)](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/GuidedTour.html)
[![iOS 9](https://img.shields.io/badge/iOS->=9.0-blue.svg?style=flat)](https://en.wikipedia.org/wiki/IOS_9)
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Version 1.0](https://img.shields.io/badge/release-1.0-ff69b4.svg?style=flat)]()

# Marty
Marty helps you travel backward and forward in time when using Dates in your applications.

The idea is to provide a light set of APIs that allow you to add and substract a date interval to the date you're manipulating.
By doing this, you get a new date that has been shifted to past or future.

### Getting easy dates
You can easily get common dates

```Swift
Date.now // returns a date equivalent to Date()
Date.tomorrow // returns the date of the day after now
Date.yesterday // returns the date of the day before now
```

### Get a date from now
Very easy and quite useless until Date.now, but you can do much harder calculations with a smooth, simple and readable syntax.
Let's start simple:
```Swift
24.minutes.ago // returns now minus 24 minutes
2.hours.fromNow // returns now plus 2 hours
```

### Get a shifted date from an existing date
Let's say you're handling a date in your code (sorry for the forced unwrapping, don't do that at home, kids)

```Swift
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
let date = dateFormatter.date(from: "2018-06-20 09:30")! // happy birthday to me :)
```

You can now get dates relative to this date very easily. Let's have a few examples:

```Swift
2.days.before(date) // returns exactly what it says, ie 18th of June at 09:30 AM
10.minutes.after(date) // returns 20th of June at 09:40 AM
```

OK, this is cool, but we can do much better:

```Swift
date - 2.months // returns 20th of April at 09:30 AM
date + 6.years // returns 20th of June 2024 at 09:30 AM

// And you can combine many units
date + 5.months - 4.minutes // returns 20th of November at 09:26 AM, believe me or do the maths ;)

// You can store the date interval in a variable and use it later
let futureDateInterval = 2.weeks + 2.days - 30.minutes
date + futureShift // returns 6th of July at 09:00 AM
```

### TimeInterval
You can get a TimeInterval very easily from your date interval. It is more readable than the old 60 * 60 * ...

```Swift
18.seconds.timeInterval // returns 18
60.minutes.timeInterval // returns 3600
(60.minutes + 18.seconds).timeInterval // returns 3618

// You could also do this way
TimeInterval(60.minutes) // returns 3600

// You may use it to animate UIViews
UIView.animate(withDuration: 300.milliseconds.timeInterval) {
    // do something
}

```
<!--
# ⚙️ Installation
## Carthage
To install, simply add the following lines to your Cartfile :
```ruby
github "Tubalcaan/Navigable" ~> 1.2
```
## Cocoapods
To install, simply add the following lines to your Podfile :
```ruby
pod 'Navigable', :git => 'https://github.com/Tubalcaan/Navigable.git', :tag => '1.2'
```
-->
