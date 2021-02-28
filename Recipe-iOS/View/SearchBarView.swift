//
//  SearchBarView.swift
//  Recipe-iOS
//
//  Created by Jonathan Ng on 28/02/2021.
//

import SwiftUI
import UIKit

struct SearchBar : UIViewRepresentable {
    @Binding var text : String
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        text = searchText
    }
    
    func makeCoordinator() -> Cordinator {
        return Cordinator(text: $text)
    }
    func makeUIView(context: UIViewRepresentableContext<SearchBar>)
    -> UISearchBar {
        
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = "Search"
        searchBar.delegate = context.coordinator
        return searchBar
    }
    func updateUIView(_ uiView: UISearchBar,
                      context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
    
    class Cordinator : NSObject, UISearchBarDelegate {
        @Binding var text : String
        init(text : Binding<String>)
        {
            _text = text
        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
        {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
        }
    }
}

