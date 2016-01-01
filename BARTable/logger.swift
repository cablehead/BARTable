import UIKit


func Log(s: String) {
    NSLog(s)

    let request = NSMutableURLRequest(
        URL: NSURL(string: "http://198.199.105.11:8000/")!)
    let session = NSURLSession.sharedSession()
    request.HTTPMethod = "POST"

    let uid = UIDevice.currentDevice().identifierForVendor!.UUIDString
    let full = uid + ": " + s
    let data = full.dataUsingEncoding(NSUTF8StringEncoding)
    request.HTTPBody = data

    let task = session.dataTaskWithRequest(
        request,
         completionHandler: {
            data, response, error -> Void in
                /*
                print("Response: \(response)")
                let strData = NSString(
                   data: data!, encoding: NSUTF8StringEncoding)
                print("Body: \(strData)") */ })

    task.resume()
}
