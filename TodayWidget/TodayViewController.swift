import UIKit
import CoreLocation

import NotificationCenter


@objc (TodayViewController)


class TodayViewController:
        UIViewController,
        NCWidgetProviding,
        CLLocationManagerDelegate {

    let manager = CLLocationManager()

    let h1 = UILabel()
    let txt1 = UILabel()
    let txt2 = UILabel()
    let stack = UIStackView()

    var station: Station?

    init() {
        Log("INIT!")

        super.init(nibName: nil, bundle: nil)

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager.distanceFilter = 100
        manager.startUpdatingLocation()
    }

    deinit {
        Log("DEINIT!")
    }

    override func loadView() {
        Log("load view")
        view = UIView(frame:CGRect(x:0.0, y:0, width:320.0, height:60.0))
    }

    override func viewWillAppear(animated: Bool) {
        Log("willAppear")
        self.start_watch()
    }

    override func viewWillDisappear(animated: Bool) {
        Log("willDisappear")
        self.stop_watch()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if CLLocationManager.authorizationStatus() == .AuthorizedAlways {
            Log("viewDidLoad: AUTHED")
        } else {
            Log("viewDidLoad: WAHH :(")
        }

        view.backgroundColor = .clearColor()

        self.preferredContentSize = CGSizeMake(320, 60);

        stack.frame = view.frame
        stack.axis = .Vertical
        stack.distribution = .FillProportionally

        let s2 = UIStackView()

        h1.text = "locating..."
        h1.numberOfLines = 0
        h1.font =  .preferredFontForTextStyle(UIFontTextStyleHeadline)
        h1.textColor = UIColor(red:0.663, green:0.686, blue:0.769, alpha:1)

        let h2 = UILabel()
        h2.text = "North"
        h2.numberOfLines = 0
        h2.font =  .preferredFontForTextStyle(UIFontTextStyleSubheadline)
        h2.textColor = UIColor(red:0.663, green:0.686, blue:0.769, alpha:1)

        let h3 = UILabel()
        h3.text = "South"
        h3.numberOfLines = 0
        h3.font =  .preferredFontForTextStyle(UIFontTextStyleSubheadline)
        h3.textColor = UIColor(red:0.663, green:0.686, blue:0.769, alpha:1)
        h3.textAlignment = .Right

        s2.addArrangedSubview(h2)
        s2.addArrangedSubview(h3)

        let s3 = UIStackView()

        txt1.font =  .preferredFontForTextStyle(UIFontTextStyleTitle3)
        txt1.textColor = .whiteColor()

        // txt2.numberOfLines = 0
        // txt2.font =  .preferredFontForTextStyle(UIFontTextStyleBody)
        txt2.font =  .preferredFontForTextStyle(UIFontTextStyleTitle3)
        txt2.textColor = .whiteColor()

        s3.addArrangedSubview(txt1)
        s3.addArrangedSubview(txt2)

        stack.addArrangedSubview(h1)
        stack.addArrangedSubview(s2)
        stack.addArrangedSubview(s3)

        self.settext("...", s2: "...")
        view.addSubview(stack)
    }

    func widgetMarginInsetsForProposedMarginInsets(
        defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        //return UIEdgeInsetsZero
        return UIEdgeInsetsMake(
            defaultMarginInsets.top,
            defaultMarginInsets.left,
            CGFloat(10),
            defaultMarginInsets.left)
    }

    func widgetPerformUpdateWithCompletionHandler(
                completionHandler: ((NCUpdateResult) -> Void)) {
        Log("update")
        // self.settext("...", s2: "...")
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        completionHandler(NCUpdateResult.NoData)
    }

    func settext(s1: String, s2: String) {
        self.txt1.text = s1
        self.txt2.text = s2
        self.resize()
    }

    func resize() {
        let height = stack.systemLayoutSizeFittingSize(
            UILayoutFittingExpandedSize).height * 1.7
        // Log("height: " + String(height))
        view.frame.size.height = height
        stack.frame = view.frame
        self.preferredContentSize = CGSizeMake(320, height)
    }

    func start_watch() {
        if let station = self.station {
            bart.watch(
                station.code,
                response: { board in
                    self.settext(
                        board.tostring_north(), s2: board.tostring_south())
                })
        }
    }

    func stop_watch() {
        bart.stop()
    }

    func target(station: Station) {
        self.station = station
        h1.text = station.desc
        self.settext("...", s2: "...")
        self.start_watch()
    }

    func locationManager(manager: CLLocationManager,
            didUpdateLocations locations: [CLLocation]) {

        let update = closest_station(locations[0])

        if let station = self.station {
            Log("locationManager.didUpdateLocations: \(station.code) -> \(update.code)")
            if update.code != station.code {
                self.target(update)
            }
        } else {
            Log("locationManager.didUpdateLocations: \(update.code)")
            self.target(update)
        }

    }

     func locationManager(manager: CLLocationManager,
            didFailWithError error: NSError)  {
        Log(String(error))
        Log("sad face")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
