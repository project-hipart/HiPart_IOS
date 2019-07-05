

import UIKit
import SnapKit

class FilterChip: UIView {

    var mainColor = UIColor.mainPurple
    var defaultColor = UIColor.lightGrey
	
	private lazy var label : UILabel = {
		let view = UILabel()
		view.translatesAutoresizingMaskIntoConstraints=false
		view.font = UIFont.nanumLight.withSize(11)
		view.textAlignment = NSTextAlignment.center
		view.backgroundColor=UIColor.clear
		view.minimumScaleFactor = 0.7
		view.adjustsFontSizeToFitWidth = true
		return view
	}()
	
    
    public var chipSelected : Bool = false{
        didSet{
            self.select(chipSelected)
        }
    }
    
	
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
	
	
	override init(frame: CGRect) {
		super.init(frame : frame)
		
		
		 commonInit()
	}
	required init?(coder : NSCoder){
		super.init(coder : coder)
         commonInit()
		
	}
    override func layoutSubviews() {
        super.layoutSubviews()
		
		self.cornerRadius = self.frame.height/2
    }
	
	private func commonInit(){
		
        self.borderWidth = 0.5
		self.borderColor = mainColor
  
		self.backgroundColor = UIColor.white
		
		self.addSubview(self.label)
		self.label.snp.makeConstraints{make in
			make.left.equalTo(self).offset(10)
			make.right.equalTo(self).offset(-10)
			make.top.equalTo(self).offset(3)
			make.bottom.equalTo(self).offset(-3)
		}
		
	}
    
    private func select(_ selected : Bool){
        if selected{
                self.backgroundColor = mainColor
			self.label.textColor = UIColor.white
        }else{
			self.label.textColor = mainColor
                self.backgroundColor = UIColor.white
        }
    
    }
	
	func setChipTitle(_ title : String){
		self.label.text = title
//		self.sizeToFit()
		self.setNeedsLayout()
	}
}
