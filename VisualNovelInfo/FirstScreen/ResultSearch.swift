//
//  ResultSearch.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 14/06/25.
//

import Foundation

struct ResultSearch {

    var arrLanguages: [String]?
    var strDatePublished: String?
    var imageInfo: ImageBaseResponse?
    var strTitle: String?
    
    private func createDetail() -> String {
        var strPublished: String = ""
        if let strDatePublished = strDatePublished, let datePublished = DateFunctions.convertToDate(strDatePublished, withForrmat: "yyyy-MM-dd"){
            strPublished.append(String.localizedStringWithFormat(NSLocalizedString("Published: %@", comment: "Published date"), DateFunctions.convertToString(datePublished, withFormat: "dd/MMMM/yyyy")))
        }
        
        return strPublished
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
        return imageInfo?.url ?? ""
    }
    
    
}
