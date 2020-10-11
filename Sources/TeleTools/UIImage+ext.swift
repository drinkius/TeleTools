import UIKit

public extension UIImage {

  var bytesSize: Int {
    return self.jpegData(compressionQuality: 1)?.count ?? 0
  }

  var kilobytesSize: Int {
    return bytesSize / 1024
  }

  var original: UIImage {
    return withRenderingMode(.alwaysOriginal)
  }

  var template: UIImage {
    return withRenderingMode(.alwaysTemplate)
  }
}

public extension UIImage {

  func compressed(quality: CGFloat = 0.5) -> UIImage? {
    guard let data = compressedData(quality: quality) else { return nil }
    return UIImage(data: data)
  }

  func compressedData(quality: CGFloat = 0.5) -> Data? {
    return self.jpegData(compressionQuality: quality)
  }

  func cropped(to rect: CGRect) -> UIImage {
    guard rect.size.height < size.height && rect.size.height < size.height else { return self }
    guard let image: CGImage = cgImage?.cropping(to: rect) else { return self }
    return UIImage(cgImage: image)
  }

  func scaled(toHeight: CGFloat, opaque: Bool = false, with orientation: UIImage.Orientation? = nil) -> UIImage? {
    let scale = toHeight / size.height
    let newWidth = size.width * scale
    UIGraphicsBeginImageContextWithOptions(CGSize(width: newWidth, height: toHeight), opaque, scale)
    draw(in: CGRect(x: 0, y: 0, width: newWidth, height: toHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
  }

  func scaled(toWidth: CGFloat, opaque: Bool = false, with orientation: UIImage.Orientation? = nil) -> UIImage? {
    let scale = toWidth / size.width
    let newHeight = size.height * scale
    UIGraphicsBeginImageContextWithOptions(CGSize(width: toWidth, height: newHeight), opaque, scale)
    draw(in: CGRect(x: 0, y: 0, width: toWidth, height: newHeight))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage
  }

  func filled(withColor color: UIColor) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    color.setFill()
    guard let context = UIGraphicsGetCurrentContext() else { return self }

    context.translateBy(x: 0, y: size.height)
    context.scaleBy(x: 1.0, y: -1.0)
    context.setBlendMode(CGBlendMode.normal)

    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    guard let mask = self.cgImage else { return self }
    context.clip(to: rect, mask: mask)
    context.fill(rect)

    let newImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return newImage
  }

  func tint(_ color: UIColor, blendMode: CGBlendMode) -> UIImage {
    let drawRect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    let context = UIGraphicsGetCurrentContext()
    context!.clip(to: drawRect, mask: cgImage!)
    color.setFill()
    UIRectFill(drawRect)
    draw(in: drawRect, blendMode: blendMode, alpha: 1.0)
    let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return tintedImage!
  }

  func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
    let maxRadius = min(size.width, size.height) / 2
    let cornerRadius: CGFloat
    if let radius = radius, radius > 0 && radius <= maxRadius {
      cornerRadius = radius
    } else {
      cornerRadius = maxRadius
    }

    UIGraphicsBeginImageContextWithOptions(size, false, scale)

    let rect = CGRect(origin: .zero, size: size)
    UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
    draw(in: rect)

    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
}

public extension UIImage {

  convenience init(color: UIColor, size: CGSize) {
    UIGraphicsBeginImageContextWithOptions(size, false, 1)

    defer {
      UIGraphicsEndImageContext()
    }

    color.setFill()
    UIRectFill(CGRect(origin: .zero, size: size))

    guard let aCgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else {
      self.init()
      return
    }

    self.init(cgImage: aCgImage)
  }
}
