//
//  FilterView.swift
//  SnowSeeker
//
//  Created by Vladimir on 29.07.2021.
//

import SwiftUI

struct FilterView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var filterHelper: FilterHelper
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $filterHelper.selectedCountryIndex, label: Text("Select Country")) {
                        ForEach(0..<filterHelper.countries.count) { item in
                            Text(filterHelper.countries[item])
                        }
                    }
                }
                
                
                Section(header: Text("Select size of resorts")) {
                    Picker(selection: $filterHelper.selectedSizeIndex, label: Text("Select Size")) {
                        ForEach(0..<filterHelper.sizes.count) { item in
                            Text(item == 0 ? "All" : "\(filterHelper.sizes[item])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Select prices")) {
                    Picker(selection: $filterHelper.selectedPriceIndex, label: Text("Select Price")) {
                        ForEach(0..<filterHelper.prices.count) { item in
                            Text(item == 0 ? "All" : "\(filterHelper.prices[item])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
                
            }
            .navigationTitle("Set Filter")
        }
    }
}


