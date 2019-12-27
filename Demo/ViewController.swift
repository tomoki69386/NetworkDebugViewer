//
//  ViewController.swift
//  Demo
//
//  Created by 築山朋紀 on 2019/12/27.
//  Copyright © 2019 tomoki_sun. All rights reserved.
//

import UIKit
import NetworkDebugViewer

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func tapped(_ sender: UIButton) {
        let url = URL(string: "https://example.com/v1/posts")!
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: ["Content-type": "application/json"])
        let request = URLRequest(url: url)
        let data = """
        {"name": "tomoki_sun","twitter": "https://twitter.com/tomoki_sun"}
        """.data(using: .utf8)!

        let networkDebug = NetworkDebug(response, request: request, data: data)
        
        let viewController = NetworkDebugListViewController(with: [networkDebug])
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
    }
}
