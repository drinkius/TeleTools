import Foundation

public protocol Fillable {
  associatedtype Data: Hashable
  func fill(_ data: Data)
}
