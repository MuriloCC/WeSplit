//
//  ContentView.swift
//  WeSplit
//
//  Created by Murilo Castilho on 13/12/22.
//

import SwiftUI

struct ContentView: View {
	@State private var checkAmount = 0.0
	@State private var numberOfPeoples = 2
	@State private var tipPercentage = 20
	@FocusState private var amountIsFocused: Bool
	
	let tipPercentages = [0, 10, 15, 20, 25]
	
	var totalPerPerson: Double {
		let peoplecount = Double(numberOfPeoples + 2)
		let tipSelection = Double(tipPercentage)
		
		let tipValue = checkAmount / 100 * tipSelection
		let total = checkAmount + tipValue
		
		let totalPerPerson = total / peoplecount
		
		return totalPerPerson
	}
	
	var body: some View {
		NavigationView{
			Form{
				Section{
					TextField("Amount: ",
						value: $checkAmount, format: .currency(
							code: Locale.current.currencyCode ?? "USD")
					).keyboardType(.decimalPad)
						.focused($amountIsFocused)
					
					Picker("Number of people", selection: $numberOfPeoples) {
						ForEach(2..<100) {
							Text("\($0) people")
						}
					}
				}
				
				Section{
					Picker("Tip percentage", selection: $tipPercentage) {
						ForEach(tipPercentages, id: \.self) {
							Text($0, format: .percent)
						}
					}.pickerStyle(.segmented)
				} header: {
					Text("How much tip do you want to leave?")
				}
				
				Section{
					Text(totalPerPerson, format: .currency(
						code: Locale.current.currencyCode ?? "USD"))
				} header: {
					Text("Value for each people: ")
				}
			}.navigationTitle("WeSplit")
				.navigationBarTitleDisplayMode(.inline)
				.toolbar {
					ToolbarItemGroup(placement: .keyboard) {
						Spacer()
						Button("Done") {
							amountIsFocused = false
						}
					}
				}
		}
	}
}

func pressButton() {
	print("apertei o botao")
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
