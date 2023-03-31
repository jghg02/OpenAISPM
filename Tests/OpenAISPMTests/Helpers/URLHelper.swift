//
//  URLHelper.swift
//  
//
//  Created by Josue German Hernandez Gonzalez on 31-03-23.
//

import Foundation

import Foundation

extension URL {
    static var test = Self(string: "https://jghg02.com")!
}

extension URLRequest {
    static var test = Self(url: URL.test)
    static var testWithExtraProperties = Self(
        url: URL.test,
        cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
        timeoutInterval: 42.0
    )
}


