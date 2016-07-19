//
//  PaymentStore.swift
//  paymentPush
//
//  Created by tianyuwang on 7/6/16.
//  Copyright © 2016 tianyu. All rights reserved.
//

import Foundation
import UIKit

class PaymentStore: NSObject {
    static let sharedStore = PaymentStore()
    
    var items: [PaymentItem] = []
    
    override init() {
        super.init()
        self.loadItemsFromCache()
    }
    
    func addItem(newItem: PaymentItem) {
        items.insert(newItem, atIndex: 0)
        saveItemsToCache()
    }
}

extension PaymentStore {
    func saveItemsToCache(){
        NSKeyedArchiver.archiveRootObject(items, toFile: itemsCachePath)
    }
    func loadItemsFromCache() {
        if let cachedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(itemsCachePath) as? [PaymentItem]{
            items = cachedItems
        }
    }
    
    var itemsCachePath: String {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let fileURL = documentsURL.URLByAppendingPathComponent("news.dat")
        return fileURL.path!
    }
}