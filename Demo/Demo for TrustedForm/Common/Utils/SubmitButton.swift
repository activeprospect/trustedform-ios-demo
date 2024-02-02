import UIKit

final class SubmitButton: UIButton {
    // the same colors as in SDK were used
    private let enabledBackgroundColor: UIColor = .init(red: 45/255, green: 204/255, blue: 112/255, alpha: 1)
    private let disabledBackgroundColor: UIColor = .init(red: 168/255, green: 183/255, blue: 199/255, alpha: 1)
    
    override var isEnabled: Bool {
        didSet { updateLayout() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateLayout()
    }
    
    private func updateLayout() {
        backgroundColor = isEnabled
            ? enabledBackgroundColor
            : disabledBackgroundColor
    }
}
