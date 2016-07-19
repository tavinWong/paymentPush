//
//  PaymentItem.swift
//  paymentPush
//
//  Created by tianyuwang on 7/6/16.
//  Copyright © 2016 tianyu. All rights reserved.
//

import Foundation
import UIKit

final class PaymentItem: NSObject {
    let title: String
    let date: NSDate
    let amount: Int
    
    init(title: String, date: NSDate, amount: Int){
        self.title = title
        self.date = date
        self.amount = amount
    }
}

extension PaymentItem: NSCoding {
    struct CodingKeys {
        static let Title = "title"
        static let Date = "date"
        static let Amount = "amount"
    }
    convenience init?(coder aDecoder: NSCoder) {
        if let title = aDecoder.decodeObjectForKey(CodingKeys.Title) as? String,
            let date = aDecoder.decodeObjectForKey(CodingKeys.Date) as? NSDate,
            let amount = aDecoder.decodeObjectForKey(CodingKeys.Amount) as? Int {
            self.init(title: title, date: date, amount: amount)
        } else {
            return nil
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(title, forKey: CodingKeys.Title)
        aCoder.encodeObject(date, forKey: CodingKeys.Date)
        aCoder.encodeObject(amount, forKey: CodingKeys.Amount)
    }
}