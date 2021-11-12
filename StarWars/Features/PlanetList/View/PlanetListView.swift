//
//  ContentView.swift
//  StarWars
//
//  Created by Oshitha on 11/11/21.
//

import SwiftUI

struct PlanetListView: View {
    
    @ObservedObject var viewModel: PlanetListViewModel
     
    var body: some View {
        
        NavigationView {
            content
                .navigationBarTitle("The Star Wars")
        }
        .onAppear { self.viewModel.send(event: .onAppear) }
    }
    
    private var content: some View {
        switch viewModel.state {
        case .idle:
            return Color.clear.eraseToAnyView()
        case .loading:
            return Spinner(isAnimating: true, style: .large).eraseToAnyView()
        case .error(let error):
            return Text(error.localizedDescription).eraseToAnyView()
        case .loaded(let planets):
            return list(of: planets).eraseToAnyView()
        }
    }
    
    private func list(of planets: [PlanetListViewModel.ListItem]) -> some View {
        
        /*return List {
            ForEach(planets.indices, id: \.self) { index in

                NavigationLink(
                    destination: PlanetDetailView(viewModel: PlanetDetailViewModel(planetURL: planets[index].url)),
                    label: { MovieListItemView(planets: planets[index]) }
                )
            }
        }*/
        
        return List(planets) { planets in
            NavigationLink(
                destination: PlanetDetailView(viewModel: PlanetDetailViewModel(planetURL: planets.url)),
                label: { MovieListItemView(planets: planets) }
            )
        }
    }
}
struct MovieListItemView: View {
    
    let planets: PlanetListViewModel.ListItem
    
   // @Environment(\.imageCache) var cache: ImageCache

    var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                title
                subTitle
            }
        }
    }
   
    private var title: some View {
        Text(planets.name)
            .font(.title)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
    private var subTitle: some View {
        Text(planets.climate)
            .font(.title2)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
    
    private var spinner: some View {
        Spinner(isAnimating: true, style: .medium)
    }
}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        //PlanetListView()
//    }
//}
