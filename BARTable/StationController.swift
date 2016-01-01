import UIKit


class StationController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(
            UITableViewCell.self,
            forCellReuseIdentifier: "StationCell")

        view.backgroundColor = .darkGrayColor()
    }

    // MARK: - Table view data source

    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    */

    override func tableView(tableView: UITableView,
            numberOfRowsInSection section: Int) -> Int {
        return stations_order.count
    }

    override func tableView(tableView: UITableView,
            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "StationCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = stations[stations_order[indexPath.row]]!.desc
        // cell.backgroundView!.backgroundColor = .darkGrayColor()
        return cell
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
