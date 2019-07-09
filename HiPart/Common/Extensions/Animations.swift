import UIKit

extension UIView{
	func startAnim(){
		UIView.animate(withDuration: 0.01, animations: {}, completion: { bool in
			self.alpha = 0.0
			
			
			
			var transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0)
				transform = CATransform3DTranslate(transform, 45.0, 30, 0)
			
			self.layer.transform = transform
			UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [.curveEaseOut,.allowUserInteraction], animations: {
				self.alpha = 1
				self.layer.transform = CATransform3DIdentity
			}, completion: nil)
		})
	}
}
