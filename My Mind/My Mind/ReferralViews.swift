//
//  ReferralView.swift
//  My Mind
//
//  Created by Alexander Davis on 02/04/2017.
//  Copyright © 2017 Alexander Davis. All rights reserved.
//

import Foundation
import UIKit
import SwiftForms

class Referrals : UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

class ReferralForm: FormViewController {
    
    struct Static {
        static let nameTag = "name"
        static let passwordTag = "password"
        static let lastNameTag = "lastName"
        static let jobTag = "job"
        static let emailTag = "email"
        static let URLTag = "url"
        static let phoneTag = "phone"
        static let enabled = "enabled"
        static let check = "check"
        static let segmented = "segmented"
        static let picker = "picker"
        static let birthday = "birthday"
        static let categories = "categories"
        static let multicategories = "multicategories"
        static let button = "button"
        static let stepper = "stepper"
        static let slider = "slider"
        static let textView = "textview"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(ReferralForm.submit(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ReferralForm.cancel(_:)))
    }
    
    // MARK: Actions
    
    func submit(_: UIBarButtonItem!) {
        
        let message = self.form.formValues().description
        
        let alertController = UIAlertController(title: "Form output", message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "OK", style: .cancel) { (action) in
        }
        
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func cancel(_: UIBarButtonItem!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainTabs") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: Private interface
    
    fileprivate func loadForm() {
        
        let form = FormDescriptor(title: "Referral Form")
        
        let section1 = FormSectionDescriptor(headerTitle: "What you would like to talk about.", footerTitle: "Please give details of your GP")
        
        var row = FormRowDescriptor(tag: Static.textView, type: .multilineText, title: "")
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.picker, type: .picker, title: "How long have you been concerned?")
        row.configuration.cell.showsInputToolbar = true
        row.configuration.selection.options = (["NL", "ST", "QL", "VL"] as [String]) as [AnyObject]
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? String else { return "" }
            switch option {
            case "NL":
                return "Not Long (within 1 month)"
            case "ST":
                return "Some Time (1-3 months)"
            case "QL":
                return "Quite Some Time (3-6 months)"
            case "VL":
                return "A Long Time (6+ months)"
            default:
                return ""
            }
        }
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.multicategories, type: .multipleSelector, title: "Are you currently receiving support?")
        row.configuration.cell.showsInputToolbar = true
        row.configuration.selection.options = (["No", "CBT", "CPN", "CP", "GP", "MHWA", "Psyi", "Psyo", "SW", "O"] as [String]) as [AnyObject]
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? String else { return "" }
            switch option {
            case "No":
                return "No"
            case "CBT":
                return "CBT Practitioner (e.g. Healthy Minds)"
            case "CPN":
                return "Community Psychiatric Nurse (CPN)"
            case "CP":
                return "Counsellor/Psychotherapist"
            case "GP":
                return "GP"
            case "MHWA":
                return "Mental Health/Wellbeing Adviser"
            case "Psyi":
                return "Psychiatrist"
            case "Psyo":
                return "Psychologist"
            case "SW":
                return "Social Worker"
            case "O":
                return "Other"
            default:
                return ""
            }
        }
        
        section1.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.multicategories, type: .multipleSelector, title: "Have you received support in the past?")
        row.configuration.cell.showsInputToolbar = true
        row.configuration.selection.options = (["No", "CBT", "CPN", "CP", "GP", "MHWA", "Psyi", "Psyo", "SW", "O"] as [String]) as [AnyObject]
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? String else { return "" }
            switch option {
            case "No":
                return "No"
            case "CBT":
                return "CBT Practitioner (e.g. Healthy Minds)"
            case "CPN":
                return "Community Psychiatric Nurse (CPN)"
            case "CP":
                return "Counsellor/Psychotherapist"
            case "GP":
                return "GP"
            case "MHWA":
                return "Mental Health/Wellbeing Adviser"
            case "Psyi":
                return "Psychiatrist"
            case "Psyo":
                return "Psychologist"
            case "SW":
                return "Social Worker"
            case "O":
                return "Other"
            default:
                return ""
            }
        }

        section1.rows.append(row)
        
        let section2 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        row = FormRowDescriptor(tag: Static.textView, type: .multilineText, title: "")
        
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.nameTag, type: .name, title: "First Name")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. Miguel Ángel" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.lastNameTag, type: .name, title: "Last Name")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. Ortuño" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.jobTag, type: .text, title: "Job")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. Entrepreneur" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        let section3 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        row = FormRowDescriptor(tag: Static.URLTag, type: .url, title: "URL")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. gethooksapp.com" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section3.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.phoneTag, type: .phone, title: "Phone")
        row.configuration.cell.appearance = ["textField.placeholder" : "e.g. 0034666777999" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section3.rows.append(row)
        
        let section4 = FormSectionDescriptor(headerTitle: "An example header title", footerTitle: "An example footer title")
        
        row = FormRowDescriptor(tag: Static.enabled, type: .booleanSwitch, title: "Enable")
        section4.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.check, type: .booleanCheck, title: "Doable")
        section4.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.segmented, type: .segmentedControl, title: "Priority")
        row.configuration.selection.options = ([0, 1, 2, 3] as [Int]) as [AnyObject]
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? Int else { return "" }
            switch option {
            case 0:
                return "None"
            case 1:
                return "!"
            case 2:
                return "!!"
            case 3:
                return "!!!"
            default:
                return ""
            }
        }
        
        row.configuration.cell.appearance = ["titleLabel.font" : UIFont.boldSystemFont(ofSize: 30.0), "segmentedControl.tintColor" : UIColor.red]
        
        section4.rows.append(row)
        
        let section5 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        row = FormRowDescriptor(tag: Static.picker, type: .picker, title: "Gender")
        row.configuration.cell.showsInputToolbar = true
        row.configuration.selection.options = (["F", "M", "O", "U"] as [String]) as [AnyObject]
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? String else { return "" }
            switch option {
            case "F":
                return "Female"
            case "M":
                return "Male"
            case "O":
                return "Other"
            case "U":
                return "I'd rather not to say"
            default:
                return ""
            }
        }
        
        row.value = "M" as AnyObject
        
        section5.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.birthday, type: .date, title: "Birthday")
        row.configuration.cell.showsInputToolbar = true
        section5.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.picker, type: .picker, title: "Faculty")
        row.configuration.cell.showsInputToolbar = true
        row.configuration.selection.options = (["CEBE", "HELS", "ADM", "BLSS"] as [String]) as [AnyObject]
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? String else { return "" }
            switch option {
            case "CEBE":
                return "Computing, Engineering and The Built Environment"
            case "HELS":
                return "Health, Education and Life Sciences"
            case "ADM":
                return "Arts, Design and Media"
            case "BLSS":
                return "Business, Law and Social Sciences"
            default:
                return ""
            }
        }
        
        section5.rows.append(row)
        
        let section6 = FormSectionDescriptor(headerTitle: "Stepper & Slider", footerTitle: nil)
        
        row = FormRowDescriptor(tag: Static.stepper, type: .stepper, title: "Step count")
        row.configuration.stepper.maximumValue = 200.0
        row.configuration.stepper.minimumValue = 20.0
        row.configuration.stepper.steps = 2.0
        section6.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.slider, type: .slider, title: "Slider")
        row.configuration.stepper.maximumValue = 200.0
        row.configuration.stepper.minimumValue = 20.0
        row.configuration.stepper.steps = 2.0
        row.value = 0.5 as AnyObject
        section6.rows.append(row)

        form.sections = [section1, section2, section3, section4, section5, section6]
        
        self.form = form
    }
}
