//
//  MainViews.swift
//  My Mind
//
//  Created by Alexander Davis on 09/04/2017.
//  Copyright © 2017 Alexander Davis. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase

class Referrals: UIViewController{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

class ReferralConf: UIViewController{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

class Appoint: UIViewController{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

class Contact: UIViewController{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

class EmergeContacts: UITableViewController{
    @IBAction func TrustCallBtn(_ sender: UIButton) {
        if let url = URL(string: "telprompt://01213010000")
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func FwdThinkingbtn(_ sender: UIButton) {
        if let url = URL(string: "telprompt://03003000099")
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func Samaritansbtn(_ sender: UIButton) {
        if let url = URL(string: "telprompt://08457909090")
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func Sanebtn(_ sender: UIButton) {
        if let url = URL(string: "telprompt://08457678000")
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func Mindbtn(_ sender: UIButton) {
        if let url = URL(string: "telprompt://0300123393")
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func Alexsbtn(_ sender: UIButton) {
        if let url = URL(string: "telprompt://07871778000")
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
