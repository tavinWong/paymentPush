//
//  DateParser.swift
//  paymentPush
//
//  Created by tianyuwang on 7/7/16.
//  Copyright © 2016 tianyu. All rights reserved.
//

import UIKit

class DateParser: NSObject {
    static let dateFormatter = { (void) -> NSDateFormatter in
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        return formatter
    }()
    
    //Wed, 04 Jul 2016 21:00:14 +0000
    static func dateWithPodcastDateString(dateString: String) -> NSDate? {
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
        return dateFormatter.dateFromString(dateString)
    }
    
    static func displayString(fordate date: NSDate) -> String {
        dateFormatter.dateFormat = "HH:mm MMMM dd, yyyy"
        return dateFormatter.stringFromDate(date)
    }
}