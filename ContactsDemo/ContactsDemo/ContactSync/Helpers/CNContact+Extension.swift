//
//  CNContact+Extension.swift
//  ContactsDemo
//
//  Created by Atul on 05/09/17.
//  Copyright © 2017 Atul. All rights reserved.
//

import Foundation
import Contacts

extension CNContact{
    
    func getContactDictionary()->[ContactKey:Any]{
        
        var contactDict:[ContactKey: Any] = [:]
        
        //Contact identifier
        if self.isKeyAvailable(CNContactIdentifierKey){
            
            contactDict[ContactKey.identifier] = identifier
        }else{
            
            contactDict[ContactKey.identifier] = ""
        }
        
        if self.isKeyAvailable(ContactKey.identifier.rawValue){
            
            contactDict[ContactKey.givenName] = givenName
        }else{
            
            contactDict[ContactKey.givenName] = ""
        }
        
        if self.isKeyAvailable(CNContactMiddleNameKey){
            
            contactDict[ContactKey.middleName] = middleName
        }else{
            
            contactDict[ContactKey.middleName] = ""
        }
        
        if self.isKeyAvailable(CNContactFamilyNameKey){
            
            contactDict[ContactKey.familyName] = familyName
        }else{
            
            contactDict[ContactKey.familyName] = ""
        }
        
        if self.isKeyAvailable(CNContactNamePrefixKey){
            
            contactDict[ContactKey.namePrefix] = namePrefix
        }else{
            
            contactDict[ContactKey.namePrefix] = ""
        }
        
        if self.isKeyAvailable(CNContactNameSuffixKey){
            
            contactDict[ContactKey.nameSuffix] = nameSuffix
        }else{
            
            contactDict[ContactKey.nameSuffix] = ""
        }
        
        if self.isKeyAvailable(CNContactNicknameKey){
            
            contactDict[ContactKey.nickname] = nickname
        }else{
            
            contactDict[ContactKey.nickname] = ""
        }
        
        if self.isKeyAvailable(CNContactPhoneNumbersKey){
            
            let phnNumbers = phoneNumbers.map({ (number) -> String in
                return number.value.stringValue.specialCharactersRemoved
            })
            
            contactDict[ContactKey.phoneNumbers] = phnNumbers
        }else{
            
            contactDict[ContactKey.phoneNumbers] = ""
        }
        
        if self.isKeyAvailable(CNContactEmailAddressesKey){
            
            let emailAdds = emailAddresses.map({ (email) -> String in
                return String(email.value)
            })
            contactDict[ContactKey.emailAddresses] = emailAdds
        }else{
            
            contactDict[ContactKey.emailAddresses] = ""
        }
        
        if self.isKeyAvailable(CNContactImageDataAvailableKey){
            
            contactDict[ContactKey.thumbnailImageData] = thumbnailImageData
        }else{
            
            contactDict[ContactKey.thumbnailImageData] = nil
        }
        
        if self.isKeyAvailable(CNContactImageDataKey){
            
            contactDict[ContactKey.imageData] = imageData
        }else{
            
            contactDict[ContactKey.imageData] = nil
        }
        
        return contactDict
    }
}
