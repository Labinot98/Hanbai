//
//  String+Ext.swift
//  Hanbai
//
//  Created by Pajaziti Labinot on 25.4.24..
//

import Foundation
import CryptoKit

extension String {
    var md5Hash: String {
        let data = Data(self.utf8)
        let hashedData = Insecure.MD5.hash(data: data)
        return hashedData.map { String(format: "%02hhx", $0) }.joined()
    }
}
