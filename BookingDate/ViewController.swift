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
    
    func setProperties(element: Koyomi) {
        
        koyomi.circularViewDiameter = 0.2
        koyomi.calendarDelegate = self
        koyomi.inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        koyomi.weeks = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")
        koyomi.style = .standard
        koyomi.dayPosition = .center
        koyomi.selectionMode = .sequence(style: .semicircleEdge)
        koyomi.selectedStyleColor = UIColor(red: 203/255, green: 119/255, blue: 223/255, alpha: 1)
        koyomi
            .setDayFont(size: 14)
            .setWeekFont(size: 10)
    }
    
    @IBOutlet weak var currentDateLabel: UILabel!
    
    fileprivate let invalidPeriodLength = 90
    
//    @IBOutlet fileprivate weak var segmentedControl: UISegmentedControl!
    
//    func setSegmentProperties(element: UISegmentedControl) {
//        segmentedControl.setTitle("Previous", forSegmentAt: 0)
//        segmentedControl.setTitle("Current", forSegmentAt: 1)
//        segmentedControl.setTitle("Next", forSegmentAt: 2)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties(element: koyomi)
//        setSegmentProperties(element: segmentedControl)
//        currentDateLabel.text = koyomi.currentDateString()
    }
    
    // MARK: - Utility
    
    fileprivate func date(_ date: Date, later: Int) -> Date {
        var components = DateComponents()
        components.day = later
        return (Calendar.current as NSCalendar).date(byAdding: components, to: date, options: NSCalendar.Options(rawValue: 0)) ?? date
    }
}

// MARK: - Tap Action
//extension ViewController {
//
//    @IBAction func tappedControl(_ sender: UISegmentedControl) {
//        let month: MonthType = {
//            switch sender.selectedSegmentIndex {
//            case 0:  return .previous
//            case 1:  return .current
//            default: return .next
//            }
//        }()
//        koyomi.display(in: month)
//    }
//
//}

// MARK: - KoyomiDelegate -

extension ViewController: KoyomiDelegate {
    
    func koyomi(_ koyomi: Koyomi, didSelect date: Date?, forItemAt indexPath: IndexPath) {
        print("You Selected: \(String(describing: date))")
    }
    
    func koyomi(_ koyomi: Koyomi, currentDateString dateString: String) {
        currentDateLabel.text = dateString
    }
    
    @objc(koyomi:shouldSelectDates:to:withPeriodLength:)
    func koyomi(_ koyomi: Koyomi, shouldSelectDates date: Date?, to toDate: Date?, withPeriodLength length: Int) -> Bool {
        if length > invalidPeriodLength {
            print("More than \(invalidPeriodLength) days are invalid period.")
            return false
        }
        return true
    }
}

