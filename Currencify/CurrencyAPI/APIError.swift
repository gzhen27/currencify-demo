//
//  APIError.swift
//  Currencify
//
//  Created by G Zhen on 9/24/22.
//

import Foundation

enum APIError: Error{
    case noApiKey
    case invalidUrl
    
    var localizedDescription: String {
        switch self {
        case .noApiKey:
            return "The API Key is missing."
        case .invalidUrl:
            return "The request url is invalid."
        }
    }
}
