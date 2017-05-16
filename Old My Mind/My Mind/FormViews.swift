//
//  FormViews.swift
//  My Mind
//
//  Created by Alexander Davis on 11/04/2017.
//  Copyright © 2017 Alexander Davis. All rights reserved.
//

import Foundation
import UIKit
import SwiftForms
import MessageUI
import MapKit

class ReferralForm: FormViewController, MFMailComposeViewControllerDelegate{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    struct Static {
        static let nameTag = "name"
        static let passwordTag = "password"
        static let lastNameTag = "lastName"
        static let addressTag = "address"
        static let IDTag = "idnumber"
        static let GenderTag = "gender"
        static let personalEmailTag = "personalemail"
        static let uniEmailTag = "universityemail"
        static let CourseTag = "course"
        static let phoneTag = "phone"
        static let Voicemail = "voicemail"
        static let DSATag = "disabledstudent"
        static let FacultyTag = "faculty"
        static let birthday = "birthday"
        static let PastSupportTag = "pastsupport"
        static let CurrentSupportTag = "currentsupport"
        static let subjectTag = "subject"
        static let timescaleTag = "timescale"
        static let button = "button"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(ReferralForm.submit(_:)))
    }
    
    // MARK: Actions
    
    func submit() {
        
        let data = self.form.formValues().description
        
        let alertController = UIAlertController(title: "Form Completed", message: "This form has sucessfully been submitted", preferredStyle: .alert)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainController")
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in SendRef(input: data);self.tabBarController!.tabBar.items?[0].isEnabled = false;self.present(vc!, animated: true, completion: nil);})
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Private interface
    
    fileprivate func loadForm() {
        
        let form = FormDescriptor(title: "Referral Form")
        
        let section1 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        var row = FormRowDescriptor(tag: Static.button, type: .button, title: "Send Form")
        row.configuration.button.didSelectClosure = { _ in
            self.view.endEditing(true)
            self.submit()
        }
        section1.rows.append(row)
        
        let section2 = FormSectionDescriptor(headerTitle: "About Yourself", footerTitle: nil)
        
        row = FormRowDescriptor(tag: Static.nameTag, type: .name, title: "First Name")
        row.configuration.cell.appearance = ["textField.placeholder" : "First Name" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.lastNameTag, type: .name, title: "Last Name")
        row.configuration.cell.appearance = ["textField.placeholder" : "Last name" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.IDTag, type: .number, title: "Student ID")
        row.configuration.cell.appearance = ["textField.placeholder" : "12345678" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.birthday, type: .date, title: "Date of Birth")
        row.configuration.cell.showsInputToolbar = true
        section2.rows.append(row)

        row = FormRowDescriptor(tag: Static.uniEmailTag, type: .email, title: "University Email")
        row.configuration.cell.appearance = ["textField.placeholder" : "john.smith@mail.bcu.ac.uk" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.personalEmailTag, type: .email, title: "Alternative Email")
        row.configuration.cell.appearance = ["textField.placeholder" : "john.smith@outlook.com" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.phoneTag, type: .phone, title: "Phone")
        row.configuration.cell.appearance = ["textField.placeholder" : "Mobile Number" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.Voicemail, type: .booleanSwitch, title: "Can we leave a voicemail message?")
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.GenderTag, type: .picker, title: "Gender")
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
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.addressTag, type: .multilineText, title: "Address")
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.DSATag, type: .booleanSwitch, title: "Are you a disabled student (eligible for DSA)?")
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.CourseTag, type: .text, title: "Course")
        row.configuration.cell.appearance = ["textField.placeholder" : "BSc Computer Science (Hons)" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.FacultyTag, type: .picker, title: "Faculty")
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
        
        section2.rows.append(row)

        let section3 = FormSectionDescriptor(headerTitle: "What you would like to talk about.", footerTitle: nil)
        row = FormRowDescriptor(tag: Static.subjectTag, type: .multilineText, title: "")
        section3.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.timescaleTag, type: .picker, title: "How long have you been concerned?")
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
        section3.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.CurrentSupportTag, type: .multipleSelector, title: "Are you currently receiving support?")
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
        
        section3.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.PastSupportTag, type: .multipleSelector, title: "Have you received support in the past?")
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
        
        section3.rows.append(row)
        
        form.sections = [section1, section2, section3]
        
        self.form = form
    }
}

class ReqAppoint: FormViewController, MFMailComposeViewControllerDelegate{
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    struct Static {
        static let date = "date"
        static let time = "time"
        static let location = "location"
        static let phoneTag = "phone"
        static let adivsor = "advisor"
        static let reason = "reason"
        static let button = "button"
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadForm()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .plain, target: self, action: #selector(ReferralForm.submit(_:)))
    }
    
