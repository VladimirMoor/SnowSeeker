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
    @ObservedObject var favorites = Favorites()
    @State private var sortBy: SortType = .byDefault
    @State private var showingFilterSheet = false
    
    var body: some View {
        NavigationView {
            
            List(
                
                resorts.sorted(by: { (Resort1, Resort2) -> Bool in
                
                switch sortBy {
                case .alphabetical:
                    return (Resort1.name < Resort2.name)
                case .country:
                    return  (Resort1.country < Resort2.country)
                default:
                    return false
                }
                }).filter { (Resort) -> Bool in
                    // filtering code here
                    return true
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingFilterSheet = true
                    } label: {
                        Text("Sort")
                    }
                }
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
        .actionSheet(isPresented: $showingFilterSheet) {
            ActionSheet(title: Text("How to sort?"), buttons: [
                .default(Text("By Default"), action: {  self.sortBy = .byDefault  }),
                .default(Text("By Alphabet"), action: { self.sortBy = .alphabetical }),
                .default(Text("By Country"), action: { self.sortBy = .country })
                
            ])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
