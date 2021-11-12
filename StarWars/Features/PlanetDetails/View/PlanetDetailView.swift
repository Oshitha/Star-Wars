//
//  PlanetDetailView.swift
//  StarWars
//
//  Created by Oshitha on 11/12/21.
//

import SwiftUI
import Combine

struct PlanetDetailView: View {
    
    @ObservedObject var viewModel: PlanetDetailViewModel
    //@Environment(\.imageCache) var cache: ImageCache

    var body: some View {
        content
            .onAppear { self.viewModel.send(event: .onAppear) }
    }
    
    private var content: some View {
        switch viewModel.state {
        case .idle:
            return Color.clear.eraseToAnyView()
        case .loading:
            return spinner.eraseToAnyView()
        case .error(let error):
            return Text(error.localizedDescription).eraseToAnyView()
        case .loaded(let planet):
            return self.planets(planet).eraseToAnyView()
        }
    }
    
    private func planets(_ planet: PlanetDetailViewModel.PlanetDetailsItem) -> some View {
        ScrollView {
            VStack {
                fillWidth
                
                Text(planet.name)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                   
                Text(planet.orbital_period ?? "")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                
                Text(planet.gravity)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    private var fillWidth: some View {
        HStack {
            Spacer()
        }
    }

    
    private var spinner: Spinner { Spinner(isAnimating: true, style: .large) }
 
}

