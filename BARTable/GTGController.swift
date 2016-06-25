import UIKit


class GTGController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkGrayColor()

        let stack = UIStackView()
        stack.frame = view.frame
        stack.layoutMargins = UIEdgeInsets(
            top: 140, left: 30, bottom: 160, right: 40)
        stack.layoutMarginsRelativeArrangement = true

        let txt2 = UILabel()
        txt2.text = "All Set!"
        txt2.textAlignment = .Center
        txt2.numberOfLines = 0
        txt2.font = .preferredFontForTextStyle(UIFontTextStyleTitle1)
        txt2.textColor = .whiteColor()

        let txt3 = UILabel()
        txt3.text = "Add BARTable to your Today View to quickly see departure times for the closest station."
        txt3.textAlignment = .Center
        txt3.numberOfLines = 0
        txt3.font = .preferredFontForTextStyle(UIFontTextStyleBody)
        txt3.textColor = .whiteColor()


        stack.axis = .Vertical
        stack.distribution = .FillEqually

        stack.addArrangedSubview(txt2)
        stack.addArrangedSubview(txt3)
        view.addSubview(stack)

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

