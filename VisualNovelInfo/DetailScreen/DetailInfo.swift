//
//  DetailInfo.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 28/06/25.
//

import Foundation

struct DetailInfo {
    
    var resultInfo: ResultSearch?
    var detailInfoSearch: DetailInfoSearch? {
        didSet {
            guard let detailInfoSearch = detailInfoSearch else { return }
            arrOrderedImage = detailInfoSearch.getOrderedScreenshots()
        }
    }
    var iSelectedIndex: Int = 0
    private var arrOrderedImage: [ImageBaseResponse]?
    
    func getAlternativeTitles() -> String? {
        if let strAlttitle = detailInfoSearch?.strAlttitle {
            return strAlttitle
        } else if let strTitle = resultInfo?.strTitle {
            return strTitle
        }
        return nil
    }
    
    func getTotalImageRow() -> Int {
        return Int((Double(arrOrderedImage?.count ?? 0) / 2.0).rounded())
    }
    
    func getUrl(forIndex iRow: Int) -> (String?, String?) {
        let iBaseRow = 2 * iRow
        var strUrl1: String? = nil
        if let strFirstUrl = arrOrderedImage?[iBaseRow].url {
            strUrl1 = strFirstUrl
        }
        
        var strUrl2: String? = nil
        if arrOrderedImage?.count ?? 0 > iBaseRow + 1, let strSecondUrl = arrOrderedImage?[iBaseRow + 1].url {
            strUrl2 = strSecondUrl
        }
        return (strUrl1, strUrl2)
    }
    
    func getTotalCharacter() -> Int {
        return detailInfoSearch?.arrCharacters?.count ?? 0
    }
    
    func getCharacter(forIndex iIndex: Int) -> CharacterBase? {
        return detailInfoSearch?.arrCharacters?[iIndex]
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
