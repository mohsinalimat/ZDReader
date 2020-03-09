//
//  ZSSourcesViewController.swift
//  zhuishushenqi
//
//  Created by caony on 2019/11/11.
//  Copyright © 2019 QS. All rights reserved.
//

import UIKit

class ZSSourcesViewController: ZSBaseTableViewController {
    
    var sources:[ZSAikanParserModel] { return ZSSourceManager.share.sources }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    private func setupNavBar() {
        let addItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction))
        self.navigationItem.rightBarButtonItem = addItem
    }
    
    @objc
    private func addAction() {
        let addVC = ZSAddSourceViewController()
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.qs_dequeueReusableCell(ZSSourceCell.self)
        cell?.delegate = self
        let source = sources[indexPath.row]
        cell?.configure(source: source)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let source = sources[indexPath.row]
        let addVC = ZSAddSourceViewController()
        addVC.source = source
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    override func registerCellClasses() -> Array<AnyClass> {
        return [ZSSourceCell.self]
    }
}

extension ZSSourcesViewController:ZSSourceCellDelegate {
    func cellDidClickCheck(cell:ZSSourceCell, checked:Bool) {
        if checked {
            ZSSourceManager.share.select(source: cell.source!)
        } else {
            ZSSourceManager.share.unselect(source: cell.source!)
        }
    }
    
    func cellDidClickDelete(cell:ZSSourceCell) {
        alert(with: "提醒", message: "确认删除吗，删除后不可恢复？", okTitle: "确认", cancelTitle: "取消", okAction: { [weak self] (action) in
            ZSSourceManager.share.delete(source: cell.source!)
            self?.tableView.reloadData()
        }, cancelAction: nil)
    }
}

