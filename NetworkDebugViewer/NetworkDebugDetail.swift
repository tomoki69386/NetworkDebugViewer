//
//  NetworkDebugDetail.swift
//  NetworkDebugViewer
//
//  Created by 築山朋紀 on 2019/12/27.
//  Copyright © 2019 tomoki_sun. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.textLabel?.textAlignment = .center
        self.textLabel?.textColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DetailTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct MenuItem {
    typealias Action = ((MenuItem) -> Void)
    var title: String?
    var detail: String?
    var action: Action
    init(title: String?, detail: String?, action: @escaping Action) {
        self.title = title
        self.detail = detail
        self.action = action
    }
}

enum MenuSectionType {
    case label
    case button
}

struct MenuSection {
    var title: String
    var type: MenuSectionType
    var items: [MenuItem]
    init(title: String, type: MenuSectionType, items: [MenuItem]) {
        self.title = title
        self.type = type
        self.items = items
    }
}

public class NetworkDebugDetailViewController: UITableViewController {
    
    private var data: NetworkDebug
    private var sections: [MenuSection] = []
    
    public init(with data: NetworkDebug) {
        self.data = data
        super.init(style: .grouped)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "[\(data.httpMethod)]\(data.url?.path ?? "")"
        tableView.tableFooterView = UIView()
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: "ButtonTableViewCell")
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: "DetailTableViewCell")
        
        let data = self.data
        
        sections.append(MenuSection(title: "overview", type: .label, items: {
            var items: [MenuItem] = []
            items.append(MenuItem(title: "URL", detail: data.url?.path ?? "", action: { _ in
                guard let url = data.url else { return }
                AlertHandler.show(title: "URL", message: "\(url)", rootViewController: self)
            }))
            items.append(MenuItem(title: "Method", detail: data.httpMethod, action: { _ in
                AlertHandler.show(title: "Method", message: data.httpMethod, rootViewController: self)
            }))
            items.append(MenuItem(title: "Status Code", detail: data.statusCode, action: { _ in
                AlertHandler.show(title: "Status Code", message: data.statusCode, rootViewController: self)
            }))
            return items
        }()))
        
        sections.append(MenuSection(title: "Request-header", type: .label, items: {
            var items: [MenuItem] = []
            items.append(MenuItem(title: "Accept-Language", detail: data.allHTTPHeaderFields("Accept-Language"), action: { _ in
                AlertHandler.show(title: "Accept-Language", message: data.allHTTPHeaderFields("Accept-Language"), rootViewController: self)
            }))
            items.append(MenuItem(title: "User-Agent", detail: data.allHTTPHeaderFields("User-Agent"), action: { _ in
                AlertHandler.show(title: "User-Agent", message: data.allHTTPHeaderFields("User-Agent"), rootViewController: self)
            }))
            items.append(MenuItem(title: "Content-Type", detail: data.allHTTPHeaderFields("Content-Type"), action: { _ in
                AlertHandler.show(title: "Content-Type", message: data.allHTTPHeaderFields("Content-Type"), rootViewController: self)
            }))
            items.append(MenuItem(title: "Authorization", detail: data.allHTTPHeaderFields("Authorization"), action: { _ in
                AlertHandler.show(title: "Authorization", message: data.allHTTPHeaderFields("Authorization"), rootViewController: self)
            }))
            return items
        }()))
        
        sections.append(MenuSection(title: "request-body", type: .button, items: {
            return [MenuItem(title: "View body", detail: nil, action: { _ in
                let viewController = NetworkDebugBodyViewController(with: data.requestBody, title: "Request Body")
                if let navigationController = self.navigationController {
                    navigationController.pushViewController(viewController, animated: true)
                } else {
                    self.present(viewController, animated: true)
                }
            })]
        }()))
        
        sections.append(MenuSection(title: "response-header", type: .label, items: {
            var items: [MenuItem] = []
            
            items.append(MenuItem(title: "Date", detail: data.allHeaderFields("Date"), action: { _ in
                AlertHandler.show(title: "Date", message: data.allHeaderFields("Date"), rootViewController: self)
            }))
            items.append(MenuItem(title: "Content-Type", detail: data.allHeaderFields("Content-Type"), action: { _ in
                AlertHandler.show(title: "Content-Type", message: data.allHeaderFields("Content-Type"), rootViewController: self)
            }))
            items.append(MenuItem(title: "Etag", detail: data.allHeaderFields("Etag"), action: { _ in
                AlertHandler.show(title: "Etag", message: data.allHeaderFields("Etag"), rootViewController: self)
            }))
            items.append(MenuItem(title: "Cache-Control", detail: data.allHeaderFields("Cache-Control"), action: { _ in
                AlertHandler.show(title: "Cache-Control", message: data.allHeaderFields("Cache-Control"), rootViewController: self)
            }))
            items.append(MenuItem(title: "x-request-id", detail: data.allHeaderFields("x-request-id"), action: { _ in
                AlertHandler.show(title: "x-request-id", message: data.allHeaderFields("x-request-id"), rootViewController: self)
            }))
            items.append(MenuItem(title: "x-runtime", detail: data.allHeaderFields("x-runtime"), action: { _ in
                AlertHandler.show(title: "x-runtime", message: data.allHeaderFields("x-runtime"), rootViewController: self)
            }))
            items.append(MenuItem(title: "Vary", detail: data.allHeaderFields("Vary"), action: { _ in
                AlertHandler.show(title: "Vary", message: data.allHeaderFields("Vary"), rootViewController: self)
            }))
            
            return items
        }()))
        
        sections.append(MenuSection(title: "response-body", type: .button, items: {
            return [MenuItem(title: "View body", detail: nil, action: { _ in
                let viewController = NetworkDebugBodyViewController(with: data.responseBody, title: "Response Body")
                if let navigationController = self.navigationController {
                    navigationController.pushViewController(viewController, animated: true)
                } else {
                    self.present(viewController, animated: true)
                }
            })]
        }()))
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sections[indexPath.section].type {
        case .label:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
            cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
            cell.detailTextLabel?.text = sections[indexPath.section].items[indexPath.row].detail
            return cell
        case .button:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell", for: indexPath) as! ButtonTableViewCell
            cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].title
            return cell
        }
    }
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = sections[indexPath.section].items[indexPath.row]
        item.action(item)
    }
    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
}

internal final class AlertHandler {
    class func show(title: String?, message: String?, rootViewController: UIViewController?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "dismiss", style: .default))
        rootViewController?.present(alertController, animated: true)
    }
}
