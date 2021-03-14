//import UIKit
//
//fileprivate extension UIView {
//
//    @discardableResult
//    func prepareForLayout() -> Self {
//        translatesAutoresizingMaskIntoConstraints = false
//        return self
//    }
//}
//
//extension UILayoutGuide {
//    @discardableResult
//    public func prepareForLayout() -> Self { return self }
//}
//
//public extension UIView {
//
////    excluding excludedEdge: TeleLayoutEdge = .none, insets: UIEdgeInsets = .zero, relation: TeleConstraintRelation = .equal, priority: UILayoutPriority = .required, isActive: Bool = true, usingSafeArea: Bool = false
//
//    @available(tvOS 11.0, *)
//    @available(iOS 11.0, *)
//    @discardableResult
//    func edgesToSuperview(insets: UIEdgeInsets = .zero, priority: UILayoutPriority = .required, usingSafeArea: Bool = false) -> [NSLayoutConstraint] {
//        var constraints = [NSLayoutConstraint]()
//
//        constraints.append(topToSuperview(offset: insets.top, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea))
//
//        if effectiveUserInterfaceLayoutDirection == .leftToRight {
//
//            constraints.append(leftToSuperview(offset: insets.left, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea))
//
//            constraints.append(rightToSuperview(offset: -insets.right, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea))
//        } else {
//
//            constraints.append(rightToSuperview(offset: -insets.right, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea))
//
//            constraints.append(leftToSuperview(offset: insets.left, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea))
//        }
//
//        constraints.append(bottomToSuperview(offset: -insets.bottom, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea))
//
//        return constraints
//    }
//
//    @discardableResult
//    func height(to view: UIView, multiplier: CGFloat = 1, offset: CGFloat = 0, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
//        prepareForLayout()
//
//        return heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier, constant: offset).with(priority).set(isActive)
//    }
//
//    @discardableResult
//    func width(to view: UIView, multiplier: CGFloat = 1, offset: CGFloat = 0, priority: UILayoutPriority = .required, isActive: Bool = true) -> NSLayoutConstraint {
//        prepareForLayout()
//
//        return widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier, constant: offset).with(priority).set(isActive)
//    }
//
//    private func safeConstrainable(for superview: UIView?, usingSafeArea: Bool) -> TeleConstrainable {
//        guard let superview = superview else {
//            fatalError("Unable to create this constraint to it's superview, because it has no superview.")
//        }
//
//        prepareForLayout()
//
//        #if os(iOS) || os(tvOS)
//            if #available(iOS 11, tvOS 11, *){
//                if usingSafeArea {
//                    return superview.safeAreaLayoutGuide
//                }
//            }
//        #endif
//
//        return superview
//    }
//}
