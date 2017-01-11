//
//  DateManager.swift
//  4919forIkoma
//
//  Created by Kawanaka Shogo on H29/01/10.
//  Copyright © 平成29年 Nara Institute of Science and Technology. All rights reserved.
//

import UIKit

class DateManager: NSObject {
    var currentMonthOfDates = [Date]()
    var selectedDate = Date()
    let daysPerWeek: Int = 7
    var numeberOfItems: Int!
    
    func daysAcquisition() -> Int{
        let rangeOfWeeks = NSCalendar.current.range(of: .weekOfMonth, in: .month, for: firstDateOfMonth())
        let numberOfWeeks = rangeOfWeeks?.count
        numeberOfItems = numberOfWeeks! * daysPerWeek
        return numeberOfItems
    }
    
    func firstDateOfMonth() -> Date{
        var components = NSCalendar.current.dateComponents([.year, .month, .day], from: selectedDate)
        components.day = 1
        let firstDateMonth:Date = NSCalendar.current.date(from: components)!
        return firstDateMonth
    }
    
    func dateForCellAtIndexPath(numberOfItems: Int){
        let ordinalityOfFirstDay = NSCalendar.current.ordinality(of: .day, in: .weekOfMonth, for: firstDateOfMonth())
        for i in 0 ..< numberOfItems {
            let dateComponents = NSDateComponents()
            dateComponents.day = i - (ordinalityOfFirstDay! - 1)
            
            let date = NSCalendar.current.date(byAdding: dateComponents as DateComponents, to: firstDateOfMonth())
            currentMonthOfDates.append(date!)
        }
    }
    
    func conversionDateFormat(indexPath: NSIndexPath) -> String{
        dateForCellAtIndexPath(numberOfItems: numeberOfItems)
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: currentMonthOfDates[indexPath.row])
    }
}


		
