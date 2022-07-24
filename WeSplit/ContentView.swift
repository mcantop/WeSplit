//
//  ContentView.swift
//  WeSplit
//
//  Created by Maciej on 24/07/2022.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 15
    let tipPercentages = [0, 10, 15, 20, 25]
    var currencyFormatter: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currencyCode ?? "USD")
    }
    
    var totalAmountPerPerson: Double {
        return amountPerPerson + tipPerPerson
    }
    
    var amountPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = checkAmount / peopleCount
        return amountPerPerson
    }
    
    var tipPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = (checkAmount / 100 * tipSelection) / peopleCount
        return tipValue
    }
    
    var totalAmount: Double {
        let peopleCount = Double(numberOfPeople + 2)
        return totalAmountPerPerson * peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount,
                              format: currencyFormatter)
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
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
                        ForEach(2 ..< 101) { number in
                            HStack {
                                Text("\(number) people")
                                    .padding()
                                Spacer()
                            }
                        }
                    }
                    .padding(-10)
                    .pickerStyle(.wheel)
                    .frame(height: 80)
                } header: {
                    Text("Number of people")
                }
                
                
                if tipPerPerson != 0.00 {
                    Section {
                        Text(totalAmountPerPerson,
                             format: currencyFormatter) +
                        Text(" (\(amountPerPerson, specifier: "%.2f")") +
                        Text(" + ") +
                        Text("\(tipPerPerson, specifier: "%.2f"))")
                        } header: {
                        Text("Per person")
                    }
                } else {
                    Section {
                        Text(totalAmountPerPerson,
                             format: currencyFormatter)
                    } header: {
                        Text("Per person")
                    }
                }
                
                Section {
                    Text(totalAmount,
                    format: currencyFormatter)
                } header: {
                    Text("Total")
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
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
