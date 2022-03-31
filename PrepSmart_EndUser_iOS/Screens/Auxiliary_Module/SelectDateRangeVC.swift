//
//  SelectDateRangeVC.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Lalit Kandi on 09/09/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//Screen ID :- 

import UIKit
import FSCalendar_Persian

protocol CustomSelectDateRangeVCDelegate {
    func onClickSelectButtonAction(startDate: String?, endDate: String?, startDay: String?, endDay: String?)
}

class SelectDateRangeVC: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var calenderView: FSCalendar!
    @IBOutlet weak var currentMonthLabel: UILabel!
    @IBOutlet weak var startDateTextField: KKNEWTextFiled!
    @IBOutlet weak var startDateImageView: UIImageView!
    @IBOutlet weak var endDateTextField: KKNEWTextFiled!
    @IBOutlet weak var endDateImageView: UIImageView!
    @IBOutlet weak var selectweekLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    var customDelegate : CustomSelectDateRangeVCDelegate!
    
    
    let dateFormatter = DateFormatter()
    var currentMonthPosition = Int()
    var selectedStartDate = Date()
    var selectedEndDate = Date()
    var btn_text : String?
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    
    var selDate_1 : Date?
    var selDate_2 : Date?
    
    
    var datesWithEvent = ["2020-02-03", "2020-02-05", "2020-02-08", "2020-02-15"]

    var datesWithMultipleEvents = ["2020-02-03", "2020-02-05", "2020-02-08", "2020-02-15"]
    
    private var datesRange: [Date]?
    
    fileprivate lazy var dateFormatterForCurrentMonth: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM yyyy"
        return formatter
    }()
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    fileprivate lazy var dayNameFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.calendar = .current
        dateFormatter.dateFormat = "cccc"
        return dateFormatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentMonthLabel.text = self.dateFormatterForCurrentMonth.string(from: Date())
        self.calendarSetup()
        self.selectButton.setTitle(btn_text, for: .normal)
        // Do any additional setup after loading the view.
    }
    
    
    func calendarSetup()
    {
        calenderView.headerHeight = 0.0
        calenderView.pagingEnabled = true
        calenderView.appearance.headerTitleFont = UIFont.init(name: "ENGCARNATION", size: 14.0)
        calenderView.appearance.titleFont = UIFont.init(name: "ENGCARNATION", size: 12.0)
        calenderView.appearance.weekdayFont = UIFont.init(name: "ENGCARNATION", size: 12.0)
        calenderView.register(FSCalendarCell.self, forCellReuseIdentifier: "cell")
        calenderView.isMultipleTouchEnabled = true
        calenderView.allowsMultipleSelection = true
        calenderView.swipeToChooseGesture.isEnabled = true
        calenderView.appearance.selectionColor = UIColor.init(red: 45.0/255.0, green: 193.0/255.0, blue: 41.0/255.0, alpha: 1.0)
        calenderView.appearance.titleSelectionColor = UIColor.white
        calenderView.appearance.todayColor = UIColor.init(red: 60.0/255.0, green: 174.0/255.0, blue: 224.0/255.0, alpha: 1.0)
        calenderView.appearance.titleTodayColor = UIColor.white
        dateFormatter.dateFormat = "dd-MM-yyyy"
        selectButton.layer.cornerRadius = selectButton.frame.size.height / 2
        calenderView.appearance.eventDefaultColor = UIColor.red
    }
    
    func getNextMonth(date:Date)->Date {
        return Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }
    
    func getPreviousMonth(date:Date)->Date {
        return Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
    
    
    @IBAction func onClickPreviousButton(_ sender: UIButton) {
        calenderView.setCurrentPage(getPreviousMonth(date: calenderView.currentPage), animated: true)
    }
    
    @IBAction func onClickNextButton(_ sender: UIButton) {
        calenderView.setCurrentPage(getNextMonth(date: calenderView.currentPage), animated: true)
    }
    
    @IBAction func onCllickSelectButton(_ sender: UIButton) {
        
        if customDelegate != nil{
            var sDay = ""
            var eDay = ""
            if selDate_1 == nil
            {
                Alert.showH(titleStr: "", messageStr: "Please select the start date")
            }
            else
            {
                sDay = dayNameFormatter.string(from: selDate_1!)
            }
            if selDate_2 == nil
            {
                Alert.showH(titleStr: "", messageStr: "Please select the end date")
            }
            else
            {
                eDay = dayNameFormatter.string(from: selDate_2!)
            }
          
            if (sDay != "") && (eDay != "")
            {
                if ((sDay == "Monday") && (eDay == "Sunday"))
                {
                    self.removeAnimation()
                    self.customDelegate.onClickSelectButtonAction(startDate: self.startDateTextField.text, endDate: self.endDateTextField.text, startDay: sDay, endDay: eDay)
                   
                }
                
                else
                {
                    Alert.showH(titleStr: "", messageStr: "Please select days from Monday to Sunday")
                }
                
            }
            
        }
        
    }
    
    @IBAction func onClickCloseButton(_ sender: UIButton) {
        self.removeAnimation()
    }
    
}


