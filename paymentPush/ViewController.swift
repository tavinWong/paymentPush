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
    let defaultBalance = 2000
    var tempAmount = 0
    
    @IBAction func clearBtn(sender: UIButton) {
        tempAmount = 0
        self.remainBalance.text = String(2000)
        paymentStore.items.removeAll()
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation:.Automatic)
    }
    @IBOutlet weak var remainBalance: UILabel!
    
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
        tempAmount = 0
        return paymentStore.items.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("pCell", forIndexPath: indexPath) as! PaymentItemCell
        cell.updateWithPaymentItem(paymentStore.items[indexPath.row])
        tempAmount += paymentStore.items[indexPath.row].amount
        /**
        print("----------indexpath.row-----")
        tempAmount += paymentStore.items[indexPath.row].amount
        print(tempAmount)
        **/
        self.remainBalance.text = String(defaultBalance - tempAmount)
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        if editingStyle == .Delete{
            self.paymentStore.items.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
            print("tempAmountNow")
            print(tempAmount)
            self.remainBalance.text = String(defaultBalance - tempAmount)
        }
    }
    

}
