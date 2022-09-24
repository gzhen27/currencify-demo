//
//  ContentView.swift
//  Currencify
//
//  Created by G Zhen on 9/23/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var currencyManager = CurrencyManager()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Spacer()
            if let response = currencyManager.convertResult?.response {
                Text("\(response.from) \(response.amount)")
                Text("To: \(response.to)")
                Text("\(response.to) \(response.value)")
            }
            Button("Convert CNY") {
                currencyManager.convert(to: "CNY", from: "USD", amount: "100")
            }
            .padding()
            Button("Convert JPY") {
                currencyManager.convert(to: "JPY", from: "USD", amount: "100")
            }
            .padding()
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
