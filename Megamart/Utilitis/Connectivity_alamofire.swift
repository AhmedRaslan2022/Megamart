//
//  Connectivity_Alamofire.swift
//  Sports App
//
//  Created by MAC on 21/06/2022.
//

import Foundation

import Alamofire

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
}


