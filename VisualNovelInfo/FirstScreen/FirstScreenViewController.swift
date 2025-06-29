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
    @IBOutlet weak var tblResults: UITableView! {
        didSet {
            tblResults.dataSource = self
            tblResults.delegate = self
        }
    }
    private lazy var conection: FirstScreenConectionManager = FirstScreenConectionManager(managerDelegate: self)
    private var arrResults: [ResultSearch]?
    private var state: StateEnum = .noSearch
    private var bShouldCensored: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Search visual novel", comment: "Search visual novel")
        registerXib()
    }

    @IBAction func searchButtonAction(_ sender: UIButton) {
        bShouldCensored = true
        configureSearch()
    }
    
    private func configureSearch() {
        state = .searching
        tblResults.reloadData()
        txfSearch.resignFirstResponder()
        conection.bShouldCensored = bShouldCensored
        conection.search(withParameter: txfSearch.text ?? "")
    }
    
    private func registerXib() {
        var nib = UINib(nibName: CellIdentifiers.loadingCell.rawValue, bundle: nil)
        tblResults.register(nib, forCellReuseIdentifier: CellIdentifiers.loadingCell.rawValue)
        nib = UINib(nibName: CellIdentifiers.resultSearchTableViewCell.rawValue, bundle: nil)
        tblResults.register(nib, forCellReuseIdentifier: CellIdentifiers.resultSearchTableViewCell.rawValue)
        nib = UINib(nibName: CellIdentifiers.simpleTableViewCell.rawValue, bundle: nil)
        tblResults.register(nib, forCellReuseIdentifier: CellIdentifiers.simpleTableViewCell.rawValue)
    }
}

extension FirstScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        bShouldCensored = false
        configureSearch()
        return true
    }
}

extension FirstScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch state {
        case .searchSuccess:
            return arrResults?.count ?? 0 > 0 ? arrResults?.count ?? 1 : 1
        default :
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .searching:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.loadingCell.rawValue, for: indexPath) as? LoadingTableViewCell {
                return cell
            }
            return UITableViewCell()
        case .searchSuccess:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.resultSearchTableViewCell.rawValue, for: indexPath) as? ResultSearchTableViewCell, let result = arrResults?[indexPath.row] {
                cell.configureCell(withProtocol: result)
                return cell
            }
            return UITableViewCell()
        
        default:
            return UITableViewCell()
        
        }
    }
}

extension FirstScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if state == .searchSuccess, let result = arrResults?[indexPath.row] {
            let detail = DetailNovelViewController()
            let detailInfo = DetailInfo(resultInfo: result)
            detail.detailInfo = detailInfo
            navigationController?.navigationBar.topItem?.title = ""
            navigationController?.pushViewController(detail, animated: true)
        }
    }
}

extension FirstScreenViewController: FirstScreenConectionManagerProtocol {
    func conectionSucces(withResults arrResults: [ResultSearch]) {
        self.arrResults = arrResults
        state = arrResults.count > 0 ? .searchSuccess : .searchFailure
        tblResults.reloadData()
    }
    
    func connectionFailed(withMessage strMessage: String) {
        state = .searchFailure
        let alert = createSimpleAlertView(withTitle: NSLocalizedString("Something went wrong", comment: "Error alert title"), messge: strMessage, actionTitle: NSLocalizedString("Accept", comment: "Accept"))
        present(alert, animated: true)
    }
}
