//
//  PaymentVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by m@k on 25/03/22.
//  Copyright © 2022 Exceptionaire.co. All rights reserved.
//

import UIKit
import Stripe
class PaymentVC: UIViewController {
    
    @IBOutlet weak var lblAmount:UILabel!
    @IBOutlet weak var viewBack:UIView!
    @IBOutlet weak var viewPopUp:UIView!
  //  @IBOutlet weak var tfPayment:STPInputTextField!

    var amount:Int = 0
    var duration:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
}

extension PaymentVC {
    func initialSetUp(){
        lblAmount.text = "$\(String(amount))"
        viewPopUp.layer.cornerRadius = 20
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewBack.addGestureRecognizer(tap)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }

}
