//
//  UrlImageView.swift
//  Recipe-iOS
//
//  Created by Jonathan Ng on 28/02/2021.
//

import SwiftUI

struct UrlImageView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    
    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? UrlImageView.defaultImage!)
            .resizable()
            .scaledToFit()
    }
    
    static var defaultImage = UIImage(named: "food")
}
