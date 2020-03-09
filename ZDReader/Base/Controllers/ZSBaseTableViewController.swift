//
//  ZSBaseTableViewController.swift
//  ZDReader
//
//  Created by Noah on 2018/6/7.
//  Copyright © 2018年 ZD. All rights reserved.
//

import UIKit

class ZSBaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        self.tableView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
        navigationController?.navigationBar.tintColor = UIColor.red
        navigationController?.navigationBar.barTintColor = UIColor.white
        let backItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(popAction))
        self.navigationItem.backBarButtonItem = backItem
        register()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    @objc func popAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func register(){
        let classes = registerCellClasses()
        for cls in classes {
            self.tableView.qs_registerCellClass(cls as! UITableViewCell.Type)
        }
        let nibClasses = registerCellNibs()
        for cls in nibClasses {
            self.tableView.qs_registerCellNib(cls as! UITableViewCell.Type)
        }
        
        let headerClasses = registerHeaderViewClasses()
        for cls in headerClasses {
            self.tableView.qs_registerHeaderFooterClass(cls as! UITableViewHeaderFooterView.Type)
        }
        let footerClasses = registerFooterViewClasses()
        for cls in footerClasses {
            self.tableView.qs_registerHeaderFooterClass(cls as! UITableViewHeaderFooterView.Type)
        }
    }
    
    func registerHeaderViewClasses() -> Array<AnyClass> {
        return []
    }
    
    func registerFooterViewClasses() -> Array<AnyClass> {
        return []
    }

    func registerCellClasses() -> Array<AnyClass> {
        return []
    }
    
    func registerCellNibs() -> Array<AnyClass> {
        return []
    }
    
    //MARK: - progress
    func showProgress() {
        self.view.addSubview(self.indicatorView)
        self.view.bringSubviewToFront(self.indicatorView)
    }
    
    func hideProgress() {
        self.indicatorView.stopAnimating()
        self.indicatorView.removeFromSuperview()
    }
    
    lazy var indicatorView:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.frame = CGRect(x: ScreenWidth/2 - 50 , y: ScreenHeight/2 - 50, width: 100, height: 100)
        indicator.startAnimating()
        return indicator
    }()
}
