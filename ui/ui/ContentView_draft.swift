//
//  ContentView.swift
//  recipe_app_ui
//
//  Created by Lia Toumazi on 04/02/2023.
//

import SwiftUI

struct ContentView_draft: View {
    
    @State var searchText = "" // var holding any text user writes in the search bar
    @State var isSearching = false
    @State var offset: CGFloat = .zero
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                searchbar(searchText: $searchText, isSearching: $isSearching, offset: $offset)
                
                ForEach((0..<20).filter({ "\($0)".contains(searchText) || searchText.isEmpty}),
                        id: \.self) { num in
                    
                            HStack {
                                Text("\(num)")
                                Spacer()
                            }.padding()
                            
                            Divider()
                                .background(Color(.systemGray4))
                                .padding(.leading)
                }
                

            }
            .navigationTitle("Find Recipes")
        }
    }
}

struct ContentView_draft_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView().colorScheme(.dark)
    }
}



struct searchbar: View {
    
    @Binding var searchText: String
    @Binding var isSearching: Bool
    @Binding var offset: CGFloat
    
    var body: some View {
        HStack {
            HStack {
                TextField("Search ingedients here", text: $searchText)
                    .padding(.leading, 24)
            }
            .padding() // height of shape
            .background(Color(.systemGray5))
            .cornerRadius(6)
            .padding(.horizontal) // white border around shape
            .onTapGesture(perform: {
                isSearching = true
            })
            
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    if isSearching { // if isSearching = true
                        Button(action: {searchText = ""}, label: {
                            Image(systemName: "xmark.circle.fill")
                            //.padding(.vertical)
                        })
                    }
                }
                    .padding(.horizontal, 32)
                    .foregroundColor(.gray)
            )
            .transition(.move(edge: .trailing))
            .animation(Animation.easeInOut(duration: 1.0), value: offset)
            
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                }, label: {
                    Text("Cancel")
                        .padding(.trailing)
                        .padding(.leading, 0)
                })
                .transition(.move(edge: .trailing))
                .animation(Animation.easeInOut(duration: 1.0), value: offset)
            }
            
        }
    }
}