    // MARK: Actions
    
    func submit() {
        
        let data = self.form.formValues().description
        
        let alertController = UIAlertController(title: "Request Sent", message: "Your Request Has Been Sent", preferredStyle: .alert)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainController")
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in SendRef(input: data);self.tabBarController!.tabBar.items?[0].isEnabled = false;self.present(vc!, animated: true, completion: nil);})
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Private interface
    
    fileprivate func loadForm() {
        
        let form = FormDescriptor(title: "Referral Form")
        
        let section1 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        var row = FormRowDescriptor(tag: Static.button, type: .button, title: "Send Form")
        row.configuration.button.didSelectClosure = { _ in
            self.view.endEditing(true)
            self.submit()
        }
        section1.rows.append(row)
        
        let section2 = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
        
        row = FormRowDescriptor(tag: Static.date, type: .date, title: "Date Requested")
        row.configuration.cell.showsInputToolbar = true
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.time, type: .time, title: "Time Requested")
        row.configuration.cell.showsInputToolbar = true
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.location, type: .picker, title: "Location")
        row.configuration.cell.showsInputToolbar = true
        row.configuration.selection.options = (["Centre", "North", "South", "Cons", "Margaret", "Jew","Bour"] as [String]) as [AnyObject]
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? String else { return "" }
            switch option {
            case "Centre":
                return "City Centre (Curzon Building)"
            case "North":
                return "City North (Baker Building)"
            case "South":
                return "City South (Seacole Building)"
            case "Cons":
                return "The Birmingham Conservatoire"
            case "Margaret":
                return "Margaret Street"
            case "Jew":
                return "Victoria Street"
            case "Bour":
                return "Bournville Campus"
            default:
                return ""
            }
        }
        
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.phoneTag, type: .phone, title: "Phone")
        row.configuration.cell.appearance = ["textField.placeholder" : "Mobile Number" as AnyObject, "textField.textAlignment" : NSTextAlignment.right.rawValue as AnyObject]
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.adivsor, type: .picker, title: "Preferred Advisor")
        row.configuration.cell.showsInputToolbar = true
        row.configuration.selection.options = (["JS", "AD", "TM", "U"] as [String]) as [AnyObject]
        row.configuration.selection.optionTitleClosure = { value in
            guard let option = value as? String else { return "" }
            switch option {
            case "JS":
                return "John Smith"
            case "AD":
                return "Alexander Davis"
            case "TM":
                return "Tim Minchin"
            case "U":
                return "I Don't Mind"
            default:
                return ""
            }
        }
        section2.rows.append(row)
        
        row = FormRowDescriptor(tag: Static.reason, type: .multilineText, title: "Reason for Appointment")
        section2.rows.append(row)
        
        form.sections = [section1, section2]
        
        self.form = form
    }
}

class ConfAppoint: UIViewController{
    @IBOutlet var ConfirmMap: MKMapView!
    override func viewDidLoad() {
        let initalLocation = CLLocation(latitude: 52.483358, longitude: -1.883024)
        centerMapOnLocation(location: initalLocation)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        ConfirmMap.setRegion(coordinateRegion, animated: true)
    }
    @IBAction func Confirm(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Appointment Confirmed", message: "Your appointment has been confirmed.", preferredStyle: .alert)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainController")
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in self.present(vc!, animated: true, completion: nil);})
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func RequestAptbtn(_ sender: UIButton) {
        let alertController = UIAlertController(title: "New Request Made", message: "A new appointment request has been made for you.", preferredStyle: .alert)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainController")
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in self.present(vc!, animated: true, completion: nil);})
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

class UpcomingAppoint: UIViewController{
    @IBOutlet var UpcomingMap: MKMapView!
    override func viewDidLoad() {
        let initalLocation = CLLocation(latitude: 52.483358, longitude: -1.883024)
        centerMapOnLocation(location: initalLocation)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        UpcomingMap.setRegion(coordinateRegion, animated: true)
    }
    @IBAction func Cancelbtn(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Appointment Cancelled", message: "Your appointment has been cancelled.", preferredStyle: .alert)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainController")
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in self.present(vc!, animated: true, completion: nil);})
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

class PastAppoint: UIViewController{
    override func viewDidLoad() {
        let initalLocation = CLLocation(latitude: 52.483358, longitude: -1.883024)
        centerMapOnLocation(location: initalLocation)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet var PastMap: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        PastMap.setRegion(coordinateRegion, animated: true)
    }
    
}
