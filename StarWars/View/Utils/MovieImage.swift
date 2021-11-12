//
//  MovieImage.swift
//  StarWars
//
//  Created by Oshitha on 11/11/21.
//

import SwiftUI

struct MovieImage: View {
    
    let image: Image
    
    var body: some View {
        image
        .resizable()
        .frame(width: 70, height: 110)
        .aspectRatio(contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .gray, radius: 10, x: 5, y: 5)
        .padding()
    }
}

