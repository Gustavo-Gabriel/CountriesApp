import UIKit

extension UIImage {
    convenience init?(flagEmoji: String, size: CGSize) {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { _ in
            flagEmoji.draw(in: CGRect(origin: .zero, size: size),
                           withAttributes: [.font: UIFont.systemFont(ofSize: size.height)])
        }
        guard let cgImage = image.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
