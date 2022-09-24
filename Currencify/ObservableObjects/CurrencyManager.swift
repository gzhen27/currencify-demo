//
//  CurrencyManager.swift
//  Currencify
//
//  Created by G Zhen on 9/24/22.
//

import Combine

class CurrencyManager: ObservableObject {
    @Published var convertResult: ConvertResult?
    
    private var cancellables: Set<AnyCancellable> = []
    
    func convert(to: String, from: String, amount: String) {
        CurrencyAPI.shared.convert(to: to, from: from, amount: amount)
            .sink { completionStatus in
                switch completionStatus {
                case .finished:
                    print("\(completionStatus)")
                case .failure(let err):
                    print("\(err.localizedDescription)")
                }
            } receiveValue: { [unowned self] result in
                self.convertResult = result
            }
            .store(in: &cancellables)
    }
}
