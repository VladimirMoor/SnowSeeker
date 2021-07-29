//
//  FilterHelper.swift
//  SnowSeeker
//
//  Created by Vladimir on 29.07.2021.
//

import SwiftUI

class FilterHelper: ObservableObject {
    
    @Published var selectedCountryIndex = 0
    @Published var selectedSizeIndex = 0
    @Published var selectedPriceIndex = 0
    
    var countries: [String] = ["All"]
    var sizes: [Int] = [0]
    var prices: [Int] = [0]
    
    init() {
        
        let resorts: [Resort] = Bundle.main.decode("resorts.json")
        
        for item in resorts {
            if !countries.contains(item.country) {
                countries.append(item.country)
            }
            
            if !sizes.contains(item.size) {
                sizes.append(item.size)
            }
            
            if !prices.contains(item.price) {
                prices.append(item.price)
            }
        }
        print(countries)
        print(sizes)
        print(prices)
    }
    
}
