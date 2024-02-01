import UIKit

extension UIView {
    func highlightBorder() {
        layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.6549019608, blue: 0.9411764706, alpha: 1)
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
