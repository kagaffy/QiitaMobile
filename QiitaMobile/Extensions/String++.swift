//
//  String++.swift
//  QiitaMobile
//
//  Created by Yoshiki Tsukada on 2020/04/09.
//

import UIKit

extension String {
    func convertHtml(withFont: UIFont? = nil, align: NSTextAlignment = .left) -> NSAttributedString {
        if let data = self.data(using: .utf8, allowLossyConversion: true),
            let attributedText = try? NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil
            ) {
            let style = NSMutableParagraphStyle()
            style.alignment = align

            let fullRange = NSRange(location: 0, length: attributedText.length)
            let mutableAttributeText = NSMutableAttributedString(attributedString: attributedText)

            if let font = withFont {
                mutableAttributeText.addAttribute(.paragraphStyle, value: style, range: fullRange)
                mutableAttributeText.enumerateAttribute(.font, in: fullRange, options: .longestEffectiveRangeNotRequired, using: { attribute, range, _ in
                    if let attributeFont = attribute as? UIFont {
                        let traits: UIFontDescriptor.SymbolicTraits = attributeFont.fontDescriptor.symbolicTraits
                        var newDescriptor = attributeFont.fontDescriptor.withFamily(font.familyName)
                        if (traits.rawValue & UIFontDescriptor.SymbolicTraits.traitBold.rawValue) != 0 {
                            newDescriptor = newDescriptor.withSymbolicTraits(.traitBold)!
                        }
                        if (traits.rawValue & UIFontDescriptor.SymbolicTraits.traitItalic.rawValue) != 0 {
                            newDescriptor = newDescriptor.withSymbolicTraits(.traitItalic)!
                        }
                        let scaledFont = UIFont(descriptor: newDescriptor, size: attributeFont.pointSize)
                        mutableAttributeText.addAttribute(.font, value: scaledFont, range: range)
                    }
                })
            }

            return mutableAttributeText
        }

        return NSAttributedString(string: self)
    }
}
