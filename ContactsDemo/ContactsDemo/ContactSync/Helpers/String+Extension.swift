//
//  String+Extension.swift
//  ContactsDemo
//
//  Created by Atul on 05/09/17.
//  Copyright © 2017 Atul. All rights reserved.
//

import Foundation

extension String{
    
    var trimmed: String{
        
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func removeSpecialCharacters()->String{
        
        let allowedChars : Set<Character> =  Set("0123456789+".characters)
        return String(self.characters.filter {allowedChars.contains($0) })
        
    }
    
    var specialCharactersRemoved: String{
        
        return String(self.characters.filter {Set("0123456789+".characters).contains($0) })
    }
}
