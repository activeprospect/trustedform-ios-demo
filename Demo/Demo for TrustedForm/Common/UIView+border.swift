import UIKit

extension UIView {
    func highlightBorder() {
        layer.borderColor = UIColor.blue.cgColor
        layer.borderWidth = 1.5
    }

    func cancelHighlight() {
        setupBorder()
    }

    func setupBorder() {
        layer.borderColor = #colorLiteral(red: 0.8745098039, green: 0.8941176471, blue: 0.9098039216, alpha: 1)
        layer.borderWidth = 1
        layer.cornerRadius = 4
    }
}
