//
//  Request.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 14/06/25.
//

import Foundation

struct Request: Codable {
    var filters: [String]
    var fields: String
    var page: Int
    var results: Int = 50
    
}
