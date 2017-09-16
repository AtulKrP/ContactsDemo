//
//  ViewController.swift
//  ContactsDemo
//
//  Created by Atul on 03/08/17.
//  Copyright © 2017 Atul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchContacts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func fetchContacts(){
        
        ATContacts.isContactAccessible { (accessible, status) in
            
            if accessible{
                
                let contacts = ATContacts.fetchContacts()
                print(contacts.count)
                
                for con in contacts{
                    
                    print("identifier: \(con.identifier)")
                    print("familyName: \(con.familyName)")
                    print("givenName: \(con.givenName)")
                    print("middleName: \(con.middleName)")
                    print("namePrefix: \(con.namePrefix)")
                    print("nameSuffix: \(con.nameSuffix)")
                    print("nickname: \(con.nickname)")
                    print("phoneNumbers: \(con.phoneNumbers)")
                    print("emailAddresses: \(con.emailAddresses)")
                    print("-----------------------------------------\n")
                }
                
                print("\nFlatMaps")
                
            }else{
                print(status.rawValue)
            }
        }
    }

}

