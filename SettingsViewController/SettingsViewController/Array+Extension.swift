//
//  Array+Extension.swift
//  
//
//  Created by Maciej Piotrowski on 16/10/16.
//  Copyright © 2016 Maciej Piotrowski. All rights reserved.
//

import Foundation

extension Array {
        subscript(safe position: Index) -> Element? {
        // Thanks Mike Ash
        return (0..<count ~= position) ? self[position] : nil
    }
}
