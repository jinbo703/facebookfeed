//
//  CustomTabBarController.swift
//  facebookfeed
//
//  Created by John Nik on 4/30/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let feedController = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: feedController)
        
        navigationController.title = "News Feed"
        navigationController.tabBarItem.image = UIImage(named: "news_feed_icon")?.withRenderingMode(.alwaysOriginal)
        
        let friendsRequestController = UIViewController()
        let sencondNaviController = UINavigationController(rootViewController: friendsRequestController)
        sencondNaviController.title = "Request"
        sencondNaviController.tabBarItem.image = UIImage(named: "profile")?.withRenderingMode(.alwaysOriginal)
        
        let messengerNavigationController = UINavigationController(rootViewController: UIViewController())
        messengerNavigationController.title = "Messenger"
        messengerNavigationController.tabBarItem.image = UIImage(named: "messenger")?.withRenderingMode(.alwaysOriginal)
        
        let notificationNavController = UINavigationController(rootViewController: UIViewController())
        notificationNavController.title = "Notification"
        notificationNavController.tabBarItem.image = UIImage(named: "notification_icon")?.withRenderingMode(.alwaysOriginal)
        
        let moreNavController = UINavigationController(rootViewController: UIViewController())
        moreNavController.title = "More"
        moreNavController.tabBarItem.image = UIImage(named: "more_icon")?.withRenderingMode(.alwaysOriginal)
        
        viewControllers = [navigationController, sencondNaviController, messengerNavigationController, notificationNavController, moreNavController]
        
        tabBar.isTranslucent = false
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor.rgb(red: 220, green: 235, blue: 235).cgColor
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
        
    }
}





















