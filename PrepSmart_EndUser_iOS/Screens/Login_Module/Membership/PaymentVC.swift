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
    func paymentSuccess(TransectionID:String)
}

class PaymentVC: UIViewController {
    
    @IBOutlet weak var lblAmount:UILabel!
    @IBOutlet weak var viewBack:UIView!
    @IBOutlet weak var viewPopUp:UIView!
    @IBOutlet weak var viewContainer:UIView!
    @IBOutlet weak var payButton:UIButton!
    
    lazy var cardTextField: STPPaymentCardTextField = {
        let cardTextField = STPPaymentCardTextField()
        return cardTextField
    }()
    
    var amount:String = "0"
    var duration:Int = 0
    var delegete:paymentSucesscallBack?
    var paymentIntentStatus = AppRating_Struct()
    var chefId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    
    @IBAction func payAction(_ Sender : UIButton){
        print(cardTextField.cardNumber)
        print(cardTextField.cvc)
        print(cardTextField.expirationYear)
        print(cardTextField.expirationMonth)
        stipeconnection()
       // cratePaymentIntent()
        //        delegete?.paymentSuccess(TransectionID: "afadadssadd")
        //        self.dismiss(animated: true, completion: nil)
    }
}

extension PaymentVC {
    func initialSetUp(){
        crateCardTF()
        lblAmount.text = "$\(String(amount))"
        viewPopUp.layer.cornerRadius = 20
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewBack.addGestureRecognizer(tap)
        
        
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
    func stipeconnection() {
        let cardParams = STPCardParams()
        cardParams.name = "Jenny Rosen"
        cardParams.number = "4242424242424242"
        cardParams.expMonth = 12
        cardParams.expYear = 22
        cardParams.cvc = "424"

        let sourceParams = STPSourceParams.cardParams(withCard: cardParams)
        STPAPIClient.shared.createSource(with: sourceParams) { (source, error) in
            if let s = source, s.flow == .none && s.status == .chargeable {
                //print(s)
              //  self.createBackendChargeWithSourceID(s.stripeID)
            }
        }
    }
    
    
    
    func cratePaymentIntent() {
        let param:[String:Any] = ["payment_method_type" : 2,
                                  "amount": amount,
                                  "chef_id":chefId,
                                  "card_number": Int(cardTextField.cardNumber ?? ""),
                                  "card_exp_month":cardTextField.expirationMonth,
                                  "card_exp_year":cardTextField.expirationYear,
                                  "card_cvc":Int(cardTextField.cvc ?? "")]
        Loader.sharedInstance.showIndicator()
        Api_Http_Class.shareinstance.AlemfFireRowAPICall(methodName: Constants.chefSubscribePaymentIntent, params: param , method: .post) { (result) in
            switch result
            {
            case .success(let data, let dictionary):
                
                if let dict : NSDictionary = dictionary as? NSDictionary
                {
                    if let status = dict["status"] as? Bool, status == true
                    {
                        Loader.sharedInstance.hideIndicator()
                        do {
                            self.paymentIntentStatus = try JSONDecoder().decode(AppRating_Struct.self, from: data)
                            Alert.show(vc: self, titleStr: Alert.kTitle, messageStr: self.paymentIntentStatus.message)
                        }
                        catch
                        {
                            Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                        }
                    }
                    else
                    {
                        Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: GlobalClass.sharedManager.get_status.message)
                    }
                }
                else
                {
                    Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: GlobalClass.sharedManager.get_status.message)
                }
                Loader.sharedInstance.hideIndicator()
                break
                
            case .failer(let error):
                
                Alert.show(vc: self, titleStr: AMPLocalizeUtils.defaultLocalizer.stringForKey(key: Alert.kTitle), messageStr: error.localizedDescription)
                Loader.sharedInstance.hideIndicator()
                break
            }
        }
    }
}

