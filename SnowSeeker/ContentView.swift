//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Vladimir on 27.07.2021.
//

import SwiftUI

enum SortType {
    case byDefault, alphabetical, country
}



struct ContentView: View {
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @ObservedObject var filterHelper = FilterHelper()

    @ObservedObject var favorites = Favorites()
    @State private var sortBy: SortType = .byDefault
    @State private var showingSortingSheet = false
    @State private var showingFilterSheet = false
    
    
    var body: some View {
        NavigationView {
            
            List ( resorts.sorted(by: { (Resort1, Resort2) -> Bool in
                switch sortBy {
                case .alphabetical:
                    return (Resort1.name < Resort2.name)
                case .country:
                    return  (Resort1.country < Resort2.country)
                case .byDefault:
                    return false
                }
                }).filter { (Resort) -> Bool in
                    
                    let selectedCountry = filterHelper.countries[filterHelper.selectedCountryIndex]
                    let selectedSize = filterHelper.sizes[filterHelper.selectedSizeIndex]
                    let selectedPrice = filterHelper.prices[filterHelper.selectedPriceIndex]
                    
                    if (Resort.country == selectedCountry) || (selectedCountry == "All") {
                        if (Resort.size == selectedSize) || (selectedSize == 0) {
                            if (Resort.price == selectedPrice) || (selectedPrice == 0) {
                                return true
                            } else {
                                return false
                            }
                        } else {
                            return false
                        }
                    } else {
                        return false
                    }
                }
            )
            { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                        
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                            
                    }
                }
            }
            .navigationTitle("Resorts")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingSortingSheet = true
                    } label: {
                        Image(systemName: "arrow.up.arrow.down.circle.fill")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingFilterSheet = true
                    } label: {
                        Image(systemName: "clock")
                    }
                }
            }

            
            WelcomeView()
        }
        .environmentObject(favorites)
        .actionSheet(isPresented: $showingSortingSheet) {
            ActionSheet(title: Text("How to sort?"), buttons: [
                .default(Text("By Default"), action: {  self.sortBy = .byDefault  }),
                .default(Text("By Alphabet"), action: { self.sortBy = .alphabetical }),
                .default(Text("By Country"), action: { self.sortBy = .country }),
                .cancel()
                
            ])
        }
        .sheet(isPresented: $showingFilterSheet) {
            FilterView(filterHelper: filterHelper)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
