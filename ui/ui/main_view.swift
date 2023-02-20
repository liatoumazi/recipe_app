//
//  main_view.swift
//  ui
//
//  Created by Lia Toumazi on 20/02/2023.
//

import SwiftUI

struct main_view: View {
    @State var searchText = ""
    @State var result = ""
    @State var isSearching = false
    @State var offset: CGFloat = .zero

    var body: some View {
        NavigationView {
            ScrollView {
                Searchbar(getResult: getResult, searchText: $searchText, isSearching: $isSearching, offset: $offset)

                if !result.isEmpty {
                    Text(result)
                        .padding()
                        .foregroundColor(.green)
                }
            }
            .navigationTitle("Find Recipes")
        }
    }

    func getResult() {
        let url = URL(string: "http://ui.com/output")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters = ["input_string": searchText]
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let result = json["result"] as? Int {
                        self.result = "Length of input string: \(result)"
                    }
                }
            }
        }.resume()
    }
}

struct main_view_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        // ContentView().colorScheme(.dark)
    }
}

struct Searchbar: View {
    var getResult: () -> Void
    @Binding var searchText: String
    @Binding var isSearching: Bool
    @Binding var offset: CGFloat

    var body: some View {
        HStack {
            HStack {
                TextField("Search ingedients here", text: $searchText) {
                    self.getResult()
                }
                .padding(.leading, 24)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(6)
            .padding(.horizontal)
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
