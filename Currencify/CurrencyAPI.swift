//
//  CurrencyAPI.swift
//  Currencify
//
//  Created by G Zhen on 9/23/22.
//

import Foundation
import Combine

class CurrentyAPI {
    static var shared = CurrentyAPI()
    
    private let baseUrl = "https://api.currencyscoop.com/v1"
    private let convertPath = "/convert"
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    private var cancellables: Set<AnyCancellable> = []
    
    func convert(to: String, from: String, amount: String) {
        var convertUrlComponents = URLComponents(string: "\(baseUrl)\(convertPath)")
        let queryItemTo = URLQueryItem(name: "to", value: to)
        let queryItemFrom = URLQueryItem(name: "from", value: from)
        let queryItemAmount = URLQueryItem(name: "amount", value: amount)
        convertUrlComponents?.queryItems = [queryItemTo, queryItemFrom, queryItemAmount]
        
        if let url = convertUrlComponents?.url {
            session.dataTaskPublisher(for: url)
                .map { (data: Data, response: URLResponse) in
                    if let res = response as? HTTPURLResponse {
                        print("Response Status Code: \(res.statusCode)")
                    }
                    return data
                }
                .sink { completionStatus in
                    switch completionStatus {
                    case .finished:
                        print("\(completionStatus)")
                    case .failure(_):
                        print("failed to sink data from publisher")
                    }
                } receiveValue: { data in
                    let stringifyData = String(data: data, encoding: .utf8)
                    if let content = stringifyData {
                        print(content)
                    } else {
                        print("Failed to stringify the data")
                    }
                }
                .store(in: &cancellables)
        } else {
            print("The url is not valid")
        }
    }
}
