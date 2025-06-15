//
//  SimpleTableViewCell.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 14/06/25.
//

import UIKit

protocol SimpleTableViewCellProtocol {
    var strText: String { get }
    var bNeedsDisclousure: Bool { get }
}

class SimpleTableViewCell: UITableViewCell {

    @IBOutlet weak var lblText: UILabel!
    
    func setCell(with info: SimpleTableViewCellProtocol) {
        lblText.text = info.strText
        accessoryType = info.bNeedsDisclousure ? .disclosureIndicator : .none
    }
    
}
