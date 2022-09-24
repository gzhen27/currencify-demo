//
//  APIError.swift
//  Currencify
//
//  Created by G Zhen on 9/24/22.
//

enum APIError: Error {
    case noApiKey
    case invalidUrl
    case serverError
    
    var localizedDescription: String {
        switch self {
        case .noApiKey:
            return "The API Key is missing."
        case .invalidUrl:
            return "The request url is invalid."
        case .serverError:
            return "Our server is down, please try again later."
        }
    }
}
