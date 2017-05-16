//
//  Databases.swift
//  My Mind
//
//  Created by Alexander Davis on 09/04/2017.
//  Copyright © 2017 Alexander Davis. All rights reserved.
//

import Foundation
import UIKit

func SendRef(input: String){
        var request = URLRequest(url: URL(string: "https://www.mymindadmin.com/ReferMe.php")!)
        request.httpMethod = "GET"
        let postString = input
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()    }

