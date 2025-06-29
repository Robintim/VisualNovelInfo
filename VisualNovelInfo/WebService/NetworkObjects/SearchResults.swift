//
//  SearchResults.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 14/06/25.
//

import Foundation

struct SearchResults: Decodable {
    var id: String?
    var languages: [String]?
    var released: String?
    var title: String?
    var image: ImageBaseResponse?
}
