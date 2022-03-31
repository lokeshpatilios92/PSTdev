//
//  WeekPlanVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Etpl-Mac on 09/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit
@available(iOS 13.0, *)
class WeekPlanVC: BaseViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var clearAllBtn: UIButton!
    @IBOutlet var doneBtn: UIButton!
    
    let weeklyPlanCell = "WeeklyPlanCell"
    let progressContainerCell = "ProgressContainerCell"
    
    var brakfastArr = ["Cheesy Amish Breakfast Casserole","Cheesy Amish Breakfast Casserole","Cheesy Amish Breakfast Casserole","Cheesy Amish Breakfast Casserole"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializer()
       
    }
    
    
    func initializer(){
        
        self.navigationItem.titleView = UtilityManager.getTitleLabel("Weekly Plan")
        tableView.register(UINib(nibName: weeklyPlanCell, bundle: .none), forCellReuseIdentifier: weeklyPlanCell)
        tableView.register(UINib(nibName: progressContainerCell, bundle: .none), forCellReuseIdentifier: progressContainerCell)
        clearAllBtn.layer.cornerRadius = clearAllBtn.frame.height/2
        doneBtn.layer.cornerRadius = clearAllBtn.frame.height/2
        clearAllBtn.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.3098039216, blue: 0.137254902, alpha: 1)
        clearAllBtn.layer.borderWidth = 1
       
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(WeekPlanVC.longPressGestureRecognized(_:)))
        tableView.addGestureRecognizer(longpress)
    }
    
    @objc func longPressGestureRecognized(_ gestureRecognizer: UIGestureRecognizer) {
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        let state = longPress.state
        let locationInView = longPress.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: locationInView)
        
        switch state {
        case UIGestureRecognizer.State.began:
            if indexPath != nil {
                Path.initialIndexPath = indexPath
                let cell = tableView.cellForRow(at: indexPath!) as? WeeklyPlanCell
                My.cellSnapshot  = snapshotOfCell(cell!)
                var center = cell?.center
                My.cellSnapshot!.center = center!
                My.cellSnapshot!.alpha = 0.0
                tableView.addSubview(My.cellSnapshot!)
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    center?.y = locationInView.y
                    My.cellIsAnimating = true
                    My.cellSnapshot!.center = center!
                    My.cellSnapshot!.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                    My.cellSnapshot!.alpha = 0.98
                    cell?.alpha = 0.0
                }, completion: { (finished) -> Void in
                    if finished {
                        My.cellIsAnimating = false
                        if My.cellNeedToShow {
                            My.cellNeedToShow = false
                            UIView.animate(withDuration: 0.25, animations: { () -> Void in
                                cell?.alpha = 1
                            })
                        } else {
                            cell?.isHidden = true
                        }
                    }
                })
            }
        case UIGestureRecognizer.State.changed:
            if My.cellSnapshot != nil {
                var center = My.cellSnapshot!.center
                center.y = locationInView.y
                My.cellSnapshot!.center = center
                if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
                    brakfastArr.insert(brakfastArr.remove(at: Path.initialIndexPath!.row), at: indexPath!.row)
                    tableView.moveRow(at: Path.initialIndexPath!, to: indexPath!)
                    Path.initialIndexPath = indexPath
                    
                }
               
            }
        default:
            if Path.initialIndexPath != nil {
                let cell = tableView.cellForRow(at: Path.initialIndexPath!) as? WeeklyPlanCell
                if My.cellIsAnimating {
                    My.cellNeedToShow = true
                } else {
                    cell?.isHidden = false
                    cell?.alpha = 0.0
                }
                UIView.animate(withDuration: 0.25, animations: { () -> Void in
                    My.cellSnapshot!.center = (cell?.center)!
                    My.cellSnapshot!.transform = CGAffineTransform.identity
                    My.cellSnapshot!.alpha = 0.0
                    cell?.alpha = 1.0
                }, completion: { (finished) -> Void in
                    if finished {
                        Path.initialIndexPath = nil
                        My.cellSnapshot!.removeFromSuperview()
                        My.cellSnapshot = nil
                        self.tableView.reloadData()
                    }
                })
            }
        }
    }

    
    func snapshotOfCell(_ inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        let cellSnapshot : UIView = UIImageView(image: image)
        cellSnapshot.layer.masksToBounds = false
        cellSnapshot.layer.cornerRadius = 0.0
        cellSnapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
            cellSnapshot.layer.shadowRadius = 5.0
            cellSnapshot.layer.shadowOpacity = 0.4
            return cellSnapshot
    }
    
    @IBAction func clearAllTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func doneTapped(_ sender: UIButton) {
        
    }
    
    @objc func addTapped(sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! WeeklyPlanCell
        let totalCount = Int(cell.servingsCountLbl.text!)! + 1
        cell.servingsCountLbl.text = "\(totalCount)"
    }
    
    @objc func subtractTapped(sender: UIButton){
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! WeeklyPlanCell
        let totalCount = Int(cell.servingsCountLbl.text!)! - 1
        if totalCount <= 0{
           print("don't subtract it.")
        }else{
             cell.servingsCountLbl.text = "\(totalCount)"
        }
        
    }
    
    @objc func reorderTapped(sender: UIButton){
        print("reorder Tapped")
    }
    
    @objc func deleteTapped(sender: UIButton){
        print("delete tapped")
    }
}
@available(iOS 13.0, *)
extension WeekPlanVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brakfastArr.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == brakfastArr.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: progressContainerCell, for: indexPath) as! ProgressContainerCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: weeklyPlanCell, for: indexPath) as! WeeklyPlanCell
            cell.addBtn.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
            cell.subtractBtn.addTarget(self, action: #selector(subtractTapped), for: .touchUpInside)
            cell.deleteBtn.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
            cell.deleteBtn.addTarget(self, action: #selector(reorderTapped), for: .touchUpInside)
            cell.addBtn.tag = indexPath.row
            cell.subtractBtn.tag = indexPath.row
            cell.deleteBtn.tag = indexPath.row
            cell.reorderRowBtn.tag = indexPath.row
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? ProgressContainerCell else {
            print("cell is not found")
            return
        }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
@available(iOS 13.0, *)
extension WeekPlanVC : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgressViewCell", for: indexPath) as! ProgressViewCell
        return cell
    }
    
    
}
struct My {
    static var cellSnapshot : UIView? = nil
    static var cellIsAnimating : Bool = false
    static var cellNeedToShow : Bool = false
}
struct Path {
    static var initialIndexPath : IndexPath? = nil
}
