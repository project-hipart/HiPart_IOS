import SnapKit
import UIKit

class PickDialogView: UIView {
	
	public static func showPickDialog(){
		if let window = UIApplication.shared.keyWindow{
			let pickedView  = PickDialogView()
			
			window.addSubview(pickedView)
			
			pickedView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.4, 1.4, 1.0)
			pickedView.snp.makeConstraints{[weak window] make in
				make.center.equalTo(window!.snp.center)
				make.width.equalTo(110)
				make.height.equalTo(110+15+28)
			}
			
	
			
			UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveEaseInOut,.preferredFramesPerSecond60], animations :{
				pickedView.layer.transform = CATransform3DIdentity
				pickedView.alpha = 1
			}, completion: nil)
			
			UIView.animate(withDuration: 1.0, delay: 1.0, options: [], animations: {
				pickedView.alpha = 0
			}, completion: {[unowned pickedView] animated in
				pickedView.removeFromSuperview()
			})
		}
	}
	
	private lazy var imageView : UIImageView = {
		let view = UIImageView()
		view.image = UIImage(named: "pickPopupImg")
		
		return view
	}()
	private lazy var bottomView : UIButton = {
		let view = UIButton()
		
		view.setTitleColor(UIColor.white, for: .normal)
		view.setTitle("PICK 했습니다.".attributedStringWithColor(["PICK"], color: UIColor.mainGreen).string, for: .normal)
		view.cornerRadius = 14
		view.titleLabel?.font = UIFont.nanumRegular.withSize(14)
		view.backgroundColor = UIColor.init(red: 67/255, green: 67/255, blue: 67/255, alpha: 0.7)
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
		self.addSubview(imageView)
		self.addSubview(bottomView)
		
		self.imageView.snp.makeConstraints{[unowned self] make in
			make.centerX.equalTo(self.snp.centerX)
			make.top.left.right.equalTo(self)
			make.width.height.equalTo(110)
		}
		
		self.bottomView.snp.makeConstraints{[unowned self] make in
			make.top.equalTo(self.snp.bottom).offset(21)
			make.width.equalTo(110)
			make.height.equalTo(28)
			make.left.bottom.right.equalTo(self)
		}
	}
}
