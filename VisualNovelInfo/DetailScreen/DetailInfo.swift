//
//  DetailInfo.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 28/06/25.
//

import Foundation

struct DetailInfo {
    
    var resultInfo: ResultSearch?
    var detailInfoSearch: DetailInfoSearch?
    
    func getAlternativeTitles() -> String? {
        if let strAlttitle = detailInfoSearch?.strAlttitle {
            return strAlttitle
        } else if let strTitle = resultInfo?.strTitle {
            return strTitle
        }
        return nil
    }
    
}

extension DetailInfo: SimpleTableViewCellProtocol {
    
    var strText: String {
        var strTextDetail = ""
        if let strLanguages = resultInfo?.getLanguages() {
            strTextDetail += "\(strLanguages)\n"
        }
        
        if let strDescription = detailInfoSearch?.strDescription {
            strTextDetail += String.localizedStringWithFormat(NSLocalizedString("Description: %@", comment: "Description"), strDescription)
        }
        
        return strTextDetail
    }
    
    var bNeedsDisclousure: Bool {
        return false
    }
    
}

extension DetailInfo: ResultSearchTableViewCellProtocol {
    
    var strTile: String {
        return ""
    }
    
    var strDetails: String {
        var strText = ""
        
        if let strDatePublished = resultInfo?.getDatePublished() {
            strText += "\(strDatePublished)\n"
        }
        
        if let strLenght = detailInfoSearch?.getLengthString() {
            strText += strLenght
        }
        
        return strText
    }
    
    var strURLImage: String {
        return resultInfo?.strURLImage ?? ""
    }

}
