//
//  OnboardingPager.swift
//  BCU Mind
//
//  Created by Alexander Davis on 24/03/2017.
//  Copyright © 2017 Alexander Davis. All rights reserved.
//

import UIKit

class OnboardingPager : UIPageViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        // Set the dataSource and delegate in code.
        // I can't figure out how to do this in the Storyboard!
        dataSource = self
        delegate = self
        // This is the starting point.  Start with step zero.
        setViewControllers([getStepZero()], direction: .forward, animated: false, completion: nil)
    }
    
    func getStepZero() -> StepZero {
        return storyboard!.instantiateViewController(withIdentifier: "WelcomeScreenOne") as! StepZero
    }
    
    func getStepOne() -> StepOne {
        return storyboard!.instantiateViewController(withIdentifier: "WelcomeScreenTwo") as! StepOne
    }
    
    func getStepTwo() -> StepTwo {
        return storyboard!.instantiateViewController(withIdentifier: "WelcomeScreenThree") as! StepTwo
    }
    
}

// MARK: - UIPageViewControllerDataSource methods

extension OnboardingPager : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: StepTwo.self) {
            // 2 -> 1
            return getStepOne()
        } else if viewController.isKind(of: StepOne.self) {
            // 1 -> 0
            return getStepZero()
        } else {
            // 0 -> end of the road
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController.isKind(of: StepZero.self) {
            // 0 -> 1
            return getStepOne()
        } else if viewController.isKind(of: StepOne.self) {
            // 1 -> 2
            return getStepTwo()
        } else {
            // 2 -> end of the road
            return nil
        }
    }
    
    
    // This only gets called once, when setViewControllers is called
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}

// MARK: - UIPageViewControllerDelegate methods

extension OnboardingPager : UIPageViewControllerDelegate {
    
}
