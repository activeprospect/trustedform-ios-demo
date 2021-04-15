//
//  FormInputsHighlightable.swift
//  TrustedForm_Demo
//
//  Created by Konrad Siemczyk on 04/01/2021.
//  Copyright © 2021 Devscale. All rights reserved.
//

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
