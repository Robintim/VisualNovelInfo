//
//  CharacterBase.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 11/07/25.
//

import Foundation

struct CharacterBase {
    var strId: String?
    var strName: String?
    var imageInfo: ImageBaseResponse?
}

extension CharacterBase: ResultSearchTableViewCellProtocol {
    var strTile: String {
        return ""
    }
    
    var strDetails: String {
        return strName ?? ""
    }
    
    var strURLImage: String {
        return imageInfo?.url ?? ""
    }
    
    
}
