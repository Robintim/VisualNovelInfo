//
//  AlertFactory.swift
//  VisualNovelInfo
//
//  Created by Daniel Alberto Vazquez Rodriguez on 14/06/25.
//

import UIKit

func createSimpleAlertView(withTitle strTitle : String, messge strMessage : String, actionTitle strActionTitle : String, andHandler handler : ((UIAlertAction) -> ())? = nil) -> UIAlertController{
    let alert = UIAlertController(title: strTitle, message: strMessage, preferredStyle: .alert)
    
    let action = UIAlertAction(title: strActionTitle, style: .default, handler: handler)
    alert.addAction(action)
    
    return alert
    
}
