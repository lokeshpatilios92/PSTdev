//
//  PaymentVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by m@k on 25/03/22.
//  Copyright © 2022 Exceptionaire.co. All rights reserved.
//

import UIKit
import Stripe

protocol paymentSucesscallBack {
    func paymentSuccess(TransectionID:String, Amount:String, Type:Int, id:Int, duration:Int)
}

class PaymentVC: UIViewController {
    
    @IBOutlet weak var lblAmount:UILabel!
    @IBOutlet weak var viewBack:UIView!
    @IBOutlet weak var viewPopUp:UIView!
    @IBOutlet weak var viewContainer:UIView!
    @IBOutlet weak var payButton:UIButton!
    @IBOutlet weak var nameOnCard:UITextField!
    
    
    lazy var cardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
        return cardTextField
    }()
    
    var amount:String = "0"
    var paymentType:Int = 0 // 0 for recipe , 1 for chef , 2 plan
    var duration:Int = 0
    var delegete:paymentSucesscallBack?
    var chefId = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    
    @IBAction func payAction(_ Sender : UIButton){
        if nameOnCard.text == "" {
            Alert.show(vc: self, titleStr: "Message", messageStr: "Please enter name")
        }
        else if cardTextField.isValid == false {
            Alert.show(vc: self, titleStr: "Message", messageStr: "Please valid card details")
        }
        else {
            createPaymentToken()
        }
    }
}

extension PaymentVC {
    func initialSetUp(){
        crateCardTF()
        lblAmount.text = "$\(String(amount))"
        viewPopUp.layer.cornerRadius = 20
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewBack.addGestureRecognizer(tap)
        payButton.layer.cornerRadius =  payButton.frame.height/2
        payButton.layer.borderWidth = 1
        payButton.layer.borderColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PaymentVC {
    func crateCardTF() {
        viewContainer.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [cardTextField])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalToSystemSpacingAfter: viewContainer.leftAnchor, multiplier: 2),
            view.rightAnchor.constraint(equalToSystemSpacingAfter: stackView.rightAnchor, multiplier: 2),
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: viewContainer.topAnchor, multiplier: 2),
        ])
    }
}

extension PaymentVC {
    func createPaymentToken() {
        let cardParams = STPCardParams()
        cardParams.name = nameOnCard.text ?? ""
        cardParams.number = cardTextField.cardNumber
        cardParams.expMonth = UInt(cardTextField.expirationMonth)
        cardParams.expYear =  UInt(cardTextField.expirationYear)
        cardParams.cvc = cardTextField.cvc
        Loader.sharedInstance.showIndicator()
        STPAPIClient.shared.createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
            print("Printing Strip response:\(String(describing: token?.allResponseFields))\n\n")
            print("Printing Strip Token:\(String(describing: token?.tokenId))")
            if error != nil {
                Loader.sharedInstance.hideIndicator()
                Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error?.localizedDescription ?? "")
            }
            
            if token != nil{
                Loader.sharedInstance.hideIndicator()
                self.delegete?.paymentSuccess(TransectionID: token!.tokenId, Amount: self.amount, Type: self.paymentType, id: self.chefId ,duration: self.duration)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

