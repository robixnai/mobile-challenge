//
//  CoinListingInteractor.swift
//  DesafioBTG
//
//  Created by Robson Moreira on 17/02/20.
//  Copyright (c) 2020 Robson Moreira. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class CoinListingInteractor: CoinListingBusinessDelegate, CoinListingDataStore {
    
    var presenter: CoinListingPresentationDelegate!
    var worker: CoinListingWorker!
    
    var currencies: [CoinListing.Currencies.Currency]?
    var currency: CoinListing.Currencies.Currency?
    var currencySelected: CurrencySelected?
    
    init() {
        self.worker = CoinListingWorker()
    }
    
    func fetchCurrencies() {
        self.worker.fetchCoinListing { (response, error) in
            guard let response = response else {
                self.presenter.presentErrorInFetchCurrencies()
                return
            }
            self.currencies = response
            self.presenter.presentCurrencies(currencies: response)
        }
    }
    
    func orderCurrenciesByCode(currencies: [CoinListing.Currencies.Currency]) {
        let response = self.worker.orderCurrenciesByCode(currencies: currencies)
        
        self.currencies = response
        self.presenter.presentCurrencies(currencies: response)
    }
    
    func orderCurrenciesByName(currencies: [CoinListing.Currencies.Currency]) {
        let response = self.worker.orderCurrenciesByName(currencies: currencies)
        
        self.currencies = response
        self.presenter.presentCurrencies(currencies: response)
    }
    
    func selected(currency: CoinListing.Currencies.Currency, from: CurrencySelected) {
        self.currency = currency
        
        if from == .source {
            self.presenter.presentSelectedSourceCurrency()
        } else {
            self.presenter.presentSelectedToCurrency()
        }
    }
    
    func getCurrencySelected() {
        self.presenter.presentCurrencySelected(currencySelected: currencySelected)
    }
    
    func searchCurrency(text: String) {
        if text == "" {
            self.presenter.presentCurrencies(currencies: self.currencies!)
        } else {
            let response = worker.filterCurrency(currencies: self.currencies!, text: text)
            self.presenter.presentCurrencies(currencies: response)
        }
        
    }
    
}
