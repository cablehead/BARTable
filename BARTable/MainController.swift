import UIKit




class MainController: UIViewController {
    let options = [
        1: [
            "station": "24th",
            "desc": "24th St Mission, North Bound",
            "dir": "North", ],
        2: [
            "station": "mont",
            "desc": "Montgomery St, South Bound",
            "dir": "South", ],
        3: [
            "station": "powl",
            "desc": "Powell St, South Bound",
            "dir": "South", ], ]

    func makeButton(i: Int) -> UIButton {
        let button = UIButton()
        button.setTitle(self.options[i]!["desc"], forState: .Normal)
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
        super.viewDidLoad()
        
        view.backgroundColor = .darkGrayColor()

        let stack = UIStackView()
        stack.frame = view.frame
        stack.layoutMargins = UIEdgeInsets(
            top: 50, left: 30, bottom: 50, right: 40)
        stack.layoutMarginsRelativeArrangement = true

        stack.axis = .Vertical
        stack.distribution = .FillEqually

        let btn1 = self.makeButton(1)
        let btn2 = self.makeButton(2)
        let btn3 = self.makeButton(3)

        stack.addArrangedSubview(btn1)
        stack.addArrangedSubview(btn2)
        stack.addArrangedSubview(btn3)

        view.addSubview(stack)
    }

    func pressedGo(sender: UIButton!) {
        /*
        if let option = self.options[sender.tag] {
            let watch = WatchController(
                desc: option["desc"]!,
                station: option["station"]!,
                dir: option["dir"]!)
            self.presentViewController(watch, animated: true, completion: nil)
        }
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

