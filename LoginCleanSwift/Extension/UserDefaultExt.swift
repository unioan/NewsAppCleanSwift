//
//  UserDefaultExt.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 11.04.2022.
//

import UIKit

extension UserDefaults {
    func object<T>(for key: String, logType: LogType) -> T? {
        
        let decoder = JSONDecoder()
        switch logType {
        case .userAuthData:
            guard let userAuthData = object(forKey: key + "login") as? Data else { return nil }
            let userAuth = try! decoder.decode(UserAuthData.self, from: userAuthData)
            return userAuth as! T
        case .userModel:
            guard let userModel = object(forKey: key) as? Data else { return nil }
            let userAuth = try! decoder.decode(UserModel.self, from: userModel)
            return userAuth as! T
        }
    }
}
