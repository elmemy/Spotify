//
//  SplachViewController.swift
//  YTS
//
//  Created by ahmed elmemy on 1/21/20.
//  Copyright © 2020 ElMeMy. All rights reserved.
//

import UIKit

class SplachViewController: UIViewController {
    
    let delayInSeconds = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSeconds) { [weak self] in
            let vc = Storyboard.Main.instantiate(HomeNavigationController.self)
            self?.view.window?.rootViewController = vc
        }
    }
    
    
  
    
}
