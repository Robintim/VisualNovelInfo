//
//  DateFunctions.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 14/06/25.
//

import Foundation

struct DateFunctions {
    static func convertToDate(_ dateString: String, withForrmat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString)
    }
    
    static func convertToString(_ date: Date, withFormat format: String) -> String {
        let locale = Locale.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = locale
        return dateFormatter.string(from: date)
    }
}
