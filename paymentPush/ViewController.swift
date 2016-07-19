//
//  ViewController.swift
//  paymentPush
//
//  Created by tianyuwang on 6/28/16.
//  Copyright © 2016 tianyu. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UITableViewController {
    
    static let RefreshPaymentFeedNotification = "RefreshPaymentFeedNotification"
    let paymentStore = PaymentStore.sharedStore
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 75
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(ViewController.transactionMade), name: "actionOnePressed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.transactionDeclined), name: "actionTwoPressed", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(ViewController.receivedRefreshPaymentFeedNotification(_:)), name: ViewController.RefreshPaymentFeedNotification, object: nil)
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    func receivedRefreshPaymentFeedNotification(notification: NSNotification){
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation:.Automatic)
        }
    }

    func transactionMade(notification:NSNotification){
        let successMessage:UIAlertController = UIAlertController(title: "Transaction Status", message: "The transaction has been made.", preferredStyle: UIAlertControllerStyle.Alert)
        successMessage.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(successMessage, animated: true, completion: nil)
    }
    
    func transactionDeclined(notification:NSNotification){
        let successMessage:UIAlertController = UIAlertController(title: "Transaction Status", message: "The transaction has been declined!", preferredStyle: UIAlertControllerStyle.Alert)
        successMessage.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(successMessage, animated: true, completion: nil)


    }
}

extension ViewController{
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return paymentStore.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pCell", forIndexPath: indexPath) as! PaymentItemCell
        cell.updateWithPaymentItem(paymentStore.items[indexPath.row])
        return cell
    }
    

}
