//
//  DashboardCookViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Kaustubh Kulkarni on 26/07/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

class DashboardCookViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initiolize()
    }
    
    func initiolize() {
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Cook")
    }
}
