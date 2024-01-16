//
//  SearchBeerViewPresenter.swift
//  BeerList-MVP
//
//  Created by MacBook on 18.01.2024.
//

import Foundation

protocol SearchBeerViewPresenter: AnyObject {
    init(view: SearchView)
    func search(id: Int)
}

class SearchBeerPresenter: SearchBeerViewPresenter {
    private weak var view: SearchView?
    
    let networkingApi: NetworkingService!
    
    //MARK: Initialization
    required init(view: SearchView) {
        self.view = view
        self.networkingApi = NetworkManager()
    }
    
    func search(id: Int) {
        networkingApi.searchBeer(id: id, completion: { [weak self] beers in
            self?.view?.onItemsRetrieval(beers: beers)
        })
    }
}
