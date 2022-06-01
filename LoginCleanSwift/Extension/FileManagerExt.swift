//
//  FileManagerExt.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 27.05.2022.
//

import Foundation

public extension FileManager {
    static var documentDirectoryURL: URL {
        `default`.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
