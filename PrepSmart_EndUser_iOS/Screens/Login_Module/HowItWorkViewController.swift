//
//  HowItWorkViewController.swift
//  PrepSmart_ETPL
//
//  Created by Kaustubh Kulkarni on 28/05/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD008

import UIKit
import SwiftyOnboard

class HowItWorkViewController: BaseViewController {
    @IBOutlet var scrollView:UIScrollView!
    @IBOutlet weak var swiftyOnboard: SwiftyOnboard!
    
//    @IBOutlet var nextButton:UIButton!
//    @IBOutlet var carouselLabel:UILabel!
//    @IBOutlet var pageControl:UIPageControl!
    let global_Var = GlobalClass.sharedManager
    let contentListArray : [String] = ["There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet.","There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet.", "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.dismissKeyboardOnTap()
        addKeyboardNotificationObserver()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotificationObserver()
    }
    
    func initialize() {
        
        self.navigationItem.titleView = UtilityManager.getTitleLabel("How It Works")
        swiftyOnboard.style = .light
        swiftyOnboard.delegate = self
        swiftyOnboard.dataSource = self
        
//        self.nextButton.layer.cornerRadius = self.nextButton.frame.height / 2
//        self.nextButton.layer.borderWidth = 1
//        self.nextButton.layer.borderColor = UIColor.white.cgColor
    }
    
    //    MARK: On Click Func
    @objc func handleSkip() {
        let vc = UIStoryboard.AuxiliaryStoryboard.instantiateViewController(withIdentifier: "DietTypeNavigationViewController" )
        self.revealViewController()?.setFront(vc, animated: true)
    }
    
    @objc func handleContinue(sender: UIButton) {
        let index = sender.tag
        
        if index == 2 {
           self.handleSkip()
        } else {
          swiftyOnboard?.goToPage(index: index + 1, animated: true)
        }
    }
    
//    @IBAction func onClickNextButton(_ sender: Any) {
//    }
//
//    @IBAction func onClickSkipButton(_ sender: Any) {
//    }
    
    
    
}

extension HowItWorkViewController : SwiftyOnboardDelegate, SwiftyOnboardDataSource {
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        return self.global_Var.contentArr.count
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let view = CustomPage.instanceFromNib() as? CustomPage
        view?.image.image = #imageLiteral(resourceName: "breakfast_white")
        view?.leftImgView.image = #imageLiteral(resourceName: "plan")
        view?.rightImageView.image = #imageLiteral(resourceName: "cook")
        if index == 0 {
            //On the first page, change the text in the labels to say the following:
            view?.titleLabel.text = "Why sell on Prepsmart"
            view?.subTitleLabel.text = self.global_Var.contentArr[index]
        } else if index == 1 {
            //On the second page, change the text in the labels to say the following:
            view?.titleLabel.text = "Why sell on Prepsmart 1"
            view?.subTitleLabel.text = self.global_Var.contentArr[index]
        } else {
            //On the thrid page, change the text in the labels to say the following:
            view?.titleLabel.text = "Why sell on Prepsmart 2"
            view?.subTitleLabel.text = self.global_Var.contentArr[index]
        }
        return view
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = CustomOverlay.instanceFromNib() as? CustomOverlay
        overlay?.skip.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        overlay?.buttonContinue.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        return overlay
    }
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        
        let overlay = overlay as! CustomOverlay
        let currentPage = round(position)
        
//        overlay.pageControl.currentPage = Int(currentPage)
        overlay.contentControl.currentPage = Int(currentPage)
        overlay.buttonContinue.tag = Int(position)
        
        if currentPage == 0.0 || currentPage == 1.0 {
            overlay.buttonContinue.setTitle("NEXT", for: .normal)
            overlay.skip.setTitle("Skip", for: .normal)
            overlay.skip.isHidden = false
        } else {
            overlay.buttonContinue.setTitle("GET Started !".uppercased(), for: .normal)
            overlay.skip.isHidden = true
        }
    }
    
    // MARK:- Keyboard Methods
    override func keyboardDidShow(notification: Notification) {
        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight - Constants.marginConstant , right: 0)
    }
    
    override func keyboardDidHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0 , right: 0)
    }
}
