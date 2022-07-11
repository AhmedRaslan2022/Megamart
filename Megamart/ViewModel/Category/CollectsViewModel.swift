//
//  CollectsViewModel.swift
//  Megamart
//
//  Created by Macintosh on 11/07/2022.
//

import Foundation
class CollectsViewModel: Collects_Protocol {
    
    var collectsArray: [Collect]? {
        didSet{
            bindingData(collectsArray, nil)
        }
    }
    
    var error: Error? {
        didSet{
            bindingData(nil, error)
        }
    }
    
    var bindingData: (([Collect]?, Error?) -> Void) = {_, _ in }
    var collectsAPIService: CollectsAPIService
    
    init(collectsAPIService: CollectsAPIService = NetworkManager()) {
        self.collectsAPIService = collectsAPIService
    }
    
    
    func fetchData() {
        collectsAPIService.fetchCollects() { collects, error in
            if let collects = collects {
                self.collectsArray = collects
            }
            if let error = error {
                self.error = error
            }
        }
    }
    
   
    
    
    
 
    
}
