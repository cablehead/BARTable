import UIKit


class DController: UIViewController {
    var station: Station

    init(code: String) {
        self.station = stations[code]!
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGrayColor()

        let stack = UIStackView()
        stack.frame = view.frame
        stack.layoutMargins = UIEdgeInsets(
            top: 0, left: 30, bottom: 30, right: 40)
        stack.layoutMarginsRelativeArrangement = true

        stack.axis = .Vertical
        stack.distribution = .FillEqually

        let txt2 = UILabel()
        txt2.text = self.station.desc
        txt2.textAlignment = .Center
        txt2.numberOfLines = 0
        txt2.font = .systemFontOfSize(25, weight: UIFontWeightThin)
        txt2.textColor = .whiteColor()

        let btn1 = UIButton()
        btn1.setTitle("North Bound", forState: .Normal)
        btn1.titleLabel!.font = .systemFontOfSize(
            30, weight: UIFontWeightThin)
        btn1.titleLabel!.numberOfLines = 0
        btn1.titleLabel!.textAlignment = .Center
        btn1.setTitleColor(.whiteColor(), forState: .Normal)
        btn1.addTarget(
            self, action: "pressedGo:", forControlEvents: .TouchUpInside)
        btn1.tag = 0

        let btn2 = UIButton()
        btn2.setTitle("South Bound", forState: .Normal)
        btn2.titleLabel!.font = .systemFontOfSize(
            30, weight: UIFontWeightThin)
        btn2.titleLabel!.numberOfLines = 0
        btn2.titleLabel!.textAlignment = .Center
        btn2.setTitleColor(.whiteColor(), forState: .Normal)
        btn2.addTarget(
            self, action: "pressedGo:", forControlEvents: .TouchUpInside)
        btn2.tag = 1

        let btn3 = UIButton()
        btn3.setTitle("back", forState: .Normal)
        btn3.titleLabel!.font = .systemFontOfSize(
            30, weight: UIFontWeightThin)
        btn3.titleLabel!.numberOfLines = 0
        btn3.titleLabel!.textAlignment = .Center
        btn3.setTitleColor(
            UIColor(red:0.663, green:0.686, blue:0.769, alpha:1), 
            forState: .Normal)
        btn3.addTarget(
            self, action: "pressedBack:", forControlEvents: .TouchUpInside)
        
        stack.addArrangedSubview(txt2)
        stack.addArrangedSubview(btn1)
        stack.addArrangedSubview(btn2)
        stack.addArrangedSubview(btn3)

        view.addSubview(stack)
    }

    func pressedGo(sender: UIButton!) {
        let direction = ["North", "South"][sender.tag]
        self.presentViewController(
            WatchController(code: self.station.code, direction: direction),
                animated: true, completion: nil)
    }

    func pressedBack(sender: UIButton!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations()
            -> UIInterfaceOrientationMask {
        let orientation: UIInterfaceOrientationMask = [
            UIInterfaceOrientationMask.Portrait,
            UIInterfaceOrientationMask.PortraitUpsideDown]
        return orientation
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
