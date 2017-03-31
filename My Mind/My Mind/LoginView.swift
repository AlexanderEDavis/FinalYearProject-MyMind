//
//  LoginView.swift
//  My Mind
//
//  Created by Alexander Davis on 31/03/2017.
//  Copyright © 2017 Alexander Davis. All rights reserved.
//

import UIKit
import AWSMobileHubHelper

class LoginView: UIViewController {
    @IBOutlet weak var anchorView: UIView!
    
    @IBOutlet weak var customProviderButton: UIButton!
    @IBOutlet weak var customCreateAccountButton: UIButton!
    @IBOutlet weak var customForgotPasswordButton: UIButton!
    @IBOutlet weak var customUserIdField: UITextField!
    @IBOutlet weak var customPasswordField: UITextField!
    @IBOutlet weak var leftHorizontalBar: UIView!
    @IBOutlet weak var rightHorizontalBar: UIView!
    @IBOutlet weak var orSignInWithLabel: UIView!
    
    var didSignInObserver: AnyObject!
    
    var passwordAuthenticationCompletion: AWSTaskCompletionSource<AnyObject>?
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Sign In Loading.")
        
        didSignInObserver =  NotificationCenter.default.addObserver(forName: NSNotification.Name.AWSIdentityManagerDidSignIn,
                                                                    object: AWSIdentityManager.default(),
                                                                    queue: OperationQueue.main,
                                                                    using: {(note: Notification) -> Void in
                                                                        // perform successful login actions here
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(didSignInObserver)
    }
    
    func dimissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Utility Methods
    
    func handleLoginWithSignInProvider(_ signInProvider: AWSSignInProvider) {
        AWSIdentityManager.default().login(signInProvider: signInProvider, completionHandler: {(result: Any?, error: Error?) in
            // If no error reported by SignInProvider, discard the sign-in view controller.
            if error == nil {
                DispatchQueue.main.async(execute: {
                    self.presentingViewController?.dismiss(animated: true, completion: nil)
                })
            }
            print("result = \(String(describing: result)), error = \(String(describing: error))")
        })
    }
    
    func showErrorDialog(_ loginProviderName: String, withError error: NSError) {
        print("\(loginProviderName) failed to sign in w/ error: \(error)")
        let alertController = UIAlertController(title: NSLocalizedString("Sign-in Provider Sign-In Error", comment: "Sign-in error for sign-in failure."), message: NSLocalizedString("\(loginProviderName) failed to sign in w/ error: \(error)", comment: "Sign-in message structure for sign-in failure."), preferredStyle: .alert)
        let doneAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Label to cancel sign-in failure."), style: .cancel, handler: nil)
        alertController.addAction(doneAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - IBActions
    
    
}
