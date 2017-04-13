//
//  TabBarController.swift
//  My Mind
//
//  Created by Alexander Davis on 05/04/2017.
//  Copyright © 2017 Alexander Davis. All rights reserved.
//

import Foundation
import UIKit
import AWSCognitoIdentityProvider

class Interim: UIViewController{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

class MainTabView: UITabBarController{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
