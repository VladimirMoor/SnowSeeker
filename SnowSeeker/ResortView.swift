//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Vladimir on 27.07.2021.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    let resort: Resort
    @State private var selectedFacility: Facility?
    @EnvironmentObject var favorites: Favorites
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            Text(resort.imageCredit)
                                .font(.footnote)
                                .padding(2)
                        }
                    }
                }
                
                Group {
                    HStack {
                        if sizeClass == .compact {
                            Spacer()
                            VStack { ResortDetailsView(resort: resort) }
                            VStack { SkiDetailsView(resort: resort) }
                            Spacer()
                        } else {
                            ResortDetailsView(resort: resort)
                            Spacer().frame(height: 0)
                            SkiDetailsView(resort: resort)
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                    
                    Text(resort.description)
                        .padding(.vertical)
                    Text("Facilities")
                        .font(.headline)
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            facility.icon
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFacility = facility
                                }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
            
            Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to favorites") {
                if self.favorites.contains(self.resort) {
                    self.favorites.remove(self.resort)
                } else {
                    self.favorites.add(self.resort)
                }
            }
            .padding()
        }
        .navigationTitle(Text("\(resort.name), \(resort.country)"))
        .navigationBarTitleDisplayMode(.inline)
        .alert(item: $selectedFacility) { (facility) -> Alert in
            facility.alert
        }
        
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
