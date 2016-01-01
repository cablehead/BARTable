import UIKit


class S2Controller: UIViewController {
    func makeButton(i: Int) -> UIButton {
        let button = UIButton()
        button.setTitle(stations[stations_order[i]]!.desc, forState: .Normal)
        button.titleLabel!.font = .systemFontOfSize(
            30, weight: UIFontWeightThin)
        button.titleLabel!.numberOfLines = 0
        button.titleLabel!.textAlignment = .Center
        button.setTitleColor(.whiteColor(), forState: .Normal)
        button.addTarget(
            self, action: "pressedGo:", forControlEvents: .TouchUpInside)
        button.tag = i
        return button
    }

    override func viewDidLoad() {
        Log("S2 DidLoad")
        super.viewDidLoad()
        view.backgroundColor = .darkGrayColor()

        let stack = UIStackView()
        stack.frame = view.frame
        stack.layoutMargins = UIEdgeInsets(
            top: 50, left: 30, bottom: 50, right: 40)
        stack.layoutMarginsRelativeArrangement = true

        stack.axis = .Vertical
        stack.distribution = .FillEqually

        for i in 0..<stations_order.count {
            let button = self.makeButton(i)
            stack.addArrangedSubview(button)
        }

        view.addSubview(stack)
    }

    func pressedGo(sender: UIButton!) {
        let code = stations_order[sender.tag]
        self.presentViewController(
            DController(code: code), animated: true, completion: nil)
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
    
    /*
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    */
}
