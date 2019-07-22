//
//  ImplementationListViewController.swift
//  MVVMAnimation
//
//  Created by Florian LUDOT on 7/11/19.
//  Copyright © 2019 Florian LUDOT. All rights reserved.
//

import UIKit

class ImplementationListViewController: UITableViewController {

    let items = [
        "Static views",
        "Reusable views + Caching",
        "Reusable views + Diffing",
    ]

    init() {
        super.init(style: .grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Implementations"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension ImplementationListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
}

extension ImplementationListViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: true)
        let title = items[indexPath.row]
        let pushedViewController: UIViewController
        switch indexPath.row {
        case 0:
            let interactor = StaticInteractor()
            pushedViewController = ImplementationStaticViewsViewController(title: title,
                                                                           interactor: interactor)
        case 1:
            let interactor = CachingInteractor()
            pushedViewController = ImplementationCachingCollectionViewController(title: title,
                                                                           interactor: interactor)
        case 2:
            let interactor = DiffingInteractor()
            pushedViewController = ImplementationDiffingCollectionViewController(title: title,
                                                                                 interactor: interactor)
        default:
            preconditionFailure("Out of bounds")
        }
        navigationController?.pushViewController(pushedViewController, animated: true)
    }
}

