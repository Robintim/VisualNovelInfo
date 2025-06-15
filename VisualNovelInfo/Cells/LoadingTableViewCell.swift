//
//  LoadingTableViewCell.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 14/06/25.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {

    @IBOutlet weak var aIActivity: UIActivityIndicatorView!{
        didSet{
            aIActivity.style = .medium
        }
    }
    @IBOutlet weak var lblLoading: UILabel!{
        didSet{
            lblLoading.text = NSLocalizedString("Loading", comment: "Loading")
        }
    }
    
}
