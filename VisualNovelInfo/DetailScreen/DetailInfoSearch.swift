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
        return String.localizedStringWithFormat(NSLocalizedString("Average length: %02d h:%02d min", comment: "Average length"), hour, min)
    }
    
    func getOrderedScreenshots() -> [ImageBaseResponse]? {
        guard let arrScreenshots = arrScreenshots else { return nil }
        return arrScreenshots.sorted { (image1, image2) -> Bool in
            return image1.sexual < image2.sexual && image1.violence < image2.violence
        }
    }

}
