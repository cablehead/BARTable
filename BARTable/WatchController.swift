import UIKit


class WatchController: UIViewController {
    var station: Station
    var direction: String
    
    let txt1 = UILabel()

    func settxt1(board: Board) {
		let n = board.direction(self.direction)

        if n.count == 0 {
			self.txt1.attributedText = NSAttributedString(
				string: "...",
				attributes: [
					NSFontAttributeName:
						UIFont.systemFontOfSize(40, weight: UIFontWeightThin),
					NSForegroundColorAttributeName:
						UIColor.whiteColor(), ])
			return
		}

        var m: Int
        if n.count - 1 > 3 {
            m = 3
        } else {
            m = n.count - 1
        }
                
        let s = NSMutableAttributedString(
            string: n[0]+"\n",
            attributes: [
                NSFontAttributeName:
                    UIFont.systemFontOfSize(80, weight: UIFontWeightThin),
                NSForegroundColorAttributeName:
                    UIColor(red:0.612, green:0.800, blue:0.890, alpha:1), ])
        
        if n.count > 1 {
            let remain = NSAttributedString(
                string: n[1...m].joinWithSeparator(", "),
                attributes: [
                    NSFontAttributeName:
                        UIFont.systemFontOfSize(40, weight: UIFontWeightThin),
                    NSForegroundColorAttributeName:
                        UIColor.whiteColor(), ])
            
            s.appendAttributedString(remain)
        }

        self.txt1.attributedText = s
    }

    init(code: String, direction: String) {
        Log("INIT!")

        self.station = stations[code]!
        self.direction = direction
        super.init(nibName: nil, bundle: nil)

    }
    
    deinit {
        Log("DEINIT!")
    }

    override func viewWillAppear(animated: Bool) {
        Log("willAppear")
        bart.watch(
            self.station.code,
            response: self.settxt1)
    }

    override func viewWillDisappear(animated: Bool) {
        Log("willDisappear")
        bart.stop()
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
        stack.distribution = .FillProportionally
        
        txt1.text = " "
        txt1.textAlignment = .Center
        txt1.numberOfLines = 0
        self.settxt1(Board())

        let button = UIButton()
        button.setTitle("Done", forState: .Normal)
        button.titleLabel!.font = .systemFontOfSize(
            40, weight: UIFontWeightThin)
        button.setTitleColor(
            UIColor(red:0.761,  green:0.878,  blue:0.490, alpha:1),
            forState: .Normal)
        button.addTarget(
            self, action: "pressedDone:", forControlEvents: .TouchUpInside)

        let txt2 = UILabel()
        txt2.text = self.station.desc + ", " + self.direction + " Bound"
        txt2.textAlignment = .Center
        txt2.numberOfLines = 0
        txt2.font = .systemFontOfSize(25, weight: UIFontWeightThin)
        txt2.textColor = .whiteColor()
        
        stack.addArrangedSubview(txt1)
        stack.addArrangedSubview(button)
        stack.addArrangedSubview(txt2)

        view.addSubview(stack)
    }
    
    func pressedDone(sender: UIButton!) {
        let vi = self.presentingViewController!
        self.dismissViewControllerAnimated(false, completion: {
            vi.dismissViewControllerAnimated(false, completion: nil)
        })
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
