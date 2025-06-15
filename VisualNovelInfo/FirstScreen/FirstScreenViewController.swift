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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Search visual novel", comment: "Search visual novel")
    }

    @IBAction func searchButtonAction(_ sender: UIButton) {
        configureSearch()
    }
    
    private func configureSearch() {
        txfSearch.resignFirstResponder()
        conection.search(withParameter: txfSearch.text ?? "")
    }
}

extension FirstScreenViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        configureSearch()
        return true
    }
}

extension FirstScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension FirstScreenViewController: UITableViewDelegate {
    
}

extension FirstScreenViewController: FirstScreenConectionManagerProtocol {
    func conectionSucces(withResults arrResults: [ResultSearch]) {
        
    }
    
    func connectionFailed(withMessage strMessage: String) {
        
    }
}
