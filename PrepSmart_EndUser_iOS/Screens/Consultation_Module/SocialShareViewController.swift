//
//  SocialShareViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Sanket ETPL on 13/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class SocialShareViewController: UIViewController {

    @IBOutlet weak var view_bottom: UIView!
    @IBOutlet weak var view_share: UIView!
    @IBOutlet weak var view_pinterest: UIView!
    @IBOutlet weak var view_twitter: UIView!
    @IBOutlet weak var view_google: UIView!
    @IBOutlet weak var view_facebook: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view_share.clipsToBounds = true
        view_share.layer.cornerRadius = view_share.frame.height / 2
        
        view_bottom.clipsToBounds = true
        view_bottom.layer.cornerRadius = 4.0
        
        view_pinterest.clipsToBounds = true
        view_pinterest.layer.cornerRadius = 4.0
        
        view_twitter.clipsToBounds = true
        view_twitter.layer.cornerRadius = 4.0
        
        view_google.clipsToBounds = true
        view_google.layer.cornerRadius = 4.0
        
        view_facebook.clipsToBounds = true
        view_facebook.layer.cornerRadius = 4.0
        
    }
    
}
