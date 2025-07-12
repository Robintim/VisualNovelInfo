//
//  DetailSearchResponse.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 20/06/25.
//

import Foundation

struct DetailSearchResponse: Decodable {
    var aliases: [String]?
    var alttitle: String?
    var description: String?
    var length_minutes: Double?
    var olang: String?
    var platforms: [String]?
    var screenshots: [ImageBaseResponse]?
    var titles: [TitlesResponse]?
    var va: [VoiceActorBase]?
}
