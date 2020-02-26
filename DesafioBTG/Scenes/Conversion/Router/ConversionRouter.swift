//
//  ConversionRouter.swift
//  DesafioBTG
//
//  Created by Robson Moreira on 18/02/20.
//  Copyright (c) 2020 Robson Moreira. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class ConversionRouter: NSObject, ConversionRoutingDelegate, ConversionDataPassing {
    
    weak var viewController: ConversionViewController!
    var dataStore: ConversionDataStore?
    
    func routeToSelectSourceCurrency(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! CoinListingViewController
            
            guard
                let dataStore = self.dataStore,
                let router = destinationVC.router,
                var destinationDS = router.dataStore else { return }
            
            self.passDataToCoinListingWithSourceCurrency(source: dataStore, destination: &destinationDS)
        } else {
            let destinationVC = self.viewController.storyboard?.instantiateViewController(withIdentifier: "CoinListingViewController") as! CoinListingViewController
            
            guard
                let dataStore = self.dataStore,
                let router = destinationVC.router,
                var destinationDS = router.dataStore else { return }
            
            self.passDataToCoinListingWithSourceCurrency(source: dataStore, destination: &destinationDS)
            self.navigateToCoinListing(source: self.viewController, destination: destinationVC)
        }
    }
    
    func routeToSelectToCurrency(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! CoinListingViewController
            
            guard
                let dataStore = self.dataStore,
                let router = destinationVC.router,
                var destinationDS = router.dataStore else { return }
            
            self.passDataToCoinListingWithToCurrency(source: dataStore, destination: &destinationDS)
        } else {
            let destinationVC = self.viewController.storyboard?.instantiateViewController(withIdentifier: "CoinListingViewController") as! CoinListingViewController
            
            guard
                let dataStore = self.dataStore,
                let router = destinationVC.router,
                var destinationDS = router.dataStore else { return }
            
            self.passDataToCoinListingWithToCurrency(source: dataStore, destination: &destinationDS)
            self.navigateToCoinListing(source: self.viewController, destination: destinationVC)
        }
    }
    
    func navigateToCoinListing(source: ConversionViewController, destination: CoinListingViewController) {
        source.show(destination, sender: nil)
    }
    
    func passDataToCoinListingWithSourceCurrency(source: ConversionDataStore, destination: inout CoinListingDataStore) {
        destination.currencySelected = .source
    }
    
    func passDataToCoinListingWithToCurrency(source: ConversionDataStore, destination: inout CoinListingDataStore) {
        destination.currencySelected = .to
    }
}
