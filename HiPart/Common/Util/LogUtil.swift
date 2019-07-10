<<<<<<< HEAD


import Foundation
=======
import Foundation

>>>>>>> 1d34159a9b9e9d299576111709f556c1dab7e11a
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
