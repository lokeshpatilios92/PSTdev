//
//  ViewNutritionalInfoViewController.swift
//  PrepSmart_ETPL
//
//  Created by Sanket ETPL on 24/06/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
import Popover

class ViewNutritionalInfoViewController: UIViewController {

    @IBOutlet weak var tblView_nutritionalInfo: UITableView!
    @IBOutlet weak var constraintTblViewHT: NSLayoutConstraint!
    @IBOutlet weak var scrollView_inner: UIScrollView!
    
    var parentVC : UIViewController?
    
    let macroCounterForDayTableViewCell = "MacroCounterForDayTableViewCell"
    let nutritionCollectionViewCell = "NutritionCollectionViewCell"
    
    var arrTitleData = ["Breakfast", "Lunch"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialize()
    }
    
    func initialize()
    {
        if parentVC != nil
        {
            self.scrollView_inner.delegate = parentVC as? UIScrollViewDelegate
            self.scrollView_inner.isScrollEnabled = false
        }
        
        tblView_nutritionalInfo.dataSource = self
        tblView_nutritionalInfo.delegate = self
    
        tblView_nutritionalInfo.register(UINib.init(nibName: macroCounterForDayTableViewCell, bundle: nil), forCellReuseIdentifier: macroCounterForDayTableViewCell)
    }
    
    override func viewWillLayoutSubviews() {
        DispatchQueue.main.async {
            self.constraintTblViewHT.constant = self.tblView_nutritionalInfo.contentSize.height
        }
    }
    
    @objc func onClickInfo(_ sender: UIButton) {
//        let aView = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 350))
//
//        let infoLabel = UILabel(frame: CGRect(x: 20, y: 20, width: aView.frame.width - 40, height: 300))
//        infoLabel.numberOfLines = 0
//        infoLabel.lineBreakMode = .byWordWrapping
//        infoLabel.font = UIFont.REGULAR_FONT_SMALLEST()
//        infoLabel.textColor = .textColor()
//        infoLabel.text = "Updated values will be based on the ingredients entered. Save and view your updated estimated Nutritional Information in the next screen."
//        infoLabel.sizeToFit()
//        infoLabel.frame = CGRect(x: infoLabel.frame.origin.x, y: infoLabel.frame.origin.y, width: infoLabel.frame.width, height: infoLabel.frame.height)
//
//        let y = infoLabel.frame.height
//
//        aView.addSubview(infoLabel)
//        aView.frame = CGRect(x: aView.frame.origin.x, y: aView.frame.origin.y, width: aView.frame.width, height: y + 20)
//
//        let popoverOptions: [PopoverOption] = [
//            .type(.auto),
//            .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
//        ]
//
//        let popover = Popover(options: popoverOptions)
//        popover.show(aView, fromView: sender)
        
        let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "DetailedNutritionalInfoViewController") as! DetailedNutritionalInfoViewController
        parentVC?.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewNutritionalInfoViewController : UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitleData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let headerViewCell = tableView.dequeueReusableCell(withIdentifier: macroCounterForDayTableViewCell) as! MacroCounterForDayTableViewCell
        headerViewCell.colView_nutrition.dataSource = self
        headerViewCell.colView_nutrition.delegate = self
        headerViewCell.colView_nutrition.tag = indexPath.row
        headerViewCell.colView_nutrition.register(UINib.init(nibName: nutritionCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: nutritionCollectionViewCell)
        headerViewCell.lbl_separator.isHidden = true
        headerViewCell.btn_info.isHidden = true
        
        if indexPath.row == 0
        {
            headerViewCell.lbl_title.text = "Nutritional Info"
            headerViewCell.btn_info.isHidden = false
            headerViewCell.btn_info.addTarget(self, action: #selector(onClickInfo(_:)), for: .touchUpInside)
        }
        else
        {
            headerViewCell.lbl_title.text = "Pair it with"
            headerViewCell.btn_info.isHidden = true
        }
        
        return headerViewCell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15.0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        return footerView
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = UIStoryboard.RecipeStoryboard.instantiateViewController(withIdentifier: "DetailedNutritionalInfoViewController") as! DetailedNutritionalInfoViewController
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewNutritionalInfoViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NutritionCollectionViewCell", for: indexPath) as! NutritionCollectionViewCell
        
        if collectionView.tag == 0
        {
            cell.imgView_recipe.isHidden = true
            cell.progressView.isHidden = false
            cell.progressView.maxValue = 1000.0
            cell.progressView.value = 500.0
        }
        else
        {
            cell.imgView_recipe.isHidden = false
            cell.progressView.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100.0, height: 140.0)
    }
}
