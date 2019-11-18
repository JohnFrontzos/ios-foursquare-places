//
//  UIViewExtension.swift
//  First iOS App
//
//  Created by Ioannis Frontzos on 12/11/19.
//  Copyright © 2019 Ioannis Frontzos. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
}
