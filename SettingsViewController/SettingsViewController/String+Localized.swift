//
//  String+Localized.swift
//
//
//  Created by Maciej Piotrowski on 12/11/16.
//  Copyright © 2016 Maciej Piotrowski. All rights reserved.
//

import Foundation

fileprivate func NSLocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

//swiftlint:disable variable_name
//swiftlint:disable line_length
extension String {
    static let Settings = NSLocalizedString("Settings")
    static let SetOption1 = NSLocalizedString("Set Option 1")
    static let SetOption2 = NSLocalizedString("Set Option 2")
    static let SetOption3 = NSLocalizedString("Set Option 3")
    static let SetOption4 = NSLocalizedString("Set Option 4")
    static let Logout = NSLocalizedString("Logout")
    static let LogoutAndResetData = NSLocalizedString("Logout and Reset Data")
    static let LogoutAndRemoveAccount = NSLocalizedString("Logout and Remove Account")
    static let Cancel = NSLocalizedString("Cancel")
    static let OK = NSLocalizedString("OK")
    static let LogoutPrompt = NSLocalizedString("Would you like to logout from the application?")
    static let LogoutAndResetDataPrompt = NSLocalizedString("Would you like to reset data and logout?")
    static let LogoutAndRemoveAccountPrompt = NSLocalizedString("Would you like to remove your account and logout?")

}
//swiftlint:enable variable_name
//swiftlint:enable line_length
