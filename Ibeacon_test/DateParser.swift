//
//  DateParser.swift
//  Ibeacon_test
//
//  Created by Alex Wang on 12/4/16.
//  Copyright © 2016 RhoEun Song. All rights reserved.
//

import Foundation

class DateParser {
    func parseDate(dateString: String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        //        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss-ZZZZZ"
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        return dateFormatter.dateFromString(dateString)!
        
    }
}
