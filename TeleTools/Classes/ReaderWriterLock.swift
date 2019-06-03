import Foundation

public class ReaderWriterLock {

  private let queue: DispatchQueue

  public init() {
    queue = DispatchQueue(label: "com.ReadWriteCoordinator",
                          attributes: .concurrent)
  }

  public init(queueLabel label: String) {
    queue = DispatchQueue(label: label, attributes: .concurrent)
  }

  public func read<R>(_ fn: () -> R) -> R {
    var result: R?
    queue.sync {
      result = fn()
    }
    return result!
  }

  public func write(_ fn: @escaping () -> Void) {
    queue.async(flags: .barrier) {
      fn()
    }
  }

  public func blockingWrite<R>(_ fn: () -> R) -> R {
    var result: R?
    queue.sync(flags: .barrier) {
      result = fn()
    }
    return result!
  }
}
