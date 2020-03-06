//
//  UIViewController.swift
//  YTS
//
//  Created by ahmed elmemy on 1/21/20.
//  Copyright © 2020 ElMeMy. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SwiftMessages
extension UIViewController {
    
    // present
    func presentDetails(viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewControllerToPresent, animated: false, completion: nil)
    }
    
    // dismiss
    func dismissDetails() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
    
    
    public static var defaultNib: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
    
    public static var storyboardIdentifier: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
}
//For making functions of the indicator appear in VC
extension UIViewController : NVActivityIndicatorViewable{
    
}

extension UIViewController {
    
    func showError(title: String?, sub: String?, type: Theme = .warning, layout: MessageView.Layout = .statusLine) {
        // Instantiate a message view from the provided card view layout. SwiftMessages searches for nib
        // files in the main bundle first, so you can easily copy them into your project and make changes.
        let view = MessageView.viewFromNib(layout: layout)
        
        // Theme message elements with the warning style.
        view.configureTheme(type)
        view.button?.isHidden = true
        // Add a drop shadow.
        //        view.configureDropShadow()
        
        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        
        view.configureContent(title: title ?? "", body: sub ?? "", iconText: "")
        
        // Show the message.
        SwiftMessages.show(view: view)
    }
}
