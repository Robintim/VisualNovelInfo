//
//  FirstScreenConectionManager.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 14/06/25.
//

import Foundation

protocol FirstScreenConectionManagerProtocol: Any {
    func conectionSucces(withResults arrResults: [ResultSearch])
    func connectionFailed(withMessage strMessage: String)
}

class FirstScreenConectionManager {
    var bHasMore: Bool = false
    private var managerDelegate: FirstScreenConectionManagerProtocol?
    private lazy var service: NetworkApiProtocol = ServiceApi(configuration: URLConfiguration(path: "/kana/vn"))
    private let strFields = "title, image.url, image.sexual, image.violence, released, languages"
    var bShouldCensored: Bool
    
    init(managerDelegate: FirstScreenConectionManagerProtocol? = nil, bShouldCensored: Bool = true) {
        self.managerDelegate = managerDelegate
        self.bShouldCensored = bShouldCensored
    }
    
    func search(withParameter strText: String) {
        let request = createRequestObject(withTest: strText)
        searchVisualNovels(withRequest: request)
    }
    
    private func createRequestObject(withTest strText: String) -> Request {
        let request = Request(filters: ["search", "=", strText], fields: strFields, page: 1)
        return request
    }
    
    private func searchVisualNovels(withRequest request: Request) {
        service.search(withRequest: request) {[weak self] (result: Result<Response<SearchResults>, ErrorNetwork>) in
            switch result {
            case .success(let success):
                if let arrResult: [ResultSearch] = self?.convertService(response: success) {
                    DispatchQueue.main.async {
                        self?.managerDelegate?.conectionSucces(withResults: arrResult)
                    }
                }
                
            case .failure(let failure):
                DispatchQueue.main.async {
                    self?.managerDelegate?.connectionFailed(withMessage: failure.localizedDescription)
                }
            }
        }
    }
    
    private func convertService(response service: Response<SearchResults>) -> [ResultSearch] {
        bHasMore =  service.more
        var arrResult: [ResultSearch] = [ResultSearch]()
        for result in service.results {
            let resultSearch = ResultSearch(strId: result.id, arrLanguages: result.languages, strDatePublished: result.released, imageInfo: result.image, strTitle: result.title, bShouldBeCensored: bShouldCensored)
            arrResult.append(resultSearch)
        }
        
        return arrResult
    }
}
