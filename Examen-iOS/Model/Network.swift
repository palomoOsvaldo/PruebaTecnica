//
//  Network.swift
//  Examen-iOS
//
//  Created by Osvaldo Salas on 28/06/21.
//

import Foundation


class Network {
    //
    // MARK: - Class Methods
    //
    static func loadJSONFile<T: Decodable>(url: String,
                                           type: T.Type,
                                           completionHandler: @escaping (T?, NetworkError?) -> Void) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let url = URL(string: url) {
                if let data = try? Data(contentsOf: url) {
                    do {
                        let decoder = JSONDecoder()
                        let typeObject: T? = try decoder.decode(T.self, from: data)
                        completionHandler(typeObject, nil)
                        
                    } catch {
                        print(error.localizedDescription)
                        completionHandler(nil, .parseError)
                    }
                }
            }
        }
    }
}
