//
//  CalendarView.swift
//  Offers
//
//  Created by Igor on 30.06.2020.
//  Copyright © 2020 Igor Gapanovich. All rights reserved.
//

import UIKit
import UI
import CVCalendar

protocol CalendarViewDelegate: class {
    func didSetDate()
}

class CalendarView: UIView, CalendarViewDelegate {
    
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
 
    weak var delegate: CalendarViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        // Appearance delegate [Unnecessary]
//        calendarView.calendarAppearanceDelegate = self
//        // Animator delegate [Unnecessary]
//        calendarView.animatorDelegate = self
//        // Menu delegate [Required]
//        menuView.menuViewDelegate = self
//        // Calendar delegate [Required]
//        calendarView.calendarDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        superview?.layoutSubviews()
//
//        menuView.commitMenuViewUpdate()
//        calendarView.commitCalendarViewUpdate()
//    }
    
    func didSetDate() {
        delegate?.didSetDate()
    }
}
