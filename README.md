# HiPart_IOS
![hipatLogoLogin@2x](https://user-images.githubusercontent.com/37900669/61135231-363a1200-a4fc-11e9-8dc3-319acdfc3fc8.png)

*Creative한 아마추어들의 프로다운 파트너 매칭 서비스*


## Service Development Environment
* Apple Swift version 5.0.1

## Work Flow
![WorkFlow](https://user-images.githubusercontent.com/37900669/61273563-ca4df700-a7e4-11e9-87bb-8682b56d8289.png)


**Used Libraries**

	pod ‘SwiftJson’
	pod ‘Hero’
	pod ‘SnapKit’
	pod ‘Alamofire’
	pod ‘BEMCheckBox’
	pod ‘Lottie-is’

## Main function
1. Sign in

2. Sign Up

3. Main Page: Notification

4. Main Page: Search

5. HiPat Page: Surfing Registered Users

6. HiPat Page: Filter

7. Portfolio Page: Upload & Modify

8. MyPage: Modify My Information

9. My Page: Confirm My Pick & HiPat

10. My Page: Contact to Manager

## Directory Structure
**Resources**

* Assets.xcassets

	- Create several Folders by View

* Color

		extension UIColor{
    	   @nonobjc static var darkGrey = UIColor(named: "darkGrey")!
    	   @nonobjc static var lightGrey = UIColor(named: "lightGrey")!
    	   @nonobjc static var mainGreen = UIColor(named: "mainGreen")!
    	   @nonobjc static var mainPurple = UIColor(named: "mainPurple")!
    	   @nonobjc static var middleGrey = UIColor(named: "middleGrey")!
    	   @nonobjc static var white = UIColor(named: "white")!
		}

* Font

		extension UIFont{
		   public static let nanumRegular = UIFont(name:"NanumSquareR",size: 12)!
		   public static let nanumBold = UIFont(name:"NanumSquareB",size: 12)!
		   public static let nanumExtraBold = UIFont(name:"NanumSquareEB",size: 12)!
	   	   public static let nanumLight = UIFont(name:"NanumSquareL",size: 12)!
		}


**HiPart - Common**

* Extension
example file: ViewControllerExtenstion.swift

		public func add(asChildViewController viewController: UIViewController,to parentView:UIView) {
           addChild(viewController)
           parentView.addSubview(viewController.view)
           viewController.view.frame = parentView.bounds
           viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           viewController.didMove(toParent: self)
    	}


* Util
Example file: LogUtil.swift

		func debugE(_ msg : Any...){
		   if msg.count == 0{
		      print("🌹",msg) } else {
		      var msgs = ""
		      for i in msg {
			  msgs += "\(i) "
		      }
		   print("🌹",msgs) }
		}


**Presentation**

* ViewModel

* UI


**Data**

* API

* Repository
	






