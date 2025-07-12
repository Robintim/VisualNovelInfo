//
//  DetailNovelViewController.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 20/06/25.
//

import UIKit

class DetailNovelViewController: UIViewController {
    
    @IBOutlet weak var lblTitles: UILabel! {
        didSet {
            lblTitles.text = ""
        }
    }
    @IBOutlet weak var tblInfo: UITableView! {
        didSet {
            tblInfo.delegate = self
            tblInfo.dataSource = self
            tblInfo.separatorStyle = .none
        }
    }
    var detailInfo: DetailInfo?
    private lazy var connection: DetailScreenConnectionManager = DetailScreenConnectionManager(manager: self)
    private var iSelectedIndex: Int = 0 {
        didSet {
            detailInfo?.iSelectedIndex = iSelectedIndex
            tblInfo.reloadData()
        }
    }
    private var bSearchHasBeeenDone: Bool {
        return (detailInfo?.detailInfoSearch) != nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerXib()
        if let strTitle = detailInfo?.resultInfo?.strTile {
            title = strTitle
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if bSearchHasBeeenDone {
            configureView()
        } else if let strVnId = detailInfo?.resultInfo?.strId {
            connection.searchDetail(forNovel: strVnId)
        }
    }

    @IBAction func sectionWasSelected(_ sender: UISegmentedControl) {
        iSelectedIndex = sender.selectedSegmentIndex
        
    }
    
    private func registerXib() {
        var nib = UINib(nibName: CellIdentifiers.resultSearchTableViewCell.rawValue, bundle: nil)
        tblInfo.register(nib, forCellReuseIdentifier: CellIdentifiers.resultSearchTableViewCell.rawValue)
        nib = UINib(nibName: CellIdentifiers.simpleTableViewCell.rawValue, bundle: nil)
        tblInfo.register(nib, forCellReuseIdentifier: CellIdentifiers.simpleTableViewCell.rawValue)
        nib = UINib(nibName: CellIdentifiers.doubleImageTableViewCell.rawValue, bundle: nil)
        tblInfo.register(nib, forCellReuseIdentifier: CellIdentifiers.doubleImageTableViewCell.rawValue)
    }
    
    private func configureView() {
        if let strTitles = detailInfo?.getAlternativeTitles() {
            lblTitles.text = strTitles
        }
        tblInfo.reloadData()
    }
}

extension DetailNovelViewController: DetailScreenConnectionManagerProtocol {
    func fetchDetailInfoSuccessfully(with search: DetailInfoSearch) {
        detailInfo?.detailInfoSearch = search
        configureView()
    }
    
    func fetchDetailInfoFailed(with error: any Error) {
        let alert = createSimpleAlertView(withTitle: NSLocalizedString("Something went wrong", comment: "Error alert title"), messge: error.localizedDescription, actionTitle: NSLocalizedString("Accept", comment: "Accept"))
        present(alert, animated: true)
    }
}

extension DetailNovelViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if bSearchHasBeeenDone {
            switch iSelectedIndex {
                case 0 :
                    return 2
                case 1:
                    return detailInfo?.getTotalImageRow() ?? 0
                case 2:
                    return detailInfo?.getTotalCharacter() ?? 0
                default :
                    return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if bSearchHasBeeenDone {
            switch iSelectedIndex {
            case 0 :
                return getCellForGeneralInfo(forIndex: indexPath, andTableView: tableView)
            case 1:
                return getCellForGallery(forIndex: indexPath, andTableView: tableView)
            case 2:
                return getCellForCharacter(forIndex: indexPath, andTableView: tableView)
            default :
                break
            }
        }
        return UITableViewCell()
    }
    
    private func getCellForGeneralInfo(forIndex index: IndexPath, andTableView tableView: UITableView) -> UITableViewCell {
        switch index.row {
        case 0 :
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.resultSearchTableViewCell.rawValue, for: index) as? ResultSearchTableViewCell, let detailInfo = detailInfo {
                cell.configureCell(withProtocol: detailInfo, showDisclosureIndicator: false)
                return cell
            }
        case 1 :
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.simpleTableViewCell.rawValue, for: index) as? SimpleTableViewCell, let detailInfo = detailInfo {
                cell.setCell(with: detailInfo)
                return cell
            }
            
        default :
            return UITableViewCell()
        }
        
        return UITableViewCell()
    }
    
    private func getCellForGallery(forIndex index: IndexPath, andTableView tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.doubleImageTableViewCell.rawValue, for: index) as? DoubleImageTableViewCell {
            let tplUrlForCell = detailInfo?.getUrl(forIndex: index.row)
            cell.setImage(forFirstImage: tplUrlForCell?.0, andSecondImage: tplUrlForCell?.1)
            return cell
        }
        return UITableViewCell()
    }
    
    private func getCellForCharacter(forIndex index:IndexPath, andTableView tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.resultSearchTableViewCell.rawValue, for: index) as? ResultSearchTableViewCell, let character = detailInfo?.getCharacter(forIndex: index.row) {
            cell.configureCell(withProtocol: character)
            return cell
        }
        return UITableViewCell()
    }
}

extension DetailNovelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
