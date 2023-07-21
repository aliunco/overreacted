//
//  UIActivityIndicator+Ext.swift
//  Overreacted
//
//  Created by Ali Saeedifar on 7/21/23.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    var isLoading: Bool {
        get { self.isAnimating }
        set {
            DispatchQueue.main.async {
                if newValue {
                    self.startAnimating()
                } else {
                    self.stopAnimating()
                }
            }
        }
    }
}
