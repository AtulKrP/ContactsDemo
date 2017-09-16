//
//  PhoneContact.swift
//  ContactsDemo
//
//  Created by Atul on 05/09/17.
//  Copyright © 2017 Atul. All rights reserved.
//

import Foundation

class PhoneContact{
    
    let identifier          : String
    let givenName           : String
    let middleName          : String
    let familyName          : String
    let namePrefix          : String
    let nameSuffix          : String
    let nickname            : String
    let phoneNumbers        : [String]
    let emailAddresses      : [String]
    var imageData           : Data?
    var thumbnailImageData  : Data?
    
    init(with contact: [ContactKey:Any]) {
        
        identifier = contact[.identifier] as? String ?? ""
        givenName = contact[.givenName] as? String ?? ""
        middleName = contact[.middleName] as? String ?? ""
        familyName = contact[.familyName] as? String ?? ""
        nameSuffix = contact[.nameSuffix] as? String ?? ""
        namePrefix = contact[.namePrefix] as? String ?? ""
        nickname = contact[.nickname] as? String ?? ""
        phoneNumbers = contact[.phoneNumbers] as? [String] ?? []
        emailAddresses =  contact[.emailAddresses] as? [String] ?? []
        imageData = contact[.imageData] as? Data
        thumbnailImageData = contact[.thumbnailImageData] as? Data
    }
    
    func getDictionary(_ phoneContact: PhoneContact){
        
        var contact: [ContactKey:Any] = [:]
        
        contact[.identifier] = phoneContact.identifier
        contact[.givenName] = phoneContact.givenName
        contact[.middleName] = phoneContact.middleName
        contact[.familyName] = phoneContact.familyName
        contact[.nameSuffix] = phoneContact.nameSuffix
        contact[.namePrefix] = phoneContact.namePrefix
        contact[.nickname] = phoneContact.nickname
        contact[.phoneNumbers] = phoneContact.phoneNumbers
        contact[.emailAddresses] = phoneContact.emailAddresses
        contact[.imageData] = phoneContact.imageData
        contact[.thumbnailImageData] = phoneContact.thumbnailImageData
    }
}
