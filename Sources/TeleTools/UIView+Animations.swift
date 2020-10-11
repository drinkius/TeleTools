import UIKit

public struct ViewAnimate {
  public typealias Style = (UIView) -> UIView

  static func alpha(_ value: CGFloat, d: TimeInterval) -> Style {
    return { view in
      UIView.animate(withDuration: d) {
        view.alpha = value
      }
      return view
    }
  }
}

public extension UIView {
  func setAnimation(_ style: ViewAnimate.Style) {
    _ = style(self)
  }
}

public extension UIView {
  func fadeTransition(_ duration: CFTimeInterval) {
    let animation = CATransition()
    animation.timingFunction = CAMediaTimingFunction(name:
      CAMediaTimingFunctionName.easeInEaseOut)
    animation.type = CATransitionType.fade
    animation.duration = duration
    layer.add(animation, forKey: CATransitionType.fade.rawValue)
  }
}

public extension UILabel {
  func animateTextChange(_ text: String?) {
    DispatchQueue.main.async { [weak self] in
      self?.fadeTransition(0.2)
      self?.text = text
    }
  }
}

public extension UITextField {
  func animateTextChange(_ text: String?) {
    DispatchQueue.main.async { [weak self] in
      self?.fadeTransition(0.2)
      self?.text = text
    }
  }
}
