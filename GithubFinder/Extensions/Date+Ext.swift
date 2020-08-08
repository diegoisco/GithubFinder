//
//  Date+Ext.swift
//  GithubFinder
//
//  Created by Diego Oruna on 7/08/20.
//

import Foundation

extension Date{
    
    func convertToMonthYearFormat() -> String{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
    
}
