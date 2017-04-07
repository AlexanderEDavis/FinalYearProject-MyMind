//
//  LoginView.swift
//  My Mind
//
//  Created by Alexander Davis on 31/03/2017.
//  Copyright © 2017 Alexander Davis. All rights reserved.
//

import UIKit
import AWSMobileHubHelper
import AWSCognitoIdentityProvider

class LoginView: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
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
                                                                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                                        let viewController = storyboard.instantiateViewController(withIdentifier: "MainController")
                                                                        //self.present(viewController, animated:true, completion:nil);
                                                                        self.present(viewController, animated: true, completion:nil);
                                                                        // perform successful login actions here */
                                                                        
        })
        
       // NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: NSNotification.Name.AWSIdentityManagerDidSignIn, object: AWSIdentityManager.default());
        
        customProviderButton.addTarget(self, action: #selector(self.handleCustomSignIn), for: .touchUpInside)
        customCreateAccountButton.addTarget(self, action: #selector(self.handleUserPoolSignUp), for: .touchUpInside)
        customForgotPasswordButton.addTarget(self, action: #selector(self.handleUserPoolForgotPassword), for: .touchUpInside)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(didSignInObserver)
    }
    
    func dimissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func loginSuccess() -> Void {
        print("success login");
    }
    
    
    func startNewPasswordRequired() -> AWSCognitoIdentityNewPasswordRequired {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PwdChange")
        self.present(viewController, animated: true, completion:nil)
        return ChangePasswordView.self as! AWSCognitoIdentityNewPasswordRequired;
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

class ChangePasswordView: UIViewController{
    var newPasswordCompletion: AWSTaskCompletionSource<AWSCognitoIdentityNewPasswordRequiredDetails>?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension ChangePasswordView: AWSCognitoIdentityNewPasswordRequired {
    func getNewPasswordDetails(_ newPasswordRequiredInput: AWSCognitoIdentityNewPasswordRequiredInput, newPasswordRequiredCompletionSource:
        AWSTaskCompletionSource<AWSCognitoIdentityNewPasswordRequiredDetails>) {
        self.newPasswordCompletion = newPasswordRequiredCompletionSource
    }
    
    func didCompleteNewPasswordStepWithError(_ error: Error?) {
        if let error = error as NSError? {
            // Handle error
        } else {
            // Handle success, in my case simply dismiss the view controller
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

class AccountSettings: UIViewController{
    @IBAction func Logout(_ sender: UIButton) {
        let pool = AWSCognitoIdentityUserPool(forKey: "UserPool")
        let user = pool.currentUser()
        user?.signOut()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "OnBoard")
        //self.present(viewController, animated:true, completion:nil);
        self.present(viewController, animated: true, completion:nil);
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
}
