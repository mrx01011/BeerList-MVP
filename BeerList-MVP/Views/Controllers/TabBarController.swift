//
//  ViewController.swift
//  BeerList-MVP
//
//  Created by MacBook on 16.01.2024.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarItems()
    }

    private func configureTabBarItems() {
        let listVC = BeerListVC()
        let listPresenter = BeerListPresenter(view: listVC)
        listVC.presenter = listPresenter
        listVC.tabBarItem = UITabBarItem(title: "Beer List", image: UIImage(systemName: "list.bullet.clipboard"), tag: 0)

        let searchVC = SearchBeerVC()
        let searchPresenter = SearchBeerPresenter(view: searchVC)
        searchVC.presenter = searchPresenter
        searchVC.tabBarItem = UITabBarItem(title: "Search ID", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        let randomVC = RandomBeerVC()
        let randomPresenter = RandomBeerPresenter(view: randomVC)
        randomVC.presenter = randomPresenter
        randomVC.tabBarItem = UITabBarItem(title: "Random", image: UIImage(systemName: "dice"), tag: 2)

        let listNavigationVC = UINavigationController(rootViewController: listVC)
        let searchNavigationVC = UINavigationController(rootViewController: searchVC)
        let randomNavigationVC = UINavigationController(rootViewController: randomVC)
        setViewControllers([listNavigationVC, searchNavigationVC, randomNavigationVC], animated: false)
    }
}