extension SelectDateRangeVC : FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {

        let dateString = self.dateFormatter2.string(from: date)

        if self.datesWithEvent.contains(dateString) {
            return 1
        }

        if self.datesWithMultipleEvents.contains(dateString) {
            return 3
        }

        return 0
    }
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        let key = self.dateFormatter2.string(from: date)
        if (self.datesWithMultipleEvents.contains(key)) {
            return [UIColor.red]
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        //        var selectedFirstDate = dateFormatter.string(from: date)
        //
        //        if startDateTextField.text == "" && endDateTextField.text == ""
        //        {
        //            startDateTextField.text = selectedDate_1
        //            selDate_1 = date
        //        }
        //        else if startDateTextField.text != nil && endDateTextField.text == ""
        //        {
        //            selDate_2 = date
        //            if selDate_2! > selDate_1!
        //            {
        //                endDateTextField.text = selectedDate_1
        //            }
        //            else{
        //                    print("End date is less than start date.")
        //                calendar.deselect(date)
        //            }
        //        }
        //        else if startDateTextField.text != nil && endDateTextField.text != nil
        //        {
        //            for date in calendar.selectedDates {
        //                calendar.deselect(date)
        //            }
        //            calendar.select(date)
        //            endDateTextField.text = ""
        //            startDateTextField.text = selectedDate_1
        //            selDate_1 = date
        //        }
        //
        //
        //
        //Multiple Selection
        // nothing selected:
        if selDate_1 == nil {
            selDate_1 = date
            datesRange = [selDate_1!]
            
            var selectedFirstDate = dateFormatter.string(from: selDate_1!)
            
            startDateTextField.text = selectedFirstDate
            
            print("datesRange contains: \(datesRange!)")
            
            return
        }
        
        // only first date is selected:
        if selDate_1 != nil && selDate_2 == nil {
            // handle the case of if the last date is less than the first date:
            if date <= selDate_1! {
                calendar.deselect(selDate_1!)
                selDate_1 = date
                datesRange = [selDate_1!]
                
                var selectedFirstDate = dateFormatter.string(from: selDate_1!)
                
                startDateTextField.text = selectedFirstDate
                
                print("datesRange contains: \(datesRange!)")
                
                return
            }
            
            let range = datesRange(from: selDate_1!, to: date)
            
            selDate_2 = range.last
            
            var selectedLastDate = dateFormatter.string(from: selDate_2!)
            
            endDateTextField.text = selectedLastDate
            
            for d in range {
                calendar.select(d)
            }
            
            datesRange = range
            
            print("datesRange contains: \(datesRange!)")
            
            return
        }
        
        // both are selected:
        if selDate_1 != nil && selDate_2 != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            
            selDate_2 = nil
            selDate_1 = nil
            
            datesRange = []
            
            print("datesRange contains: \(datesRange!)")
        }
        
        
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let cell = calendar.cell(for: date, at: monthPosition)
        cell?.backgroundColor = UIColor.white
        //        calendar.deselect(date)
        
        if selDate_1 != nil{
            //            self.startDateTextField.text = ""
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            selDate_1 = nil
            selDate_2 = nil
            datesRange = []
            self.startDateTextField.text = ""
            self.endDateTextField.text = ""
        }
        //        else if date == selDate_2{
        //            self.endDateTextField.text = ""
        //        }
        
        
        if selDate_1 != nil && selDate_2 != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            
            selDate_2 = nil
            selDate_1 = nil
            
            datesRange = []
            
            self.startDateTextField.text = ""
            self.endDateTextField.text = ""
            
            print("datesRange contains: \(datesRange!)")
            print("Start Data contains: \(self.startDateTextField.text!)")
            print("End Date contains: \(endDateTextField.text!)")
            
        }
    }
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        
        return cell
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        
        let currentPageDate = calendar.currentPage
        
        let monthInNumber = Calendar.current.component(.month, from: currentPageDate)
        let year = Calendar.current.component(.year, from: currentPageDate)
        
        let monthNumber = monthInNumber
        let fmt = DateFormatter()
        fmt.dateFormat = "MM"
        let month = fmt.monthSymbols[monthNumber - 1]
        print(month)
        print(year)
        
        self.currentMonthLabel.text = "\(month) \(year)"
    }
    
    //Mark: Previous Date should not select logic
    
    //    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
    //        if(date == Date())
    //        {
    //            return false
    //        }
    //        else
    //        {
    //            return true
    //        }
    //    }
    
    
    
    func datesRange(from: Date, to: Date) -> [Date] {
        // in case of the "from" date is more than "to" date,
        // it should returns an empty array:
        if from > to { return [Date]() }
        
        var tempDate = from
        var array = [tempDate]
        
        while tempDate < to {
            tempDate = Calendar.current.date(byAdding: .day, value: 1, to: tempDate)!
            array.append(tempDate)
        }
        
        return array
    }
    
   
}
