//
//  StarWarAPI.swift
//  StarWars
//
//  Created by Oshitha on 11/12/21.
//

import Foundation
import Combine

enum StarWarAPI {
    
    /// GET RANDOM IMAGE
    static let imageBase = URL(string: "https://picsum.photos/200/300")!

    private static let base = URL(string: "https://swapi.dev/api/")!
    private static let client = Client()
    
    static func allPlanets() -> AnyPublisher<PlanetList, Error> {
        let request = URLComponents(url: base.appendingPathComponent("planets/"), resolvingAgainstBaseURL: true)?
            .request
        return client.run(request!)
    }
    
    static func planetDetail(url: String) -> AnyPublisher<PlanetDetails, Error> {
        /*let request = URLComponents(url: base.appendingPathComponent("planets/\(id)"), resolvingAgainstBaseURL: true)?
            .request*/
        
        let request =  URLComponents(url: URL(string: url)!, resolvingAgainstBaseURL: true)?
            .request
        return client.run(request!)
    }

}

private extension URLComponents {
    
    var request: URLRequest? {
        url.map { URLRequest.init(url: $0) }
    }
}

