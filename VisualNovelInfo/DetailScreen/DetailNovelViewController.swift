//
//  DetailNovelViewController.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 20/06/25.
//

import UIKit

class DetailNovelViewController: UIViewController {
    
    var detailInfo: DetailInfo?
    private lazy var connection: DetailScreenConnectionManager = DetailScreenConnectionManager(manager: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        if let strTitle = detailInfo?.resultInfo?.strTile {
            title = strTitle
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let detail = detailInfo?.detailInfoSearch {
            print("Ya se hizo la búsqueda: \(detail.strAlttitle ?? "No debería salir algo aquí")")
        } else if let strVnId = detailInfo?.resultInfo?.strId {
            connection.searchDetail(forNovel: strVnId)
        }
    }

}

extension DetailNovelViewController: DetailScreenConnectionManagerProtocol {
    func fetchDetailInfoSuccessfully(with search: DetailInfoSearch) {
        detailInfo?.detailInfoSearch = search
    }
    
    func fetchDetailInfoFailed(with error: any Error) {
        let alert = createSimpleAlertView(withTitle: NSLocalizedString("Something went wrong", comment: "Error alert title"), messge: error.localizedDescription, actionTitle: NSLocalizedString("Accept", comment: "Accept"))
        present(alert, animated: true)
    }
}
