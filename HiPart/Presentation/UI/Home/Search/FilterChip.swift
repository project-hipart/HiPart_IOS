

import UIKit
import SnapKit

class FilterChip: UIView {

	var filter : Filter!
	
	let mainColor = UIColor.mainPurple
	let defaultColor = UIColor.lightGrey
	
	
	var sidePadding : CGFloat = 10
	
	@IBInspectable
	var sidePaddingInspectable : CGFloat{
		get{
			return sidePadding
		}set{
			sidePadding = newValue
			self.labelLeftConstraint.update(offset: newValue)
			self.labelRightConstraint.update(offset: -newValue)
		}
	}
	private var labelLeftConstraint : Constraint!
	private var labelRightConstraint : Constraint!
	
	var textSize :CGFloat = 11
	@IBInspectable
	var textSizeInspector : CGFloat{
		get{
			return self.textSize
		}set{
			self.textSize = newValue
			self.label.font = UIFont.nanumLight.withSize(newValue)
		}
	}
	
	@IBInspectable
	var chipTitle : String{
		get{
			return label.text ?? ""
		}set{
			self.label.text = newValue
			
		}
	}
	
	@IBInspectable
	public var chipSelected : Bool = false{
		didSet{
			self.select(chipSelected)
		}
	}
	
	
	private lazy var label : UILabel = {
		let labelView = UILabel()
		labelView.translatesAutoresizingMaskIntoConstraints=false
		print(#function,textSize)
		labelView.font = UIFont.nanumLight.withSize(self.textSize)
		labelView.textAlignment = NSTextAlignment.center
		labelView.backgroundColor=UIColor.clear
		labelView.minimumScaleFactor = 0.7
		labelView.adjustsFontSizeToFitWidth = true
		labelView.isUserInteractionEnabled=false
		return labelView
	}()
	
	private var callBacks : [() -> Void] = []
	
	private lazy var tapRecognizer : UITapGestureRecognizer = {
		let tap = UITapGestureRecognizer()
		tap.addTarget(self, action: #selector(tapButton))
		self.isUserInteractionEnabled=true
		return tap
	}()
	
	
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
		self.label.snp.makeConstraints{[unowned self] make in
			
			self.labelLeftConstraint = make.left.equalTo(self).offset(sidePadding).constraint

			self.labelRightConstraint = make.right.equalTo(self).offset(-sidePadding).constraint
			
			make.centerY.equalTo(self.snp.centerY)
			
		}
		if self.chipTitle != ""{
			self.setChipTitle(chipTitle)
		}
		self.select(chipSelected)
		self.addGestureRecognizer(self.tapRecognizer)
		
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
	
	func addTarget(_ callback : @escaping () -> Void){
		callBacks.append(callback)
	}
	@objc func tapButton(_ sender : UITapGestureRecognizer){
		print(#function)
		for s in callBacks{
			s()
		}
	}
}

