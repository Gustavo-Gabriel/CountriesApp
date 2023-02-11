import UIKit

extension UITableView {
    func scrollToTop() {
        let indexPath = IndexPath(row: 0, section: 0)
        scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
