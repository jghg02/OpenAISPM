//
//  Array+Extesnsion.swift
//  
//
//  Created by Josue German Hernandez Gonzalez on 15-03-23.
//

import Foundation

extension Array where Element == Message {
    var contentCount: Int { reduce(0, { $0 + $1.content.count }) }
}
