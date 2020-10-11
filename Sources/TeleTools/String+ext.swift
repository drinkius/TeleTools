import UIKit

public extension Validator where Value == String {
  static func pattern(_ pattern: String, errorMessage: String) -> Validator<String> {
    return .block(message: errorMessage) {
      $0.trimmed.matches(regex: pattern)
    }
  }

  static func empty() -> Validator<String> {
    return .block() { $0.isEmpty }
  }
}

public extension String {
  var trimmed: String {
    return trimmingCharacters(in: .whitespacesAndNewlines)
  }

  func matches(regex pattern: String) -> Bool {
    return range(of: pattern, options: .regularExpression) == startIndex..<endIndex
  }
}

extension String {

  public func size(withFont font: UIFont, constrainedToWidth width: CGFloat? = nil) -> CGSize {
    //TODO: update this method after Swift 4.2 migration

    let size: CGSize
    if let width = width {
      size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
    } else {
      size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
    }

    let attributes: [NSAttributedString.Key: Any] = [ NSAttributedString.Key.font: font ]
    let result = (self as NSString).boundingRect(with: size,options: [ .usesLineFragmentOrigin ], attributes: attributes, context: nil).size

    return result
  }
}
