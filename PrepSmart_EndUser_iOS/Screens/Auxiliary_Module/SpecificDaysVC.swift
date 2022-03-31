//
//  SpecificDaysVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 11/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//

import UIKit

protocol CustomSpecifyDaysVCDelegate {
    func onClickApplyButton()
}


class SpecificDaysVC: UIViewController {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var mondayView: UIView!
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var mondayCheckBoxView: BEMCheckBox!
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var TuesdayView: UIView!
    @IBOutlet weak var tuesdayLabel: UILabel!
    @IBOutlet weak var tuesdayCheckBoxView: BEMCheckBox!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayView: UIView!
    @IBOutlet weak var wednesdayLabel: UILabel!
    @IBOutlet weak var wednesdayCheckBoxView: BEMCheckBox!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayView: UIView!
    @IBOutlet weak var thursdayLabel: UILabel!
    @IBOutlet weak var thursdayCheckBoxView: BEMCheckBox!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayView: UIView!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var fridayCheckBoxView: BEMCheckBox!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayView: UIView!
    @IBOutlet weak var saturdayLabel: UILabel!
    @IBOutlet weak var saturdayCheckBoxView: BEMCheckBox!
    @IBOutlet weak var saturdayButton: UIButton!
    @IBOutlet weak var sundayView: UIView!
    @IBOutlet weak var sundayLabel: UILabel!
    @IBOutlet weak var sundayCheckBoxView: BEMCheckBox!
    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var applyButton: UIButton!
    
    
    var selectedDays : [Int] = []
    var customDelegate : CustomSpecifyDaysVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
        // Do any additional setup after loading the view.
    }
    
    
    func initialization(){
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        self.backView.layer.cornerRadius = 10
        
        mondayCheckBoxView.boxType = .square
        tuesdayCheckBoxView.boxType = .square
        wednesdayCheckBoxView.boxType = .square
        thursdayCheckBoxView.boxType = .square
        fridayCheckBoxView.boxType = .square
        saturdayCheckBoxView.boxType = .square
        sundayCheckBoxView.boxType = .square
        
        applyButton.layer.cornerRadius = applyButton.frame.height/2
    }
    
    
    @IBAction func onClickCloseButton(_ sender: UIButton) {
        
        self.removeAnimation()
        
    }
    
    @IBAction func onClickWeekButton(_ sender: UIButton) {
        
        let clickButton = sender.tag
        
        if selectedDays.contains(clickButton) == false{
            selectedDays.append(clickButton)
            
            if clickButton == 0{
                mondayCheckBoxView.setOn(true, animated: true)
            }
            else if clickButton == 1{
                tuesdayCheckBoxView.setOn(true, animated: true)
            }
            else if clickButton == 2{
                wednesdayCheckBoxView.setOn(true, animated: true)
            }
            else if clickButton == 3{
                thursdayCheckBoxView.setOn(true, animated: true)
            }
            else if clickButton == 4{
                fridayCheckBoxView.setOn(true, animated: true)
            }
            else if clickButton == 5{
                saturdayCheckBoxView.setOn(true, animated: true)
            }
            else if clickButton == 6{
                sundayCheckBoxView.setOn(true, animated: true)
            }
            
            print(selectedDays)
            
        }else{
            
            //            selectedDays.remove(at: clickButton)
            if selectedDays.contains(clickButton) == true{
                
                let index = selectedDays.firstIndex(of: clickButton)!
                selectedDays.remove(at: index)
                
                if clickButton == 0{
                    mondayCheckBoxView.setOn(false, animated: true)
                }
                else if clickButton == 1{
                    tuesdayCheckBoxView.setOn(false, animated: true)
                }
                else if clickButton == 2{
                    wednesdayCheckBoxView.setOn(false, animated: true)
                }
                else if clickButton == 3{
                    thursdayCheckBoxView.setOn(false, animated: true)
                }
                else if clickButton == 4{
                    fridayCheckBoxView.setOn(false, animated: true)
                }
                else if clickButton == 5{
                    saturdayCheckBoxView.setOn(false, animated: true)
                }
                else if clickButton == 6{
                    sundayCheckBoxView.setOn(false, animated: true)
                }
                print(selectedDays)
                
            }
        }
    }
    
    
    @IBAction func onClickApplyButton(_ sender: UIButton) {
        if customDelegate != nil {
            self.customDelegate.onClickApplyButton()
            self.removeAnimation()
        }else{
            self.removeAnimation()
        }
    }
}
