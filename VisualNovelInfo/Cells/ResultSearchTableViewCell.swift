//
//  ResultSearchTableViewCell.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 14/06/25.
//

import UIKit

protocol ResultSearchTableViewCellProtocol: Any {
    var strTile: String { get }
    var strDetails: String { get }
    var strURLImage: String { get }
}

class ResultSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    private var downloadTask: URLSessionDownloadTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
        imgLogo.image = nil
    }
    
    func configureCell(withProtocol resultSearchProtocol: ResultSearchTableViewCellProtocol) {
        lblTitle.text = resultSearchProtocol.strTile
        lblDetails.text = resultSearchProtocol.strDetails
        
        if let urlImage = URL(string: resultSearchProtocol.strURLImage) {
            downloadTask?.cancel()
            downloadTask = imgLogo.loadImage(url: urlImage)
        } else {
            imgLogo.image = UIImage(named: "noImage")
        }
    }
}
