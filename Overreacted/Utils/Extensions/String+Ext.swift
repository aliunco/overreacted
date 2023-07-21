//
//  String+Ext.swift
//  Overreacted
//
//  Created by Ali Saeedifar on 7/21/23.
//

import Foundation

extension String {
    func maxLength(length: Int) -> String {
        if self.count > length {
            return "\(self.prefix(length)) ..."
        } else {
            return self
        }
    }
}
