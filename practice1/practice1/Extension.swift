//
//  Extension.swift
//  practice1
//
//  Created by DCS on 23/02/22.
//  Copyright © 2022 DCS. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    public var width : CGFloat { return frame.size.width }
    public var height : CGFloat { return frame.size.height }
    public var top : CGFloat { return frame.origin.y }
    public var bottom : CGFloat { return height + top}
    public var left : CGFloat { return frame.origin.x }
    public var right : CGFloat { return width + left }
    
}
