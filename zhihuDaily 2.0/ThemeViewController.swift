//
//  ThemeViewController.swift
//  zhihuDaily 2.0
//
//  Created by Nirvana on 10/15/15.
//  Copyright © 2015 NSNirvana. All rights reserved.
//

import UIKit

class ThemeViewController: UIViewController {
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建leftBarButtonItem
        let leftButton = UIBarButtonItem(image: UIImage(named: "leftArrow"), style: .Plain, target: self.revealViewController(), action: "revealToggle:")
        leftButton.tintColor = UIColor.whiteColor()
        self.navigationItem.setLeftBarButtonItem(leftButton, animated: false)
        
        //为当前view添加手势识别
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //初始化tableView
        tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        
        //生成并配置HeaderImageView
        let navImageView = UIImageView(frame: CGRectMake(-100, 0, 500, 64))
        navImageView.contentMode = UIViewContentMode.ScaleAspectFill
        navImageView.clipsToBounds = true
        let image = UIImage(named: "ThemeImage")!
        navImageView.image = image
        
        //将其添加到ParallaxView
        let themeSubview = ParallaxHeaderView.parallaxThemeHeaderViewWithSubView(navImageView, forSize: CGSizeMake(self.view.frame.width, 64), andImage: image) as! ParallaxHeaderView
        themeSubview.delegate = self
        
        //将ParallaxView设置为tableHeaderView，主View添加tableView
        self.tableView.tableHeaderView = themeSubview
        self.view.addSubview(tableView)
        
        //设置NavigationBar为透明
        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor.clearColor())
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //tableView基础设置
        self.tableView.delegate = self
        self.tableView.separatorStyle = .None
    }


    //设置StatusBar颜色
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ThemeViewController: UITableViewDelegate, ParallaxHeaderViewDelegate {
    
    //实现Parallax效果
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let header = self.tableView.tableHeaderView as! ParallaxHeaderView
        header.layoutThemeHeaderViewForScrollViewOffset(scrollView.contentOffset)
    }
    
    //设置滑动极限
    func lockDirection() {
        self.tableView.contentOffset.y = -95
    }
}