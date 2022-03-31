//
//  CalendarViewController.swift
//  PrepSmart_EndUser_iOS
//
//  Created by Abhijit Nikam on 10/08/19.
//  Copyright © 2019 Exceptionaire.co. All rights reserved.
//Screen ID :- PSTMOBSTD087, PSTMOBSTD035, PSTMOBSTD068

import UIKit
import FSCalendar_Persian

protocol  CustomCalendarViewController {
    func onClickAddButton()
}

class CalendarViewController: UIViewController {
    @IBOutlet var calendar: FSCalendar!
    @IBOutlet var lbl_startDate: UILabel!
    @IBOutlet var lbl_endDate: UILabel!
    @IBOutlet var lbl_todaysDate: UILabel!
    @IBOutlet var btn_add: UIButton!
    @IBOutlet weak var btn_indicatorView: UIButton!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomDateSlotLabel: UILabel!
    @IBOutlet weak var heightConstraintOfBottomDatesView: NSLayoutConstraint!
    
  
    
    var customDelegate : CustomCalendarViewController!
    
    var datesWithEvent = ["2020-02-03", "2020-02-05", "2020-02-08", "2020-02-15"]

    var datesWithMultipleEvents = ["2020-02-03", "2020-02-05", "2020-02-08", "2020-02-15"]
    
    var selectedStartDate = Date()
    var selectedEndDate = Date()
    var btn_text : String?
    var setTopLabel : String?
    
    var selDate_1 : Date?
    var selDate_2 : Date?
    
    private var datesRange: [Date]?
    
    var currentMonthPosition = Int()
    var selectedDate = Date()
    let dateFormatter = DateFormatter()

    fileprivate let gregorian = Calendar(identifier: .gregorian)
    
    fileprivate lazy var dateFormatterForCurrentMonth: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM yyyy"
        return formatter
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        btn_indicatorView.layer.cornerRadius = 4.0
        btn_indicatorView.clipsToBounds = true
        self.topLabel.text = setTopLabel
        
        let df = DateFormatter()
        df.dateFormat = "MMM yyyy"
        let now = df.string(from: Date())
        
        self.lbl_todaysDate.text = now
        
        calendarSetup()
    }
    
//  var datesWithEvent = ["2019-08-10", "2019-08-11", "2019-08-12", "2019-08-13"]
//  var datesWithMultipleEvents = ["2019-08-06", "2019-08-08", "2019-08-14", "2019-08-20"]
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func calendarSetup()
    {
        calendar.headerHeight = 0.0
        calendar.pagingEnabled = true
        calendar.placeholderType = .none
        calendar.appearance.headerTitleFont = UIFont.init(name: "ENGCARNATION", size: 14.0)
        calendar.appearance.titleFont = UIFont.init(name: "ENGCARNATION", size: 12.0)
        calendar.appearance.weekdayFont = UIFont.init(name: "ENGCARNATION", size: 12.0)
        calendar.register(FSCalendarCell.self, forCellReuseIdentifier: "cell")
        calendar.isMultipleTouchEnabled = true
        calendar.allowsMultipleSelection = true
        calendar.swipeToChooseGesture.isEnabled = true
        calendar.appearance.selectionColor = UIColor.init(red: 45.0/255.0, green: 193.0/255.0, blue: 41.0/255.0, alpha: 1.0)
        calendar.appearance.titleSelectionColor = UIColor.white
        calendar.appearance.todayColor = UIColor.init(red: 60.0/255.0, green: 174.0/255.0, blue: 224.0/255.0, alpha: 1.0)
        calendar.appearance.titleTodayColor = UIColor.white
        dateFormatter.dateFormat = "MMM d"
        btn_add.layer.cornerRadius = btn_add.frame.size.height / 2
        calendar.appearance.eventDefaultColor = UIColor.red
    }
    
    func getNextMonth(date:Date)->Date {
        return Calendar.current.date(byAdding: .month, value: 1, to:date)!
    }
    
    func getPreviousMonth(date:Date)->Date {
        return Calendar.current.date(byAdding: .month, value: -1, to:date)!
    }
    
    //MARK:Calendar Actions
    @IBAction func onClickBtnNext(_ sender: UIButton) {
        calendar.setCurrentPage(getNextMonth(date: calendar.currentPage), animated: true)
    }
    
    @IBAction func onClickBtnPrevious(_ sender: UIButton) {
        calendar.setCurrentPage(getPreviousMonth(date: calendar.currentPage), animated: true)
    }
    
    @IBAction func onClickBtnClose(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
       self.removeAnimation()
    }
    
    @IBAction func onClickBtnAdd(_ sender: UIButton) {
        
//        self.dismiss(animated: true, completion: nil)
//        self.removeAnimation()

        if customDelegate != nil {
            self.customDelegate.onClickAddButton()
            self.removeAnimation()
        }
        else{
            self.removeAnimation()
        }
        
    }
    
    
    @IBAction func onClickFlterButton(_ sender: UIButton) {
        
    }
    
    
}

extension CalendarViewController : FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    
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
            
            lbl_startDate.text = selectedFirstDate
            
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
                
                lbl_startDate.text = selectedFirstDate
                
                print("datesRange contains: \(datesRange!)")
                
                return
            }
            
            let range = datesRange(from: selDate_1!, to: date)
            
            selDate_2 = range.last
            
            var selectedLastDate = dateFormatter.string(from: selDate_2!)
            
            lbl_endDate.text = selectedLastDate
            
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
            self.lbl_startDate.text = ""
            self.lbl_endDate.text = ""
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
            
            self.lbl_startDate.text = ""
            self.lbl_endDate.text = ""
            
            print("datesRange contains: \(datesRange!)")
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
        
        self.lbl_todaysDate.text = "\(month) \(year)"
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
