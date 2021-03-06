//
//  Icon.swift
//  ApiCore
//
//  Created by Ondrej Rafaj on 17/05/2018.
//

import Foundation
@_exported import SwiftGD


/// Icon size
public enum IconSize: Int, Codable {
    
    /// Favicon, 16x16 px
    case favicon = 16
    
    /// 64x64 px
    case at1x = 64
    
    /// 128x128 px
    case at2x = 128
    
    /// 192x192 px
    case at3x = 192
    
    /// 256x256 px
    case regular = 256
    
    /// 512x512 px
    case large = 512
    
    
    /// Size
    public var size: Size {
        return Size(width: rawValue, height: rawValue)
    }
    
    /// All values
    public static let all: [IconSize] = [
        .favicon,
        .at1x,
        .at2x,
        .at3x,
        .regular,
        .large
    ]
    
}
