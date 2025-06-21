//
//  TitlesResponse.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 20/06/25.
//

import Foundation

struct TitlesResponse: Decodable {
    var lang: String?
    var latin: String?
    var main: Bool?
    var title: String?
}
