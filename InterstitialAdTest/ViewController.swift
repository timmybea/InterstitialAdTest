//
//  ViewController.swift
//  InterstitialAdTest
//
//  Created by Tim Beals on 2018-02-05.
//  Copyright © 2018 Tim Beals. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController {

    var interstitialAd: GADInterstitial?
    
    let button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Push ME!", for: .normal)
        btn.setTitleColor(UIColor.blue, for: .normal)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GADMobileAds.configure(withApplicationID: "ca-app-pub-3940256099942544~1458002511")
        
        interstitialAd = createAndLoadInterstitial()
        
        view.backgroundColor = UIColor.white
        
    }

    override func viewWillLayoutSubviews() {
        button.removeFromSuperview()
        
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
        button.addTarget(self, action: #selector(buttonTouched(sender:)), for: .touchUpInside)
    }
  
    @objc
    func buttonTouched(sender: UIButton) {
        
        if let interstitial = self.interstitialAd {
            if interstitial.isReady {
                interstitial.present(fromRootViewController: self)
            }
        }
    }
    
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
    



}


extension ViewController: GADInterstitialDelegate {
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        self.interstitialAd = createAndLoadInterstitial()
    }
}

