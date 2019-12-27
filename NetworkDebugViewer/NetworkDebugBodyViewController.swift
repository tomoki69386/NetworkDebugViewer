//
//  NetworkDebugBodyViewController.swift
//  NetworkDebugViewer
//
//  Created by 築山朋紀 on 2019/12/27.
//  Copyright © 2019 tomoki_sun. All rights reserved.
//

import UIKit

final class NetworkDebugBodyViewController: UIViewController {
    private let textView = UITextView()
    init(with body: String, title: String) {
        super.init(nibName: nil, bundle: nil)
        self.textView.text = self.formatJSON(with: body)
        self.navigationItem.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func formatJSON(with body: String) -> String {
        guard let jsonData = body.data(using: .utf8) else { return body }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) else { return body }
        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else { return body }
        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else { return body }
        return prettyPrintedJson
    }
}
