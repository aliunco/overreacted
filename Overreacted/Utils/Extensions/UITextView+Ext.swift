//
//  UITextView+Ext.swift
//  Overreacted
//
//  Created by Ali Saeedifar on 7/21/23.
//

import Foundation
import UIKit

extension UITextView {
    
    func addHyperLinksToText(originalText: String, hyperLinks: [String: String], linkColor: UIColor = UIColor(hexString: "#ffa7c4")) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.textAlignment

        let lightColor = UIColor.black
        let darkColor = UIColor.white

        let textColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .dark ? darkColor : lightColor
        }


        let attributedString = NSMutableAttributedString(string: originalText)
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.font, value: font!, range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttribute(.foregroundColor, value: textColor, range: NSRange(location: 0, length: attributedString.length))

        for (hyperLink, urlString) in hyperLinks {
            let linkRange = (originalText as NSString).range(of: hyperLink)
            let url = URL(string: urlString)!
            let linkAttributes: [NSAttributedString.Key: Any] = [
                .link: url,
                .foregroundColor: linkColor
            ]
            attributedString.addAttributes(linkAttributes, range: linkRange)
        }

        self.linkTextAttributes = [
            .foregroundColor: linkColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: font!
        ]
        self.attributedText = attributedString
    }
}
