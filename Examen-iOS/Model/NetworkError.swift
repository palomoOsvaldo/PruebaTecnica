//
//  NetworkError.swift
//  Examen-iOS
//
//  Created by Osvaldo Salas on 28/06/21.
//

import Foundation

enum NetworkError: Error {
  //
  // MARK: - Cases
  //
  case dateParseError
  case invalidPath
  case parseError
  case requestError
}
