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
    private let decoder = JSONDecoder()
    
    private var cancellables: Set<AnyCancellable> = []
    
    func convert(to: String, from: String, amount: String) {
        guard let apiKey = Bundle.main.infoDictionary?["CURRENCY_API_KEY"] as? String else {
            print("Missing the API key for this API")
            return
        }

        var convertUrlComponents = URLComponents(string: "\(baseUrl)\(convertPath)")
        let queryItemTo = URLQueryItem(name: "to", value: to)
        let queryItemFrom = URLQueryItem(name: "from", value: from)
        let queryItemAmount = URLQueryItem(name: "amount", value: amount)
        let queryItemAPIKey = URLQueryItem(name: "api_key", value: apiKey)
        convertUrlComponents?.queryItems = [queryItemTo, queryItemFrom, queryItemAmount, queryItemAPIKey]
        
        if let url = convertUrlComponents?.url {
            session.dataTaskPublisher(for: url)
                .map { (data: Data, response: URLResponse) in
                    if let res = response as? HTTPURLResponse {
                        print("Response Status Code: \(res.statusCode)")
                    }
                    return data
                }
                .decode(type: ConvertResult.self, decoder: decoder)
                .sink { completionStatus in
                    switch completionStatus {
                    case .finished:
                        print("\(completionStatus)")
                    case .failure(_):
                        print("failed to sink data from publisher")
                    }
                } receiveValue: { data in
                    print(data.response)
                }
                .store(in: &cancellables)
        } else {
            print("The url is not valid")
        }
    }
}
