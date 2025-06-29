//
//  DetailNovelViewController.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 20/06/25.
//

import UIKit

class DetailNovelViewController: UIViewController {
    
    var detailInfo: DetailInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let strTitle = detailInfo?.resultInfo?.strTile {
            title = strTitle
        }
    }

}
