//
//  Response.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 14/06/25.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    var results: [T]
    var more: Bool
}
