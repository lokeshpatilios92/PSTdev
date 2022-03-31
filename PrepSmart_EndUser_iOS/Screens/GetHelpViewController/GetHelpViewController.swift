//
//  GetHelpViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 09/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//  Screen Id : PSTMOBSTD158

import UIKit

class GetHelpViewController: UIViewController,UITextFieldDelegate,UISearchBarDelegate {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var txt_search: UITextField!
    @IBOutlet var view_search: UIView!
    @IBOutlet var height_tbl: NSLayoutConstraint!
    @IBOutlet var tbl_helpContent: UITableView!
    @IBOutlet var btn_cancel: UIButton!
    @IBOutlet var btn_save: UIButton!
    
    var arr_headerTitle = [String]()
    var arr_cellTitle = [String]()
    var arr_isHeaderBtnClicked = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       initialize()
    }
    
    func initialize()
    {
        
        btn_save.layer.cornerRadius = btn_save.frame.size.height / 2
        btn_cancel.layer.borderWidth = 1.0
        btn_cancel.layer.borderColor = UIColor.appOrangeColor().cgColor
        btn_cancel.layer.cornerRadius = btn_cancel.frame.size.height / 2
        
         tbl_helpContent.register(UINib.init(nibName: "HelpHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "HelpHeaderView")
        
        tbl_helpContent.register(UINib.init(nibName: "ContactSupportHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ContactSupportHeaderView")
        
         tbl_helpContent.register(UINib.init(nibName: "HelpVCTableCell", bundle: nil), forCellReuseIdentifier: "HelpVCTableCell")
        
          self.tbl_helpContent.delegate = self
          self.tbl_helpContent.dataSource = self
          self.tbl_helpContent.reloadData()
          self.tbl_helpContent.estimatedRowHeight = 100.0
          self.tbl_helpContent.rowHeight = UITableView.automaticDimension
        
          arr_headerTitle = ["Recommeneded Topics","All Topics","Still Need Help"/*,"Subject"*/]
          arr_cellTitle = ["Getting Started","Booking","Payment","Your Account"]
        
        for i in arr_headerTitle.enumerated()
        {
            print(i)
            arr_isHeaderBtnClicked.append(false)
        }
        
        txt_search.delegate = self
        view_search.layer.borderWidth = 1.0
        view_search.layer.cornerRadius = view_search.frame.size.height / 2
        view_search.layer.borderColor = UIColor.init(red: 234.0/255.0, green: 232.0/255.0, blue: 233.0/255.0, alpha: 1.0).cgColor
     
        searchBarSetup()
    }
    
    func searchBarSetup()
    {
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.delegate = self
        searchBar.isTranslucent = false
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        searchBar.setImage(#imageLiteral(resourceName: "scarch_orange"), for: .search, state: .normal)
        searchBar.layer.cornerRadius = 0
        searchBar.backgroundImage = UIImage()
        searchBar.clipsToBounds = true
        let textFieldInsideSearchBar = self.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = UIColor.white
        textFieldInsideSearchBar?.textColor = UIColor.textColorDarkGray()
        textFieldInsideSearchBar?.font = UIFont.init(name: "ENGCARNATION", size: 14.0)
        searchBar.backgroundColor = UIColor.white
    }
    
    
    @IBAction func onClickBtnCancel(_ sender: UIButton) {
        
    }
    
    @IBAction func onClickBtnSave(_ sender: UIButton) {
        
    }
    
    @IBAction func onClickBtnContactSupport(_ sender: UIButton) {
        
    }
    
    @IBAction func onClickBtnHeader(_ sender: UIButton) {
        if(arr_isHeaderBtnClicked[sender.tag] == true)
        {
            arr_isHeaderBtnClicked[sender.tag] = false
        }
        else
        {
            arr_isHeaderBtnClicked[sender.tag] = true
        }
        self.tbl_helpContent.reloadData()
        self.height_tbl.constant = self.tbl_helpContent.contentSize.height
        self.view.setNeedsLayout()
    }
    
    
    //MARK:TextField Delegate Methods
//    @IBAction func textFiledEditingChanged(_ sender: UITextField) {
//
//
//    }
    
}


extension GetHelpViewController : UITableViewDataSource,UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return arr_headerTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(arr_isHeaderBtnClicked[section] == true)
        {
            return arr_cellTitle.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HelpVCTableCell", for: indexPath) as! HelpVCTableCell
        cell.lbl_title.text = arr_cellTitle[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section == 2)
        {
            return 80
        }
        else
        {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if(section == 2)
        {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ContactSupportHeaderView") as! ContactSupportHeaderView
            headerView.btn_contactSupport.tag = section

            return headerView
        }
        else
        {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HelpHeaderView") as! HelpHeaderView
            headerView.btn_header.tag = section
            headerView.lbl_title.text = arr_headerTitle[section]
            
            if(arr_isHeaderBtnClicked[section] == true)
            {
                headerView.imgView_arrow.image = UIImage.init(named: "drop_arrow")
            }
            else
            {
                headerView.imgView_arrow.image = UIImage.init(named: "forward_arrow")
            }
            
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last {
            if indexPath == lastVisibleIndexPath {
                self.height_tbl.constant = self.tbl_helpContent.contentSize.height
            }
        }
    }
    
}
