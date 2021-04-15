//
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

private func attributedString(_ text: String, lineHeight: CGFloat, textAlignment: NSTextAlignment, font: UIFont? = nil, textColor: UIColor? = nil) -> NSAttributedString {
    var attributes: [NSAttributedString.Key: Any] = [:]
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = textAlignment
    if let font = font {
        paragraphStyle.lineSpacing = lineHeight - font.lineHeight
    }
    attributes[.paragraphStyle] = paragraphStyle
    
    if let textColor = textColor {
        attributes[.foregroundColor] = textColor
    }
    
    return boldedAttributedText(text, font: font, attributes: attributes)
}

private func boldedAttributedText(_ text: String, font: UIFont?, attributes: [NSAttributedString.Key: Any]?) -> NSAttributedString {
    let boldRegex = try? NSRegularExpression(pattern: "\\*.+\\*", options: [])
    let boldRange = boldRegex?.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count))?.range
    
    let attributedString = NSMutableAttributedString(string: text.replacingOccurrences(of: "*", with: ""), attributes: attributes)
    if let font = font,
       let boldRange = boldRange,
       let boldFontDescription = font.fontDescriptor.withSymbolicTraits(.traitBold) {
        let boldFont = UIFont(descriptor: boldFontDescription, size: font.pointSize)
        attributedString.addAttribute(
            .font,
            value: boldFont,
            range: NSRange(location: boldRange.location, length: boldRange.length - 2))
        attributedString.addAttribute(
            .font,
            value: font,
            range: NSRange(location: boldRange.location + boldRange.length - 2, length: text.count - boldRange.location - boldRange.length))
    }

    return attributedString
}
