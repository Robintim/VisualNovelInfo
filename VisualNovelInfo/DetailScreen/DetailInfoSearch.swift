//
//  DetailInfoSearch.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 28/06/25.
//

import Foundation

struct DetailInfoSearch {
    var arrAliases: [String]?
    var strAlttitle: String?
    var strDescription: String?
    var dLengthMinutes: Double?
    var strOriginalLanguage: String?
    var arrPlatforms: [String]?
    var arrScreenshots: [ImageBaseResponse]?
    var arrTitles: [TitlesResponse]?
    
    func getLengthString() -> String? {
        guard let dLength = dLengthMinutes else { return nil }
        let intLength = Int(dLength)
        let min = intLength % 60
        let hour = intLength / 60
        return String.localizedStringWithFormat(NSLocalizedString("Average length: %02d:%02d", comment: "Average length"), hour, min)
    }

}
