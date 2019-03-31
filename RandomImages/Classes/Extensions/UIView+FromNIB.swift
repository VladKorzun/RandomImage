
import UIKit

extension UIView {
	
	@discardableResult func fromNib<T : UIView>() -> T? {
		guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
			return nil
		}
		addSubview(contentView)
		translatesAutoresizingMaskIntoConstraints = false
		contentView.translatesAutoresizingMaskIntoConstraints = false
		contentView.constraintsToSuperview()
		return contentView
	}
	
}
