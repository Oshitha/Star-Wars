//
//  PlanetDetailViewModel.swift
//  StarWars
//
//  Created by Oshitha on 11/12/21.
//

import Foundation
import Combine

final class PlanetDetailViewModel: ObservableObject {
    
    @Published private(set) var state: State
    
    private var bag = Set<AnyCancellable>()
    
    private let input = PassthroughSubject<Event, Never>()
    
    init(planetURL: String) {
        state = .idle(planetURL)
        
        Publishers.system(
            initial: state,
            reduce: Self.reduce,
            scheduler: RunLoop.main,
            feedbacks: [
                Self.whenLoading(),
                Self.userInput(input: input.eraseToAnyPublisher())
            ]
        )
        .assign(to: \.state, on: self)
        .store(in: &bag)
    }
    
    func send(event: Event) {
        input.send(event)
    }
}

// MARK: - Inner Types

extension PlanetDetailViewModel {
    enum State {
        case idle(String)
        case loading(String)
        case loaded(PlanetDetailsItem)
        case error(Error)
    }
    
    enum Event {
        case onAppear
        case onLoaded(PlanetDetailsItem)
        case onFailedToLoad(Error)
    }
    
    struct PlanetDetailsItem {
            let id: Int
            let name: String
            let orbital_period: String?
            let gravity: String
            let url :String
        
            init(planet: PlanetDetails) {
                id = 1
                name = planet.name
                orbital_period = planet.orbitalPeriod
                gravity  = planet.gravity
                url = planet.url
            }
        }
}

// MARK: - State Machine

extension PlanetDetailViewModel {
    
    static func reduce(_ state: State, _ event: Event) -> State {
        switch state {
        case .idle(let id):
            switch event {
            case .onAppear:
                return .loading(id)
            default:
                return state
            }
        case .loading:
            switch event {
            case .onFailedToLoad(let error):
                return .error(error)
            case .onLoaded(let movie):
                return .loaded(movie)
            default:
                return state
            }
        case .loaded:
            return state
        case .error:
            return state
        }
    }
    
    static func whenLoading() -> Feedback<State, Event> {
        Feedback { (state: State) -> AnyPublisher<Event, Never> in
            guard case .loading(let url) = state else { return Empty().eraseToAnyPublisher() }
            return StarWarAPI.planetDetail(url: url)
                .map(PlanetDetailsItem.init)
                .map(Event.onLoaded)
                .catch { Just(Event.onFailedToLoad($0)) }
                .eraseToAnyPublisher()
        }
    }
    static func userInput(input: AnyPublisher<Event, Never>) -> Feedback<State, Event> {
        Feedback(run: { _ in
            return input
        })
    }
}

