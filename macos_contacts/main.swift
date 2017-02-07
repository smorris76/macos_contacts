//
//  main.swift
//  macos_contacts
//
//  Created by Shawn Morris on 2/7/17.
//  Copyright © 2017 Shawn Morris. All rights reserved.
//

import Foundation
import Contacts

if CommandLine.argc < 2 {
    fputs("usage: macos_contacts <search string>)\n", stderr)
} else {
    let store = CNContactStore()
    let contacts = try store.unifiedContacts(matching: CNContact.predicateForContacts(matchingName: CommandLine.arguments[1]), keysToFetch:[CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactEmailAddressesKey as CNKeyDescriptor])
    print("Found \(contacts.count) Contacts")
    for contact in contacts {
        // Checking if phone number is available for the given contact.
        if (contact.isKeyAvailable(CNContactEmailAddressesKey)) {
            for emailAddress:CNLabeledValue in contact.emailAddresses {
                print("\(emailAddress.value)\t\(contact.givenName) \(contact.familyName)")
            }
        }
    }
}
