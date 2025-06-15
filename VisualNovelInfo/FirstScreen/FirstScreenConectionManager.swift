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
    
    init(managerDelegate: FirstScreenConectionManagerProtocol? = nil) {
        self.managerDelegate = managerDelegate
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
                print("Servicio consumido con éxito: \(success.results.count)")
                
            case .failure(let failure):
                print("Error: \(failure.localizedDescription)")
                self?.managerDelegate?.connectionFailed(withMessage: failure.localizedDescription)
            }
        }
    }
}
