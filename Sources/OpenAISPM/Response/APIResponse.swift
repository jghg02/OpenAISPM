//
//  APIResponse.swift
//  
//
//  Created by Josue German Hernandez Gonzalez on 16-03-23.
//

import Foundation

public struct APIResponse<N> {
    public let headers: [AnyHashable: Any]
    public let value: N
}
