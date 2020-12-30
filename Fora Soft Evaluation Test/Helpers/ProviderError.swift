//
//  ProviderError.swift
//  Fora Soft Evaluation Test
//
//  Created by Dimon on 29.12.2020.
//

import Foundation

enum ProviderError: Error {
    
    case badRequest
    case statusCode(Int)
    case noResponse
    case zeroData
    case otherError(Error)
    
    func getErrorDescription() -> String {
        switch self {
        case .badRequest:
            return "Bad request"
        case .statusCode(let code):
            return "Response with code = \(code)"
        case .noResponse:
            return "No response"
        case .zeroData:
            return "No data was received"
        case .otherError(let error):
            return error.localizedDescription
        }
    }
    
}
