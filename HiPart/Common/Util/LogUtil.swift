

import Foundation
func debugE(_ msg : Any...){
	if msg.count == 0{
		print("🌹",msg)
	}else{
		var msgs = ""
		for i in msg{
			msgs += "\(i) "
		}
		print("🌹",msgs)
	}
	
}
