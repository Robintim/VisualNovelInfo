//
//  DoubleImageTableViewCell.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 11/07/25.
//

import UIKit

class DoubleImageTableViewCell: UITableViewCell {
    @IBOutlet weak var imvFirstImage: UIImageView!
    @IBOutlet weak var imvSecondImage: UIImageView!
    private var downloadTaskImg1: URLSessionDownloadTask?
    private var downloadTaskImg2: URLSessionDownloadTask?
    
    override func prepareForReuse() {
        imvFirstImage.image = nil
        imvSecondImage.image = nil
        downloadTaskImg1?.cancel()
        downloadTaskImg1 = nil
        downloadTaskImg2?.cancel()
        downloadTaskImg2 = nil
    }
    
    func setImage(forFirstImage strUrl1: String?, andSecondImage strUrl2: String?) {
        if let urlImage1 = URL(string: strUrl1 ?? "") {
            downloadTaskImg1?.cancel()
            downloadTaskImg1 = imvFirstImage.loadImage(url: urlImage1)
        } else {
            imvFirstImage.image = UIImage(named: "noImage")
        }
        
        if let urlImage2 = URL(string: strUrl2 ?? "") {
            downloadTaskImg2?.cancel()
            downloadTaskImg2 = imvSecondImage.loadImage(url: urlImage2)
        } else {
            imvSecondImage.image = UIImage(named: "noImage")
        }
    }
}
