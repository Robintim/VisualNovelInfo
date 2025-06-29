//
//  DetailScreenConnectionManager.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 28/06/25.
//

import Foundation

protocol DetailScreenConnectionManagerProtocol: Any {
    func fetchDetailInfoSuccessfully(with search: DetailInfoSearch)
    func fetchDetailInfoFailed(with error: Error)
}

class DetailScreenConnectionManager {
    private var manager: DetailScreenConnectionManagerProtocol?
    private lazy var service: NetworkApiProtocol = ServiceApi(configuration: URLConfiguration(path: "/kana/vn"))
    private let strFields = "title, alttitle, aliases, olang, released, titles.lang, titles.title, titles.latin, titles.main, platforms, image.url, image.violence, description, length_minutes, screenshots.url, screenshots.sexual, screenshots.violence, va.character.name"
    
    init(manager: DetailScreenConnectionManagerProtocol) {
        self.manager = manager
    }
    
    func searchDetail(forNovel strId: String) {
        let request = Request(filters: ["id", "=", strId], fields: strFields, page: 1)
        searchDetail(withRequest: request)
    }
    
    private func searchDetail(withRequest request: Request) {
        service.search(withRequest: request) { [weak self] (result: Result<Response<DetailSearchResponse>, ErrorNetwork>) in
            switch result {
            case .success(let success):
                if let detail = success.results.first {
                    let detailInfo: DetailInfoSearch = DetailInfoSearch(arrAliases: detail.aliases, strAlttitle: detail.alttitle, strDescription: detail.description, dLengthMinutes: detail.length_minutes, strOriginalLanguage: detail.olang, arrPlatforms: detail.platforms, arrScreenshots: detail.screenshots, arrTitles: detail.titles)
                    DispatchQueue.main.async {
                        self?.manager?.fetchDetailInfoSuccessfully(with: detailInfo)
                    }
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    self?.manager?.fetchDetailInfoFailed(with: failure)
                }
            }
        }
    }
}
