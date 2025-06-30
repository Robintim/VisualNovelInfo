//
//  ResultSearch.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 14/06/25.
//

import Foundation

struct ResultSearch {

    var strId: String?
    var arrLanguages: [String]?
    var strDatePublished: String?
    var imageInfo: ImageBaseResponse?
    var strTitle: String?
    var bShouldBeCensored: Bool = true
    
    func getLanguages() -> String {
        var strLanguages: String = ""
        if let arrLanguages = arrLanguages, arrLanguages.count > 0 {
            let strLanguagesListed = arrLanguages.joined(separator: ", ")
            strLanguages.append(String.localizedStringWithFormat(NSLocalizedString("Languages: %@", comment: "Languages listed"), strLanguagesListed.localizedCapitalized))
        }
        
        return strLanguages
    }
    
    func getDatePublished() -> String {
        var strPublished: String = ""
        if let strDatePublished = strDatePublished, let datePublished = DateFunctions.convertToDate(strDatePublished, withForrmat: "yyyy-MM-dd"){
            strPublished.append(String.localizedStringWithFormat(NSLocalizedString("Published: %@", comment: "Published date"), DateFunctions.convertToString(datePublished, withFormat: "dd/MMMM/yyyy").localizedCapitalized))
        }
        
        return strPublished
    }
    
    private func createDetail() -> String {
        return "\(getDatePublished())\n\(getLanguages())"
    }
    
}

extension ResultSearch: ResultSearchTableViewCellProtocol {
    var strTile: String {
        return strTitle ?? ""
    }
    
    var strDetails: String {
        return createDetail()
    }
    
    var strURLImage: String {
        if bShouldBeCensored {
            return (imageInfo?.sexual ?? 0 < 1 && imageInfo?.violence ?? 0 <= 1) ? imageInfo?.url ?? "" : ""
        } else {
            return imageInfo?.url ?? ""
        }
    }
    
}
