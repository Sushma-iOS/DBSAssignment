import Foundation
import UIKit

extension UIImageView {
    func setCornerRadius(radius: CGFloat, borderWidth: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
    }
}
