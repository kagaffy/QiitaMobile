//
//  QiitaMarkDownStyling.swift
//  QiitaMobile
//
//  Created by Yoshiki Tsukada on 2020/04/17.
//

import markymark

class QiitaMarkDownStyling {
    public static var paragraphStyling = ParagraphStyling()
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
    public static var linkStyling = LinkStyling()
    public static var horizontalLineStyling = HorizontalLineStyling()
    public static var codeBlockStyling = CodeBlockStyling()
    public static var inlineCodeBlockStyling = InlineCodeStyling()
    public static var quoteStyling = QuoteStyling()

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
