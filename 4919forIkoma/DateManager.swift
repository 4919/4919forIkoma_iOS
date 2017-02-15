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
    var numberOfItems: Int!
    var initialNumOfItems: Int!
    
    func daysAcquisition() -> Int{
        let rangeOfWeeks = Calendar.current.range(of: .weekOfMonth, in: .month, for: firstDateOfMonth())
        let numberOfWeeks = rangeOfWeeks?.count
        numberOfItems = numberOfWeeks! * daysPerWeek
        return numberOfItems
    }
    
    func firstDateOfMonth() -> Date{
        var components = Calendar.current.dateComponents([.year, .month, .day], from: selectedDate)
        components.day = 1
        let firstDateMonth:Date = NSCalendar.current.date(from: components)!
        return firstDateMonth
    }
    
    func dateForCellAtIndexPath(_ numberOfItems: Int){
        let ordinalityOfFirstDay = Calendar.current.ordinality(of: .day, in: .weekOfMonth, for: firstDateOfMonth())
        for i in 0 ..< numberOfItems {
            var dateComponents = DateComponents()
            dateComponents.day = i - (ordinalityOfFirstDay! - 1)
            if i == 0{
                initialNumOfItems = i - (ordinalityOfFirstDay! - 1)
            }
            
            let date = Calendar.current.date(byAdding: dateComponents as DateComponents, to: firstDateOfMonth())
            currentMonthOfDates.append(date!)
        }
    }
    
    func conversionDateFormat(_ indexPath: IndexPath) -> String{
        dateForCellAtIndexPath(numberOfItems)
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: currentMonthOfDates[indexPath.row])
    }
}


		
