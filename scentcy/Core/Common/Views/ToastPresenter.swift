import SwiftUI
import UIKit

class ToastPresenter {
    static let shared = ToastPresenter()
    private var window: UIWindow?

    func show<Content: View>(@ViewBuilder content: @escaping () -> Content) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }

        if window == nil {
            let newWindow = PassThroughWindow(windowScene: windowScene)
            newWindow.windowLevel = .alert + 1
            newWindow.backgroundColor = .clear
            let controller = UIHostingController(rootView: content())
            controller.view.backgroundColor = .clear
            newWindow.rootViewController = controller
            self.window = newWindow
            newWindow.isHidden = false
        } else {
            let controller = UIHostingController(rootView: content())
            controller.view.backgroundColor = .clear
            window?.rootViewController = controller
            window?.isHidden = false
        }
    }

    func hide() {
        window?.isHidden = true
        window = nil
    }
}

class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event) else { return nil }
        return hitView == self.rootViewController?.view ? nil : hitView
    }
}
