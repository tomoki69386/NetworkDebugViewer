//
//  NetworkDebugList.swift
//  NetworkDebugViewer
//
//  Created by 築山朋紀 on 2019/12/27.
//  Copyright © 2019 tomoki_sun. All rights reserved.
//

import UIKit

public final class NetworkDebugListViewController: UITableViewController {
    private var networkDebugs: [NetworkDebug] = []
    public init(with data: [NetworkDebug]) {
        self.networkDebugs = data
        super.init(style: .grouped)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networkDebugs.count
    }
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let data = networkDebugs[indexPath.row]
        let path = data.url?.path ?? ""
        cell.textLabel?.text = "[\(data.httpMethod)]\(path)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = networkDebugs[indexPath.row]
        let viewController = NetworkDebugDetailViewController(with: data)
        if let navigationController = self.navigationController {
            navigationController.pushViewController(viewController, animated: true)
        } else {
            present(viewController, animated: true)
        }
    }
}
