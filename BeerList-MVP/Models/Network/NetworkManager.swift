//
//  NetworkManager.swift
//  BeerList-MVP
//
//  Created by MacBook on 18.01.2024.
//

import Foundation

protocol NetworkingService {
    func getBeerList(page: Int, completion: @escaping ([Beer]) -> ())
    func searchBeer(id: Int, completion: @escaping ([Beer]) -> ())
    func getRandomBeer(completion: @escaping ([Beer]) -> ())
}

final class NetworkManager: NetworkingService {
    let session = URLSession.shared
    
    func getBeerList(page: Int, completion: @escaping ([Beer]) -> ()) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?per_page=25&page=\(page)") else { return }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, _, _) in
            DispatchQueue.main.async {
                guard let data = data,
                      let response = try? JSONDecoder().decode([Beer].self, from: data) else {
                    completion([])
                    return
                }
                completion(response)
            }
        }
        task.resume()
    }
    
    func searchBeer(id: Int, completion: @escaping ([Beer]) -> ()) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?ids=\(id)") else { return }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, _, _) in
            DispatchQueue.main.async {
                guard let data = data,
                      let response = try? JSONDecoder().decode([Beer].self, from: data) else {
                    completion([])
                    return
                }
                completion(response)
            }
        }
        task.resume()
    }
    
    func getRandomBeer(completion: @escaping ([Beer]) -> ()) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers/random") else { return }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, _, _) in
            DispatchQueue.main.async {
                guard let data = data,
                      let response = try? JSONDecoder().decode([Beer].self, from: data) else {
                    completion([])
                    return
                }
                completion(response)
            }
        }
        task.resume()
    }
}
