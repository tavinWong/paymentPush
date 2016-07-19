//
//  PaymentItemCell.swift
//  paymentPush
//
//  Created by tianyuwang on 7/8/16.
//  Copyright © 2016 tianyu. All rights reserved.
//

import UIKit

class PaymentItemCell: UITableViewCell {
    @IBOutlet weak var paymentTitle: UILabel!
    @IBOutlet weak var paymentTime: UILabel!
    @IBOutlet weak var paymentAmount: UILabel!

    func updateWithPaymentItem(item:PaymentItem) {
        self.paymentTitle.text = item.title
        self.paymentTime?.text = DateParser.displayString(fordate:item.date)
        self.paymentAmount.text = String(item.amount)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
