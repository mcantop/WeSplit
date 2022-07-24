//
//  ContentView.swift
//  WeSplit
//
//  Created by Maciej on 24/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 15
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount,
                              format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    .keyboardType(.decimalPad)
                } header: {
                    Text("Amount")
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip percentage")
                }
                
                Section {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) { number in
                            HStack {
                                Text("\(number) people")
                                    .padding()
                                Spacer()
                            }
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 80)
                } header: {
                    Text("Number of people")
                }
            }
            .navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
