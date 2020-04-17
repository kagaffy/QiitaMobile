//
//  QiitaMarkDownStyling.swift
//  QiitaMobile
//
//  Created by Yoshiki Tsukada on 2020/04/17.
//

import markymark

class QiitaMarkDownStyling {
    public static var paragraphStyling: ParagraphStyling = {
        var s = ParagraphStyling()
        s.baseFont = UIFont(name: "HiraginoSans-W3", size: 14)
        s.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        s.contentInsets = .init(top: 0, left: 0, bottom: 15, right: 0)
        return s
    }()

    public static var italicStyling = ItalicStyling()
    public static var boldStyling = BoldStyling()
    public static var headingStyling: HeadingStyling = {
        var s = HeadingStyling()
        s.fontsForLevels = [
            UIFont.boldSystemFont(ofSize: 26),
            UIFont.boldSystemFont(ofSize: 23),
            UIFont.boldSystemFont(ofSize: 20),
            UIFont.boldSystemFont(ofSize: 18),
            UIFont.boldSystemFont(ofSize: 15),
            UIFont.boldSystemFont(ofSize: 15),
        ]
        s.textColorsForLevels = [
            #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1),
        ]
        s.contentInsetsForLevels = [
            .init(top: 60, left: 0, bottom: 40, right: 20),
            .init(top: 40, left: 0, bottom: 40, right: 20),
            .init(top: 40, left: 0, bottom: 40, right: 20),
            .init(top: 40, left: 0, bottom: 40, right: 20),
            .init(top: 30, left: 0, bottom: 30, right: 0),
        ]
        return s
    }()

    public static var strikeThroughStyling = StrikeThroughStyling()
    public static var listStyling = ListStyling()
    public static var imageStyling = ImageStyling()
    public static var linkStyling: LinkStyling = {
        var s = LinkStyling()
        s.textColor = #colorLiteral(red: 0.2901960784, green: 0.6745098039, blue: 0, alpha: 1)
        s.baseFont = UIFont(name: "HiraginoSans-W3", size: 14)
        s.isBold = true
        s.isUnderlined = false
        return s
    }()

    public static var horizontalLineStyling = HorizontalLineStyling()
    public static var codeBlockStyling: CodeBlockStyling = {
        var s = CodeBlockStyling()
        s.backgroundColor = #colorLiteral(red: 0.2117647059, green: 0.2705882353, blue: 0.2862745098, alpha: 1)
        s.textColor = #colorLiteral(red: 0.6156862745, green: 0.6705882353, blue: 0.6823529412, alpha: 1)
        return s
    }()

    public static var inlineCodeBlockStyling: InlineCodeStyling = {
        var s = InlineCodeStyling()
        s.textColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        s.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        return s
    }()

    public static var quoteStyling: QuoteStyling = {
        var s = QuoteStyling()
        s.textColor = #colorLiteral(red: 0.4666666667, green: 0.4666666667, blue: 0.4666666667, alpha: 1)
        return s
    }()

    public static func apply(to mdView: MarkDownTextView) {
        mdView.styling.paragraphStyling = paragraphStyling
        mdView.styling.italicStyling = italicStyling
        mdView.styling.boldStyling = boldStyling
        mdView.styling.headingStyling = headingStyling
        mdView.styling.strikeThroughStyling = strikeThroughStyling
        mdView.styling.listStyling = listStyling
        mdView.styling.imageStyling = imageStyling
        mdView.styling.linkStyling = linkStyling
        mdView.styling.horizontalLineStyling = horizontalLineStyling
        mdView.styling.codeBlockStyling = codeBlockStyling
        mdView.styling.inlineCodeBlockStyling = inlineCodeBlockStyling
        mdView.styling.quoteStyling = quoteStyling
    }
}
