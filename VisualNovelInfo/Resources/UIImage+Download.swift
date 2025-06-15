//
//  UIImage+Download.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 14/06/25.
//

import Foundation
import UIKit

public extension UIImageView{
    func loadImage(url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url){[weak self] url, response, error in
            guard let self = self else { return }
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        
        downloadTask.resume()
        return downloadTask
    }
}
