//
//  KeyChainData.swift
//  ClockSnd
//
//  Created by Vlady on 28.11.2023.
//


import Security
import Foundation

class KeyChainHelper {
    
    public static let shared: KeyChainHelper = KeyChainHelper()
    
    private init(){}
    
    func getRecentUser() -> (String, String)? {
        if let userName = UserDefaults.standard.string(forKey: "RecentUserNameClockSnd") {
            return retrieve(username: userName)
        }
        return nil
    }
    
    func save(username: String, password: String) {
        // Set attributes
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecValueData as String: password,
        ]
        
        // Add user
        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            print("User saved successfully in the keychain")
            UserDefaults.standard.set(username, forKey: "RecentUserNameClockSnd")
        } else {
            print("Something went wrong trying to save the user in the keychain")
        }
    }
    
    func retrieve(username: String) -> (String, String)? {
        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        var item: CFTypeRef?
        // Check if user exists in the keychain
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            // Extract result
            if let existingItem = item as? [String: Any],
               let username = existingItem[kSecAttrAccount as String] as? String,
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let password = String(data: passwordData, encoding: .utf8)
            {
                return(username, password)
            }
        } else {
            print("Something went wrong trying to find the user in the keychain")
        }
        return nil
    }
    
    func delete(username: String) {
        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
        ]
        // Find user and delete
        if SecItemDelete(query as CFDictionary) == noErr {
            print("User removed successfully from the keychain")
        } else {
            print("Something went wrong trying to remove the user from the keychain")
        }
    }
}
