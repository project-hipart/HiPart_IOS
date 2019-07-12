import SnapKit
import UIKit

class UploadSuccessView: UIView {
	
	public static func showUploadSuccess(completion :  (() -> Void)? = nil){
		if let window = UIApplication.shared.keyWindow{
			let view  = UploadSuccessView()
			
			window.addSubview(view)
			
			view.containerView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.4, 1.4, 1.0)
			view.snp.makeConstraints{[weak window] make in
				make.center.equalTo(window!.snp.center)
				make.width.height.equalTo(window!)
			}
			
			
			
			UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveEaseInOut,.preferredFramesPerSecond60], animations :{
				view.containerView.layer.transform = CATransform3DIdentity
				view.containerView.alpha = 1
			}, completion: nil)
			
			UIView.animate(withDuration: 1.0, delay: 1.0, options: [], animations: {
				view.containerView.alpha = 0
			}, completion: {[unowned view] animated in
				view.removeFromSuperview()
				completion?()
			})
		}
	}
	private lazy var containerView : UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.white
		view.cornerRadius = 6
		return view
	}()
	
	private lazy var imageView : UIImageView = {
		let view = UIImageView()
		view.image = UIImage(named: "checkImg")
		view.contentMode = ContentMode.scaleAspectFit
		
		return view
	}()
	private lazy var label : UILabel = {
		let view = UILabel()
		view.text = "작품이 업로드되었습니다."
		view.font = UIFont.nanumRegular.withSize(15)
		view.textColor = UIColor.init(red: 112/255, green: 112/255, blue: 112/255, alpha: 1.0)
		
		return view
		
	}()
	
	override init(frame: CGRect) {
		super.init(frame : frame)
		commonInit()
	}
	required init?(coder : NSCoder){
		super.init(coder: coder)
		commonInit()
	}
	
	
	private func commonInit(){
		self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
		
		self.addSubview(containerView)
		self.containerView.addSubview(imageView)
		self.containerView.addSubview(label)
		
		self.containerView.snp.makeConstraints{[unowned self] make in
			make.center.equalTo(self)
			make.width.equalTo(260.adjustedWidth)
			make.height.equalTo(155.adjustedHeight)
		}
		
		self.imageView.snp.makeConstraints{[unowned self] make in
			make.centerX.equalTo(self.containerView.snp.centerX)
			make.top.equalTo(self.containerView.snp.top).offset(40.adjustedHeight)
		}
		self.label.snp.makeConstraints{[unowned self] make in
			make.top.equalTo(self.imageView.snp.bottom).offset(12.adjustedHeight)
			make.centerX.equalTo(self.containerView.snp.centerX)
		}
		
	}
}
