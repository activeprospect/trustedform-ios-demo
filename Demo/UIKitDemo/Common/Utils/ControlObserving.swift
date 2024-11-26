import class UIKit.UIControl

protocol ControlsObserving {
    func observe(event: UIControl.Event, of controls: [UIControl])
    func eventHasOccured()
}

extension ControlsObserving {
    func observe(event: UIControl.Event, of controls: [UIControl]) {
        controls.forEach { (control) in
            control.addAction(for: event) {
                eventHasOccured()
            }
        }
    }
}
