//
//  Alert.swift
//  Examen-iOS
//
//  Created by Osvaldo Salas on 29/06/21.
//

import Foundation
import UIKit

//MARK: - Alert that shows an action sheet with cancel
extension UITableViewController {
    typealias AlertAction = () -> ()
    typealias AlertButtonAction = (ActionSheetTitle, AlertAction)
    
    func showActionSheetWithCancel(titleAndAction: [AlertButtonAction]) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for value in titleAndAction {
            actionSheet.addAction(UIAlertAction(title: value.0.rawValue, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                
                value.1()
                
            }))
        }
        actionSheet.addAction(UIAlertAction(title: ActionSheetTitle.cancel.rawValue, style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func showAlert(title:String, message:String) {
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
