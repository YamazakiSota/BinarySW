//
//  CustomLabel.swift
//  BinarySW
//
//  Created by 山崎颯汰 on 2022/05/14.
//

import UIKit

class CustomLabel: UILabel {
    
    @IBInspectable open var spacing:CGFloat = 0 {
            didSet {
                let attributedString = NSMutableAttributedString(string: self.text!)
                attributedString.addAttribute(NSAttributedString.Key.kern, value: self.spacing, range: NSRange(location: 0, length: attributedString.length))
                self.attributedText = attributedString
            }
        }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
