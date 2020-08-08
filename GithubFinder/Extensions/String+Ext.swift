//
//  String+Ext.swift
//  GithubFinder
//
//  Created by Diego Oruna on 7/08/20.
//

import Foundation

extension String{
    
    func convertToDate() -> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String{
        guard let date = self.convertToDate() else {return "Not available"}
        return date.convertToMonthYearFormat()
    }
    
}
