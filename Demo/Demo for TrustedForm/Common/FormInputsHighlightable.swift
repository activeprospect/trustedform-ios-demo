import UIKit

protocol FormInputsHighlightable {}

extension FormInputsHighlightable {
    func setupInputViews(_ views: [UIControl]) {
        for view in views {
            view.setupBorder()
            view.addAction(for: .editingDidBegin) { [weak view] in
                view?.highlightBorder()
            }
            view.addAction(for: .editingDidEnd) { [weak view] in
                view?.setupBorder()
            }
        }
    }
}
