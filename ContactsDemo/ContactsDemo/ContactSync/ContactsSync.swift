//
//  ContactsSync.swift
//  ContactsDemo
//
//  Created by Atul on 01/05/17.
//  Copyright © 2017 Atul. All rights reserved.
//


import Foundation
import UIKit
import Contacts

class App{
    
    static var version: String {
        
        get {
            
            let dictionary = Bundle.main.infoDictionary!
            let version = dictionary["CFBundleShortVersionString"] as! String
            let build = dictionary["CFBundleVersion"] as! String
            return "\(version) build \(build)"
        }
    }
    
    static var appName: String{
        
        get {
            return Bundle.main.infoDictionary!["CFBundleName"]! as! String
        }
    }
}

//MARK:- Contacts Access
//======================================
class ATContacts{
    
    static var hasContactsAcces: Bool{
        
        get{
            
            let authStatus = CNContactStore.authorizationStatus(for: .contacts)
            
            switch authStatus {
                
            case .authorized:
                
                return true
                
            default:
                
                return false
            }
            
        }
    }
    
    static var allowedKeys: [CNKeyDescriptor]{
        
        return [CNContactNamePrefixKey as CNKeyDescriptor,
                CNContactGivenNameKey as CNKeyDescriptor,
                CNContactFamilyNameKey as CNKeyDescriptor,
                CNContactOrganizationNameKey as CNKeyDescriptor,
                CNContactBirthdayKey as CNKeyDescriptor,
                CNContactImageDataKey as CNKeyDescriptor,
                CNContactThumbnailImageDataKey as CNKeyDescriptor,
                CNContactImageDataAvailableKey as CNKeyDescriptor,
                CNContactPhoneNumbersKey as CNKeyDescriptor,
                CNContactEmailAddressesKey as CNKeyDescriptor,
                CNContactIdentifierKey as CNKeyDescriptor
        ]
    }
    
    class func isContactAccessible(completion: @escaping (Bool,CNAuthorizationStatus)->()){
        
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        
        switch authorizationStatus {
            
        case .notDetermined:
            
            self.requestContactsAccess(completion: { (status) in
                completion(status,authorizationStatus)
            })
            
        case .authorized:
            
            completion(true, .authorized)
            
         
        default:
            
            completion(false, authorizationStatus)
            
        }
    }
    
    class func requestContactsAccess(completion: @escaping (_ access: Bool)->Void){
        
        
        CNContactStore().requestAccess(for: .contacts, completionHandler: {(access, accessError) -> Void in
            
            // if there is no error
            if accessError == nil{
                
                if access{
                    
                    completion(true)
                    
                }else{
                    
                    completion(false)
                }
            }else{
                //if an error occurred
                if let error = accessError{
                    
                    print(error)
                }
                completion(false)
            }
        })
    }
    
    
    class func fetchContacts()->[PhoneContact]{
        
        var contactsArr = [CNContact]()
        let contactStore = CNContactStore()
      
        // Get all the containers
        var allContainers: [CNContainer] = []
        
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            print("Error fetching containers")
        }
        
        // Iterate all containers and append their contacts to our results array
        for container in allContainers {
            
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: allowedKeys)
                contactsArr.append(contentsOf: containerResults)
            } catch {
                print("Error fetching results for container")
            }
        }
        
        let fetchedPhoneContacts = contactsArr.map { (contact) -> PhoneContact in
            
            let dict = contact.getContactDictionary()
            return PhoneContact(with: dict)
        }
        
        return fetchedPhoneContacts
    }
}


//MARK:- Show Alert
//==================================
extension ATContacts{
    
    /*class func showAlert(title: String?, message: String?){
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: <#T##String?#>, style: .default) { (<#UIAlertAction#>) in
            <#code#>
        }
        
        
    }
    
    class func openSetting(_ controller: UIViewController){
        
        let alert = UIAlertController(title: "Alert", message: "Access Denied", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Open Settings", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
            
            if #available(iOS 10.0, *) {
                if let settingsUrl = URL(string: UIApplicationOpenSettingsURLString){
                    UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
                }else{
                    print("Cannot Open Settings:- iOS10")
                }
                
            } else {
                // Fallback on earlier versions
                if let settingsUrl = URL(string: UIApplicationOpenSettingsURLString){
                    UIApplication.shared.openURL(settingsUrl)
                }else{
                    print("Cannot Open Settings:- iOS below 10")
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
            controller.dismiss(animated: true, completion: nil)
        }))
        
        controller.present(alert, animated: true, completion: nil)
        
    }*/
}

extension ATContacts{
    
    /*class func returnNewContacts()->[PhoneContact]{
     
     let phoneContacts = self.fetchContacts()
     let dbContacts = SQLiteManager.fetch()
     var newContacts = [PhoneContact]()
     
     if dbContacts.count == 0{
     return phoneContacts
     }
     
     for eachContact in phoneContacts{
     
     if dbContacts.contains(where: { (contact) -> Bool in
     return eachContact.number == contact.number
     }){
     //print("Contains")
     }else{
     newContacts.append(eachContact)
     }
     }
     print("New Contact Count: \(newContacts.count)")
     return newContacts
     }
     
     class func getAllNewContact(completion: @escaping ([PhoneContact])->()){
     
     DispatchQueue.global(qos: .background).async{
     
     let phoneContacts = self.fetchContacts()
     let dbContacts = SQLiteManager.fetch()
     var newContacts = [PhoneContact]()
     
     for eachContact in phoneContacts{
     
     if dbContacts.contains(where: { (contact) -> Bool in
     return eachContact.number == contact.number
     }){
     //print("Contains")
     }else{
     newContacts.append(eachContact)
     }
     }
     print("New Contact Count: \(newContacts.count)")
     DispatchQueue.main.async {
     completion(newContacts)
     }
     }
     }
     
     class func getUpdatedContact(completion: @escaping ([PhoneContact])->()){
     
     DispatchQueue.global(qos: .background).async{
     
     let phoneContacts = self.fetchContacts()
     
     let dbContacts = SQLiteManager.fetch(.appUser) + SQLiteManager.fetch(.nonAppUser)
     
     var newContacts = [PhoneContact]()
     
     for eachContact in phoneContacts{
     
     if dbContacts.contains(where: { (contact) -> Bool in
     return eachContact.number == contact.contactNo
     }){
     //print("Contains")
     }else{
     newContacts.append(eachContact)
     }
     }
     print("New Contact Count: \(newContacts.count)")
     DispatchQueue.main.async {
     completion(newContacts)
     }
     }
     }*/
    
    /*class func openSetting(_ controller: UIViewController){
     
     let alert = UIAlertController(title: "Alert", message: "Access Denied", preferredStyle: UIAlertControllerStyle.alert)
     
     alert.addAction(UIAlertAction(title: "Open Settings", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
     
     if #available(iOS 10.0, *) {
     if let settingsUrl = URL(string: UIApplicationOpenSettingsURLString){
     UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
     }else{
     print("Cannot Open Settings:- iOS10")
     }
     
     } else {
     // Fallback on earlier versions
     if let settingsUrl = URL(string: UIApplicationOpenSettingsURLString){
     UIApplication.shared.openURL(settingsUrl)
     }else{
     print("Cannot Open Settings:- iOS below 10")
     }
     }
     }))
     
     alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
     controller.dismiss(animated: true, completion: nil)
     }))
     
     controller.present(alert, animated: true, completion: nil)
     
     }*/
}
