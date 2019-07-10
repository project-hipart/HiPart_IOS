

import UIKit
import SnapKit

class FilterChip: UIView {
<<<<<<< HEAD

	var filter : Filter!
=======
	
	var filter : Filter!
	var fillMode : Bool = true
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
	
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
<<<<<<< HEAD
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
  
=======
		commonInit()
	}
	required init?(coder : NSCoder){
		super.init(coder : coder)
		commonInit()
	}
	
	convenience init(frame: CGRect, fillMode : Bool){
		self.init(frame : frame)
		self.fillMode = fillMode
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		self.cornerRadius = self.frame.height/2
	}
	
	private func commonInit(){
		
		self.borderWidth = 0.5
		self.borderColor = mainColor
		
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
		self.backgroundColor = UIColor.white
		
		self.addSubview(self.label)
		self.label.snp.makeConstraints{[unowned self] make in
			
			self.labelLeftConstraint = make.left.equalTo(self).offset(sidePadding).constraint
<<<<<<< HEAD

=======
			
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
			self.labelRightConstraint = make.right.equalTo(self).offset(-sidePadding).constraint
			
			make.centerY.equalTo(self.snp.centerY)
			
		}
		if self.chipTitle != ""{
			self.setChipTitle(chipTitle)
		}
		self.select(chipSelected)
		self.addGestureRecognizer(self.tapRecognizer)
		
	}
<<<<<<< HEAD
    
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
=======
	
	private func select(_ selected : Bool){
		
		if fillMode{
			if selected{
				self.backgroundColor = mainColor
				self.label.textColor = UIColor.white
			}else{
				self.label.textColor = mainColor
				self.backgroundColor = UIColor.white
			}
		}else{
			if selected{
				self.borderColor = mainColor
				
				self.backgroundColor = UIColor.white
				
				self.label.textColor = mainColor
			}else{
				self.borderColor = defaultColor
				
				self.label.textColor = defaultColor
				
				self.backgroundColor = UIColor.white
			}
		}
		
	}
	
	func setChipTitle(_ title : String){
		self.label.text = title
		//		self.sizeToFit()
>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
		self.setNeedsLayout()
	}
	
	func addTarget(_ callback : @escaping () -> Void){
		callBacks.append(callback)
	}
	@objc func tapButton(_ sender : UITapGestureRecognizer){
		for s in callBacks{
			s()
		}
	}
}

