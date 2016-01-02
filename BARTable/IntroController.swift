import UIKit


class IntroController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkGrayColor()

        let stack = UIStackView()
        stack.frame = view.frame
        stack.layoutMargins = UIEdgeInsets(
            top: 100, left: 30, bottom: 120, right: 40)
        stack.layoutMarginsRelativeArrangement = true

        let txt2 = UILabel()
        txt2.text = "Welcome!"
        txt2.textAlignment = .Center
        txt2.numberOfLines = 0
        txt2.font = .preferredFontForTextStyle(UIFontTextStyleTitle1)
        txt2.textColor = .whiteColor()

        let txt3 = UILabel()
        txt3.text = "BARTable makes use of your location to streamline finding the right BART to catch. Would you like to give access to your location?"
        txt3.textAlignment = .Center
        txt3.numberOfLines = 0
        txt3.font = .preferredFontForTextStyle(UIFontTextStyleBody)
        txt3.textColor = .whiteColor()

        let button = UIButton()
        button.setTitle("Yes", forState: .Normal)
        button.titleLabel!.font = .systemFontOfSize(
            40, weight: UIFontWeightThin)
        button.setTitleColor(
            UIColor(red:0.761,  green:0.878,  blue:0.490, alpha:1),
            forState: .Normal)
        button.addTarget(
            self, action: "pressedOK:", forControlEvents: .TouchUpInside)

        stack.axis = .Vertical
        stack.distribution = .FillEqually

        stack.addArrangedSubview(txt2)
        stack.addArrangedSubview(txt3)
        stack.addArrangedSubview(button)
        view.addSubview(stack)

    }
    
    func start() {
        print("start")
        // manager.startUpdatingLocation()
        // manager.requestLocation()
    }

    func pressedOK(sender: UIButton!) {
        lm.manager.requestAlwaysAuthorization()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

