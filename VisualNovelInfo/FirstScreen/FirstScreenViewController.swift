//
//  FirstScreenViewController.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 14/06/25.
//

import UIKit

class FirstScreenViewController: UIViewController {

    @IBOutlet weak var txfSearch: UITextField! {
        didSet {
            txfSearch.delegate = self
        }
    }
    private lazy var service: NetworkApiProtocol = ServiceApi(configuration: URLConfiguration(path: "/kana/vn"))
    private let strFields = "title, image.url, image.sexual, image.violence, released, languages"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Search visual novel", comment: "Search visual novel")
    }

    @IBAction func searchButtonAction(_ sender: UIButton) {
        configureSearch()
    }
    
    private func configureSearch() {
        txfSearch.resignFirstResponder()
        let request = createRequestObject(withTest: txfSearch.text ?? "")
        searchVisualNovels(withRequest: request)
    }
    
    private func createRequestObject(withTest strText: String) -> Request {
        let request = Request(filters: ["search", "=", strText], fields: strFields, page: 1)
        return request
    }
    
    private func searchVisualNovels(withRequest request: Request) {
        service.search(withRequest: request) { [weak self] (result: Result<Response<SearchResults>, ErrorNetwork>) in
            switch result {
            case .success(let success):
                print("Servicio consumido con éxito: \(success.results)")
            case .failure(let failure):
                print("Error: \(failure.localizedDescription)")
            }
        }
    }
}

extension FirstScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        configureSearch()
        return true
    }
}
