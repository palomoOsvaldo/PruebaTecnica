//
//  WebServices.swift
//  Examen-iOS
//
//  Created by Osvaldo Salas on 28/06/21.
//

import Foundation


class WebServices {
    //
    // MARK: - Class Methods
    //
    
    static func loadData(completionHandler: @escaping (Response?, Bool?) -> Void) {
        Network.loadJSONFile(url: Constants.url, type: Response.self) { (response, error)  in
            guard error == nil else {
                completionHandler(nil, false)
                return
            }
            
            completionHandler(response, true)
            
        }
    }
}
