//
//  ContentView.swift
//  recipe_app_ui
//
//  Created by Lia Toumazi on 04/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = PeopleViewModel()
    @State private var query = ""
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(vm.filteredData) { person in
                    
                    PersonView(person: person)
                }
            }
            .navigationTitle("Recipes")
            .searchable(text: $query, prompt: "Search ingredients here")
            .onChange(of: query) { newQuery in
                vm.search(with: newQuery)
                
            }
            
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView().colorScheme(.dark)
    }
}

