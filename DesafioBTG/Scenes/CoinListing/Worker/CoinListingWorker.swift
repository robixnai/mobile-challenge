//
//  CoinListingWorker.swift
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

class CoinListingWorker {
    
    func fetchCoinListing(completion: @escaping ([CoinListing.Currencies.Currency]?, Error?) -> ()) {
        CoinListingAPIStore().getCurrencies { (response, error) in
            var currencies: [CoinListing.Currencies.Currency]?
            if let response = response {
                currencies = self.orderCurrenciesByCode(currencies: response.mapFromCurrencies())
            }
            completion(currencies, error)
        }
    }
    
    func orderCurrenciesByCode(currencies: [CoinListing.Currencies.Currency]) -> [CoinListing.Currencies.Currency] {
        return currencies.sorted {
            $0.currencyCode < $1.currencyCode
        }
    }
    
    func orderCurrenciesByName(currencies: [CoinListing.Currencies.Currency]) -> [CoinListing.Currencies.Currency] {
        return currencies.sorted {
            $0.currencyCountry < $1.currencyCountry
        }
    }
    
    func filterCurrency(currencies: [CoinListing.Currencies.Currency],text: String) -> [CoinListing.Currencies.Currency] {
        return currencies.filter {
            $0.currencyCode.localizedUppercase.contains(text.localizedUppercase) ||
            $0.currencyCountry.localizedUppercase.contains(text.localizedUppercase)
        }
    }
    
}
