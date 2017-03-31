import Foundation
import UIKit

public extension UILabel {
    func heightThatFits() -> CGFloat {
        if (text == nil) {
            return 0
        } else {
            if text!.isEmpty {
                return 0
            } else {
                return text!.height(withConstrainedWidth: bounds.width, font: self.font)
            }
        }
    }
}
