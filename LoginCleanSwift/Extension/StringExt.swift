//
//  StringExt.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 02.06.2022.
//

import Foundation

extension String {
    
    func replace(_ string: String, with replacement: String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal)
    }
    
    func removeWhiteSpace() -> String {
        return self.replace(" ", with: "")
    }
    
}
