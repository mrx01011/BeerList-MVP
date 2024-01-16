//
//  RandomBeerPresenter.swift
//  BeerList-MVP
//
//  Created by MacBook on 18.01.2024.
//

import Foundation

protocol RandomBeerViewPresenter: AnyObject {
    init(view: RandomView)
    func getRandom()
}

class RandomBeerPresenter: RandomBeerViewPresenter {
    private weak var view: RandomView?
    
    let networkingApi: NetworkingService!
    
    //MARK: Initialization
    required init(view: RandomView) {
        self.view = view
        self.networkingApi = NetworkManager()
    }
    //MARK: Public methods
    func getRandom() {
        networkingApi.getRandomBeer(completion: { [weak self] beers in
            self?.view?.onItemsRetrieval(beers: beers)
        })
    }
}
