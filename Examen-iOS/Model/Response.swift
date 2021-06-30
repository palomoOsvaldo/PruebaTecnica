//
//  Response.swift
//  Examen-iOS
//
//  Created by Osvaldo Salas on 29/06/21.
//

import Foundation

struct Response: Codable {
    var colors: [String]
    var questions:[Questions]
}

struct Questions: Codable {
    var total: Int
    var text: String
    var chartData: [ChartData]
}

struct ChartData: Codable {
    var text: String
    var percetnage: Double
}
