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
        
        let url = URL(string: "https://api.github.com/users/tomoki69386")!
        let request = URLRequest(url: url)
        ApiClient.send(request) { result in
            switch result {
            case .success:
                break
            case let .failure(error):
                print(error)
            }
        }
    }
    
    @IBAction private func tapped(_ sender: UIButton) {
        let viewController = NetworkDebugListViewController(with: DataStore.shared.networkDebugs)
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
    }
}

struct ApiClient {
    static func send(_ request: URLRequest, completion: @escaping(Result<Void, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            switch (data, response as? HTTPURLResponse, error) {
            case let (.some(data), .some(response), _):
                let network = NetworkDebug(response, request: request, data: data)
                DataStore.shared.networkDebugs.append(network)
                completion(.success(()))
            case let (_, _, .some(error)):
                completion(.failure(error))
            default:
                fatalError()
            }
        }
        task.resume()
    }
}

class DataStore {
    static let shared = DataStore()
    private init() { }
    var networkDebugs: [NetworkDebug] = []
}
