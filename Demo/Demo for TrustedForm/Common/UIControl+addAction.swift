//
//  UIControl+addAction.swift
//  TrustedForm_Demo
//
//  Created by Konrad Siemczyk on 04/01/2021.
//  Copyright © 2021 Devscale. All rights reserved.
//

import UIKit

typealias Closure = () -> Void

class ClosureSleeve {
    private let closure: Closure

    init(_ closure: @escaping Closure) {
        self.closure = closure
    }

    @objc func invoke() {
        closure()
    }
}

extension UIControl {
    func addAction(for controlEvents: UIControl.Event, _ closure: @escaping Closure) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, .OBJC_ASSOCIATION_RETAIN)
    }
}
