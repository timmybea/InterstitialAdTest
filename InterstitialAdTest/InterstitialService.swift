//
//  InterstitialService.swift
//  InterstitialAdTest
//
//  Created by Tim Beals on 2018-02-06.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import Foundation
import GoogleMobileAds

class InterstitialService: NSObject {
    
    var interstitialAd: GADInterstitial?
    
    private override init() {}
    static let shared = InterstitialService()
    
    func createAndLoadInterstitial() -> GADInterstitial {
        
        let request = GADRequest()
        //test device - window/devices/identifier
        request.testDevices = [kGADSimulatorID]
        
        //you need to create an adMob account and register the app
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        interstitial.delegate = self
        interstitial.load(request)
        return interstitial
    }
    
    func showInterstitial(in vc: ViewController) {
        if let interstitial = self.interstitialAd {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: vc)
            }
        }
    }
}

extension InterstitialService: GADInterstitialDelegate {
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.interstitialAd = createAndLoadInterstitial()
    }
    
}
