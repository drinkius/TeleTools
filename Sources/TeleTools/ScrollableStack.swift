import Foundation
import UIKit
import TinyConstraints

extension UIView {

  @discardableResult
  func add(toStackContainer to: StackContainer) -> Self {
    to.addView(self)
    return self
  }

  @discardableResult
  func add(toStack to: StackContainer,
           alignment: UIStackView.Alignment,
           axis: NSLayoutConstraint.Axis? = nil,
           distribution: UIStackView.Distribution = .fill,
           insets: UIEdgeInsets = .zero) -> Self {
    
    to.addStackable(self, alignment: alignment, axis: axis, distribution: distribution, insets: insets)
    return self
  }

  @discardableResult
  func add(toStack to: StackContainer, padding: CGFloat) -> Self {
    to.addStackable(self, alignment: .fill, insets: UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding))
    return self
  }
}

protocol StackContainer {
  var stackView: UIStackView { get }
  
  @discardableResult func addSpace(height: CGFloat) -> UIView
  func addStackable(_ view: UIView..., alignment: UIStackView.Alignment, axis: NSLayoutConstraint.Axis?, distribution: UIStackView.Distribution, insets: UIEdgeInsets, spacing: CGFloat)
  func addStackable(_ views: [UIView], alignment: UIStackView.Alignment, axis: NSLayoutConstraint.Axis?, distribution: UIStackView.Distribution, insets: UIEdgeInsets, spacing: CGFloat)
  func addView(_ view: UIView)
}

extension StackContainer {

  @discardableResult
  func addSpace(height: CGFloat) -> UIView {
    return UIView().add(to: stackView).then {
      $0.backgroundColor = UIColor.clear
      $0.height(height)
    }
  }

  func addStackable(_ view: UIView...,
    alignment: UIStackView.Alignment,
    axis: NSLayoutConstraint.Axis? = nil,
    distribution: UIStackView.Distribution = .fill,
    insets: UIEdgeInsets = .zero,
    spacing: CGFloat = 0) {

    self.addStackable(view,
                      alignment: alignment,
                      axis: axis,
                      distribution: distribution,
                      insets: insets,
                      spacing: spacing)
  }

  func addStackable(_ views: [UIView],
    alignment: UIStackView.Alignment,
    axis: NSLayoutConstraint.Axis? = nil,
    distribution: UIStackView.Distribution = .fill,
    insets: UIEdgeInsets = .zero,
    spacing: CGFloat = 0) {

    UIStackView(arrangedSubviews: views).add(to: stackView).do {
      $0.axis = axis ?? stackView.axis
      $0.alignment = alignment
      $0.layoutMargins = insets
      $0.distribution = distribution
      $0.spacing = spacing
      $0.isLayoutMarginsRelativeArrangement = true
    }
  }

  func addView(_ view: UIView) {
    view.add(to: stackView)
  }
}

extension UIStackView: StackContainer {
  var stackView: UIStackView {
    get { return self }
  }

  static func stackContainer(axis: NSLayoutConstraint.Axis = .vertical,
                             spacing: CGFloat = 0,
                             distribution: UIStackView.Distribution = .equalSpacing,
                             alignment: UIStackView.Alignment = .fill) -> UIStackView {

    let stack = UIStackView().then {
      $0.axis = axis
      $0.distribution = distribution
      $0.alignment = alignment
      $0.spacing = spacing
    }

    return stack
  }
}

public final class ScrollableStack: UIView, StackContainer {

  let scrollView = UIScrollView()
  let stackView = UIStackView()

  init(axis: NSLayoutConstraint.Axis = .vertical,
       spacing: CGFloat = 0,
       distribution: UIStackView.Distribution = .equalSpacing,
       alignment: UIStackView.Alignment = .fill) {
    
    super.init(frame: CGRect.zero)
    setup(axis: axis, spacing: spacing, distribution: distribution, alignment: alignment)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup(axis: NSLayoutConstraint.Axis = .vertical,
                     spacing: CGFloat = 0,
                     distribution: UIStackView.Distribution = .equalSpacing,
                     alignment: UIStackView.Alignment = .fill) {

    self.addSubview(scrollView)
    scrollView.do {
      $0.showsVerticalScrollIndicator = false
      $0.showsHorizontalScrollIndicator = false
      $0.edgesToSuperview()
      $0.contentInsetAdjustmentBehavior = .never
      $0.insetsLayoutMarginsFromSafeArea = false
    }

    stackView.add(to: scrollView).do {
      $0.edgesToSuperview()
      switch axis {
      case .horizontal:
        $0.height(to: scrollView)
      case .vertical:
        $0.width(to: scrollView)
      @unknown default:
        fatalError()
      }
      $0.axis = axis
      $0.distribution = distribution
      $0.alignment = alignment
      $0.spacing = spacing
    }
  }
}
