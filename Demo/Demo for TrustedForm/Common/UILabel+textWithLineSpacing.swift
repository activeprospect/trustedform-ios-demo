import UIKit

extension UILabel {
    func textWithLineSpacing(_ text: String, lineHeight: CGFloat) {
        attributedText = attributedString(text, lineHeight: lineHeight, textAlignment: textAlignment, font: font, textColor: textColor)
    }
}

extension UITextView {
    func textWithLineSpacing(_ text: String, lineHeight: CGFloat) {
        attributedText = attributedString(text, lineHeight: lineHeight, textAlignment: textAlignment, font: font, textColor: textColor)
    }
}

private func attributedString(_ text: String, lineHeight: CGFloat, textAlignment: NSTextAlignment, font: UIFont?, textColor: UIColor?) -> NSAttributedString {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = textAlignment

    let attributedString = NSMutableAttributedString(string: text)
    let range = NSRange(location: 0, length: text.count)
    if let font = font {
        paragraphStyle.lineSpacing = lineHeight - font.lineHeight
        attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
    }
    if let textColor = textColor {
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor, range: range)
    }
    attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)

    return attributedString
}
