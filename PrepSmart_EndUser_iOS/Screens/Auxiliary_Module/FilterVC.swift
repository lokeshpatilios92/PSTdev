//
//  FilterVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 09/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Popover



class FilterVC: BaseViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topTileLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    
    let filterTableCell = "FilterTableCell"
    var FilterDelegate : CustomSpecifyDaysVCDelegate!
    var dataArray : [String] = []
    var filterType : String = ""
    var startDate : String = ""
    var endDate : String = ""
    var specificDayString : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
        // Do any additional setup after loading the view.
    }
    
    func initialize() {
        
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Filter")
        
        let lastMondayDate = DateToString(date: Date.today().previous(.monday, considerToday: true))
        let nextSundayDate = DateToString(date: Date.today().next(.sunday, considerToday: true))
        
        let nextMondayDate = DateToString(date: Date.today().next(.monday, considerToday: true))
        let nexttonextSundayDate = DateToString(date: Date.today().next(.monday, considerToday: false).next(.sunday, considerToday: false))
        dataArray = ["Today",
                     "Tomorrow",
                     "Next 3 days",
                     "Next 5 days",
                     "Current Week (Mon \(lastMondayDate) - Sun \(nextSundayDate))",
                     "Next Week (Mon \(nextMondayDate) - Sun \(nexttonextSundayDate)",
                     "Specific Date Range",
                     "Specific Days"]
        
        tableView.register(UINib.init(nibName: filterTableCell, bundle: nil), forCellReuseIdentifier: filterTableCell)
        
        applyButton.layer.cornerRadius = applyButton.frame.height/2
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.backgroundColor = UIColor.white
    }
    
   
    @IBAction func onClickApplyButton(_ sender: UIButton) {
        print(filterType)
        if filterType != ""{
        FilterDelegate.onClickApplyButton(filterType: filterType, startdate: startDate, endDate: endDate, specificDays: specificDayString)
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func onClickInfoButton(_ sender: UIButton) {
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
        
        let infoLabel = UILabel(frame: CGRect(x: 20, y: 20, width: aView.frame.width - 40, height: 300))
        infoLabel.numberOfLines = 0
        infoLabel.lineBreakMode = .byWordWrapping
        infoLabel.font = UIFont.REGULAR_FONT_SMALLEST()
        infoLabel.textColor = .textColor()
        infoLabel.text = "Simply choose the date range you would like to shop for and items for recipes outside that range will be filtered out temporarily."
        infoLabel.sizeToFit()
        infoLabel.frame = CGRect(x: infoLabel.frame.origin.x, y: infoLabel.frame.origin.y, width: infoLabel.frame.width, height: infoLabel.frame.height)
        
        let y = infoLabel.frame.height
        
        aView.addSubview(infoLabel)
        aView.frame = CGRect(x: aView.frame.origin.x, y: aView.frame.origin.y, width: aView.frame.width, height: y + 20)
        
        let popoverOptions: [PopoverOption] = [
            .type(.auto),
            .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
        ]
        
        let popover = Popover(options: popoverOptions)
        popover.show(aView, fromView: infoButton)
    }
    
    
}

extension FilterVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: filterTableCell, for: indexPath) as! FilterTableCell
        cell.titleLabel.text = dataArray[indexPath.row]
        
        if indexPath.row == dataArray.count - 1{
            cell.borderLabel.isHidden = true
        }else{
            cell.borderLabel.isHidden = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FilterTableCell
        cell.leftImage.image = #imageLiteral(resourceName: "radio_active")
        filterType = "\(indexPath.row+1)"
        if indexPath.row == 6{
            self.showSelectDateRangeVC(btn_text: "Select", customDelegate: self)
        }else if indexPath.row == 7{
            self.showSpecifyDaysVC(customDelegate: self)
        }else if indexPath.row == 4{
            //Call ShowCalendarViewController
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

        let cell = tableView.cellForRow(at: indexPath) as! FilterTableCell
        cell.leftImage.image = #imageLiteral(resourceName: "radio_normal")

    }
}

extension FilterVC : CustomSelectDateRangeVCDelegate, CustomSpecifyDaysVCDelegate{
    func onClickApplyButton(filterType: String, startdate: String, endDate: String, specificDays: String) {
    print("\(filterType),\(startdate), \(endDate) , \(specificDays)")
        self.filterType = filterType
        startDate = startdate
        startDate = endDate
        specificDayString = specificDays
    }
    
    func onClickSelectButtonAction(startDate: String?, endDate: String?, startDay: String?, endDay: String?) {
        print ("startDate\(startDate) endDate\(endDate)")
    }
}
