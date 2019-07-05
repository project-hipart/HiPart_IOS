

import UIKit

class FilterChip: UIButton {

    var mainColor = UIColor.mainPurple
    var defaultColor = UIColor.lightGrey
	
    
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
		
        self.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        self.borderWidth = 0.5
		self.borderColor = mainColor
  
		self.backgroundColor = UIColor.white
		
	}
    
    private func select(_ selected : Bool){
        if selected{
                self.backgroundColor = mainColor
                self.setTitleColor(UIColor.white, for: .normal)
        }else{
                self.backgroundColor = UIColor.white
                self.setTitleColor(mainColor, for: .normal)
        }
    
    }
}
