//
//  ViewController.swift
//  BookingDate
//
//  Created by Andrew on 4/7/18.
//  Copyright © 2018 Andrii Halabuda. All rights reserved.
//

import UIKit
import Koyomi

class ViewController: UIViewController {
    
    @IBOutlet weak var koyomi: Koyomi!
    @IBOutlet weak var currentDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setProperties(element: koyomi)
        currentDateLabel.text = koyomi.currentDateString()
    }
    
    func setProperties(element: Koyomi) {
        
        koyomi.circularViewDiameter = 0.2
        koyomi.calendarDelegate = self
        koyomi.inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        koyomi.weeks = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
        koyomi.style = .deepBlack
        koyomi.dayPosition = .center
        koyomi.selectionMode = .sequence(style: .semicircleEdge)
        koyomi.selectedStyleColor = UIColor(red: 255/255, green: 218/255, blue: 0/255, alpha: 1)
        koyomi
            .setDayFont(size: 14)
            .setWeekFont(size: 10)
    }
    
    @IBAction func nextMonth(_ sender: UIButton) {
        koyomi.display(in: .next)
    }
    
    @IBAction func preMonth(_ sender: UIButton) {
        koyomi.display(in: .previous)
    }
    
    @IBAction func currentMonth(_ sender: UIButton) {
        koyomi.display(in: .current)
    }
    
    // MARK: - Utility
    fileprivate func date(_ date: Date, later: Int) -> Date {
        var components = DateComponents()
        components.day = later
        return (Calendar.current as NSCalendar).date(byAdding: components, to: date, options: NSCalendar.Options(rawValue: 0)) ?? date
    }
}

// MARK: - KoyomiDelegate
extension ViewController: KoyomiDelegate {
    
    func koyomi(_ koyomi: Koyomi, currentDateString dateString: String) {
        currentDateLabel.text = dateString
    }
    
    func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath) {
        
        if let date = date {
            print("date: \(date.fullDate())")
        }
    }
    
    @objc(koyomi:shouldSelectDates:to:withPeriodLength:)
    func koyomi(_ koyomi: Koyomi, shouldSelectDates date: Date?, to toDate: Date?, withPeriodLength length: Int) -> Bool {
        
        if length > 90 {
            print("More than 90 days have been selected.")
            return false
            
        } else {
            if let startDate = date, let endDate = toDate {
                print("\(length) days stay")
                print("from \(startDate.fullDate()) to \(endDate.fullDate())")
                dateFrom = startDate.fullDate()
                dateTo = endDate.fullDate()
                lengthStay = length
            }
            
            return true
        }
    }
    
}



