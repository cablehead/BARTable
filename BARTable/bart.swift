import UIKit
import Foundation


class Board {
	var north: [String]
	var south: [String]

	init() {
		self.north = [String]()
		self.south = [String]()
	}

	func direction(s: String) -> [String] {
		if s == "North" {return self.north}
		if s == "South" {return self.south}
		return []
	}

	func append(direction: String, estimate: String) {
		if direction == "North" {self.north.append(estimate)}
		if direction == "South" {self.south.append(estimate)}
	}

	func tostring(times: [String]) -> String {
		if times.count == 0 {return "closed"}
		var m: Int
		if times.count > 3 { m = 3 } else { m = times.count }
		return times[0...m].joinWithSeparator(", ")
	}

	func tostring_north() -> String {
		return self.tostring(self.north)
	}

	func tostring_south() -> String {
		return self.tostring(self.south)
	}

	func sort() {
		self.north.sortInPlace({str1, str2 in return Int(str1) < Int(str2)})
		self.south.sortInPlace({str1, str2 in return Int(str1) < Int(str2)})
	}
}


// need to inherit from NSObject to be a target for NSTimer
class BartWatch: NSObject {
    var code: String
    var response: (Board) -> Void
    var timer: NSTimer?

    init(code: String, response: (Board) -> Void) {
        self.code = code
        self.response = response
    }

    func start() {
        Log("BartWatch.start: \(code)")
        self.tick()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(
            10,
            target: self,
            selector: "tick",
            userInfo: nil,
            repeats: true)
    }

    func stop() {
        Log("BartWatch.stop: \(code)")
        self.timer!.invalidate()
    }

    func tick() {
        bart.get(self.code, response: self.response)
    }
}


class Bart {
    let key = "MW9S-E7SL-26DU-VV8V"

    var watch: BartWatch?

    internal func parse(value: String) -> Board {
		let b = Board()
        let xml = SWXMLHash.parse(value)
        let etd = xml["root"]["station"]["etd"]
        for dest in etd {
            for est in dest["estimate"] {
				let dir = est["direction"].element!.text!
				var s = est["minutes"].element!.text!
				if s == "Leaving" { s = "now" }
				b.append(dir, estimate: s)
			}
        }
		b.sort()
        return b
    }

    func get(code: String, response: (Board) -> Void) {
        Log("Bart.get: \(code)")
        let url =
            "http://api.bart.gov/api/etd.aspx?key=\(key)&cmd=etd&orig=\(code)"
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"

        let task = session.dataTaskWithRequest(
            request,
             completionHandler: {data, res, error -> Void in
                if error == nil {
                    let value = String(
                        data: data!, encoding: NSUTF8StringEncoding)
                    let board = self.parse(value!)
                    dispatch_async(dispatch_get_main_queue(), {
                        response(board)
                    })
                }
            })

        task.resume()
    }

    func watch(code: String, response: (Board) -> Void) {
        self.stop()
        self.watch = BartWatch(
            code: code, response: response)
        self.watch!.start()
    }

    func stop() {
        if let watch = self.watch {
            watch.stop()
            self.watch = nil
        }
    }
}


let bart = Bart()
