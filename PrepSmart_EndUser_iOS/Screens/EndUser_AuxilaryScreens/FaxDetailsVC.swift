//
//  FaxDetailsVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 12/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class FaxDetailsVC: BaseViewController,ConsultationCompletePopUpDelegate {
    
    @IBOutlet weak var countryCodeLbl: UILabel!
    @IBOutlet weak var fromCompanyNameTxtField: KKNEWTextFiled!
    @IBOutlet weak var faxNoTxtField: KKNEWTextFiled!
    @IBOutlet weak var toNameTxtField: KKNEWTextFiled!
    @IBOutlet weak var businessNameTxtField: KKNEWTextFiled!
    @IBOutlet weak var memoTxtView: IQTextView!
    @IBOutlet weak var fromPhoneTxtField: KKNEWTextFiled!
    @IBOutlet weak var fromNametxtField: KKNEWTextFiled!
    @IBOutlet weak var sendFaxBtn: UIButton!
    
    
    
    var dialCode = "+91"
    var countryName = "India"
    var timeZome = "Asia/Kolkata"
    var countryList = CountryList()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intializer()
    }
    
    func intializer(){
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Fax Details")
        self.countryCodeLbl.text = "🇮🇳"
        memoTxtView.layer.cornerRadius = 5
        memoTxtView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 0.5)
        memoTxtView.layer.borderWidth = 1
        sendFaxBtn.layer.cornerRadius = sendFaxBtn.frame.height/2
        countryList.delegate = self
        
        
        self.fromCompanyNameTxtField.setLeftPaddingPoints(10.0)
        self.toNameTxtField.setLeftPaddingPoints(10.0)
        self.businessNameTxtField.setLeftPaddingPoints(10.0)
        self.fromPhoneTxtField.setLeftPaddingPoints(10.0)
        self.fromNametxtField.setLeftPaddingPoints(10.0)
        
    }
    @IBAction func flagBtnTapped(_ sender: UIButton) {
        let navController = UINavigationController(rootViewController: countryList)
        self.present(navController, animated: true, completion: nil)
    }
    
    @IBAction func sendFaxTapped(_ sender: UIButton) {
        print("Send FAX Button Clicked")
        self.showConsultationCompletePopUp(lbl_text: "Your fax has been added to the queue. Please check your email for confirmation.", bottomButton: "OK", customDelegate: self)
    }
    
    
}


extension FaxDetailsVC : CountryListDelegate
{
    func selectedCountry(country: Country) {
        self.countryCodeLbl.text = "\(country.flag ?? "")"
        // self.dialCode = "\(country.phoneExtension )"
        //self.countryName = "\(country.name ?? "")"
    }
}
