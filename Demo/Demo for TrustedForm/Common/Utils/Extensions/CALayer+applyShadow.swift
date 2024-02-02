import UIKit

extension CALayer {
    func applyShadow(
        color: UIColor = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1),
        alpha: Float = 0.20,
        x: CGFloat = 0,
        y: CGFloat = 5,
        blur: CGFloat = 16,
        spread: CGFloat = 0,
        cornerRadius: CGFloat = 0) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2
        shouldRasterize = true
        rasterizationScale = UIScreen.main.scale
        if spread == 0, cornerRadius == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
        }
        masksToBounds = false
    }
}
