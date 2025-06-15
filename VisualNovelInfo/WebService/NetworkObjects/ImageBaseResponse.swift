//
//  ImageBaseResponse.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 14/06/25.
//

import Foundation

struct ImageBaseResponse: Decodable {
    var sexual: Double
    var violence: Double
    var url: String?
}
