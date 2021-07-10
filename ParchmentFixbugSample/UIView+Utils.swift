//
//  UIView+Utils.swift
//  ParchmentFixbugSample
//
//  Created by Hien Pham on 7/10/21.
//  Copyright © 2021 Hien Pham. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func autoPinEdgesToSuperview() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
    }
}
