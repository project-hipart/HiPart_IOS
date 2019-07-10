import UIKit
import SnapKit

class LoadingView : UIView{

	private lazy var indicator : UIActivityIndicatorView = {
		let view = UIActivityIndicatorView()
		view.startAnimating()
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
		self.isUserInteractionEnabled = true
		self.frame = CGRect(x: 0, y: 0, width: Device.screenWidth, height: Device.screenHeight)
		self.addSubview(indicator)
		self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
		
		
		indicator.snp.makeConstraints({make in
			make.center.equalTo(self.snp.center)
		})
	}
	
	private static let shared = LoadingView()
	static func showLoadingView(){
		if let window = UIApplication.shared.keyWindow{
			window.addSubview(shared)
			
		}
	}
	static func hideLoadingView(){
		shared.removeFromSuperview()
	}
}
