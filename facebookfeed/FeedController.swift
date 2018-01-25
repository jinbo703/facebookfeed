//
//  ViewController.swift
//  facebookfeed
//
//  Created by John Nik on 27/04/2017.
//  Copyright © 2017 johnik703. All rights reserved.
//

import UIKit

let cellId = "cellId"

class Post {
    var name: String?
    var statusText: String?
    var profileImageName: String?
    var statusImageName: String?
    var numLikes: Int?
    var numComments: Int?
}


class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        
        
        let postMark = Post()
        postMark.name = "Mark"
        postMark.statusText = "here I 'm here"
        postMark.profileImageName = "images (3)"
        postMark.statusImageName = "images (13)"
        postMark.numLikes = 123
        postMark.numComments = 34
        
        let postSteve = Post()
        postSteve.name = "stebe"
        postSteve.statusText = "steve jobs here jfdsdjflksdjflksjflksjdfljsdlkfjsdlkfjsdlkjflskdjflksjflksjfklsjdflkj"
        postSteve.profileImageName = "images (13)"
        postSteve.statusImageName = "images (11)"
        postSteve.numLikes = 223
        postSteve.numComments = 65
        
        let postJane = Post()
        postJane.name = "jane"
        postJane.statusText = "steve jane here jfdsdjflksdjffkjsdlkfjsdklfjljflkdsgjklfjdgfklfdjgklfdjgklfdjgfdkljgfdkljgklfdjgkfdjgfdkljgkfdljgkfdlgjkfdlgjdfklgjfdklgjfdklgjfdkljgfdkljgkldfjgfdklglkfdgfdkljgfdklglksjflksjdfljsdlkfjsdlkfjsdlkjflskdjflksjflksjfklsjdflkj"
        postJane.profileImageName = "images (11)"
        postJane.statusImageName = "images (3)"
        postJane.numLikes = 23
        postJane.numComments = 6
        
        posts.append(postMark)
        posts.append(postSteve)
        posts.append(postJane)
        
        navigationItem.title = "Facebook Feed"
        
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
    
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        
        feedCell.post = posts[indexPath.item]
        feedCell.feedController = self
        
//        if let name = posts[indexPath.item].name {
//            feedCell.nameLabel.text = name
//        }
        
        return feedCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if let statusText = posts[indexPath.item].statusText {
            
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
            
            let knowHeight: CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
            
            return CGSize(width: view.frame.width, height: rect.height + knowHeight + 16)
            
        }
        
        
        return CGSize(width: collectionView.frame.width, height: 500)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView?.collectionViewLayout.invalidateLayout()
        
    }
    
    let blackBackgroundView = UIView()
    let zoomImageView = UIImageView()
    let navBarCoverView = UIView()
    let tabBarCoverView = UIView()
    
    var statusImageView: UIImageView?
    
    func animateImageView(statusImageView: UIImageView) {
        self.statusImageView = statusImageView
        
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
            
            statusImageView.alpha = 0
            
            blackBackgroundView.frame = self.view.frame
            blackBackgroundView.backgroundColor = UIColor.black
            blackBackgroundView.alpha = 0
            view.addSubview(blackBackgroundView)
            
            navBarCoverView.frame = CGRect(x: 0, y: 0, width: 1000, height: 20 + 44)
            navBarCoverView.backgroundColor = UIColor.black
            navBarCoverView.alpha = 0
            
            
            
            if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.addSubview(navBarCoverView)
                tabBarCoverView.frame = CGRect(x: 0, y: keyWindow.frame.height - 49, width: 1000, height: 49)
                tabBarCoverView.backgroundColor = UIColor.black
                tabBarCoverView.alpha = 0
                keyWindow.addSubview(tabBarCoverView)
            }
            
            
            zoomImageView.backgroundColor = UIColor.red
            zoomImageView.frame = startingFrame
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.image = statusImageView.image
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.clipsToBounds = true
            
            view.addSubview(zoomImageView)
            
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
            
            UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: { 
                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
                
                let y = self.view.frame.height / 2 - height / 2
                
                self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
                
                self.blackBackgroundView.alpha = 1
                self.navBarCoverView.alpha = 1
                self.tabBarCoverView.alpha = 1
            }, completion: nil)
            
//            UIView.animate(withDuration: 0.75, animations: { 
//                
//                let height = (self.view.frame.width / startingFrame.width) * startingFrame.height
//                
//                let y = self.view.frame.height / 2 - height / 2
//                
//                self.zoomImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: height)
//                
//                self.blackBackgroundView.alpha = 1
//                self.navBarCoverView.alpha = 1
//                self.tabBarCoverView.alpha = 1
//            })

        }
    }
    
    func zoomOut() {
        
        if let startingFrame = statusImageView?.superview?.convert(statusImageView!.frame, to: nil) {
            
            UIView.animate(withDuration: 0.75, animations: { 
                self.zoomImageView.frame = startingFrame
                self.blackBackgroundView.alpha = 0
                self.navBarCoverView.alpha = 0
                self.tabBarCoverView.alpha = 0
            }, completion: { (didComplete) in
                
                self.zoomImageView.removeFromSuperview()
                self.blackBackgroundView.removeFromSuperview()
                self.navBarCoverView.removeFromSuperview()
                self.tabBarCoverView.removeFromSuperview()
                self.statusImageView?.alpha = 1
                
            })
            
        }
        
    }

}

class FeedCell: UICollectionViewCell {
    
    var feedController: FeedController?
    
    func animate() {
        
        feedController?.animateImageView(statusImageView: statusImageView)
        
    }

    
    var post: Post? {
        
        didSet {
            
            if let name = post?.name {
                
                let attributedText = NSMutableAttributedString(string: name, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
                
                attributedText.append(NSAttributedString(string: "\nDecember 10 San Fransisco ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: UIColor.rgb(red: 155, green: 161, blue: 171)]))
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                
                attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
                
                
                
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "attachment")
                attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
                attributedText.append(NSAttributedString(attachment: attachment))
                
                nameLabel.attributedText = attributedText

                
            }
            
            if let statusText = post?.statusText {
                statusTextView.text = statusText
            }
            
            if let profileImageName = post?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
            }
            
            if let statusImageName = post?.statusImageName {
                statusImageView.image = UIImage(named: statusImageName)
            }
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 2
        
        
        
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "images (3)")
        return imageView
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.text = "MeanWhile, beast turoun to the dark side."
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        return textView
    }()
    
    lazy var statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "images (11)")
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    let likesCommentLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Likes 10.7k Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155, green: 161, blue: 171)
        return label
        
    }()
    
    let likeButton = FeedCell.buttonForTitle(title: "Like", imageName: "like1")
    let commentButton = FeedCell.buttonForTitle(title: "Comment", imageName: "comment")
    let shareButton = FeedCell.buttonForTitle(title: "Share", imageName: "share")
    
    
    static func buttonForTitle(title: String, imageName: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 263), for: .normal)
        button.setImage(UIImage(named: imageName), for: .normal)
        //        button.imageEdgeInsets = UIEdgeInsetsMake(15, 180, 15, 180)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }

    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 226, green: 228, blue: 232)
        return view
    }()
    
    func setupViews() {
        backgroundColor = UIColor.white
        
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentLabel)
        addSubview(dividerLineView)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        
        statusImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: statusTextView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        addConstraintsWithFormat(format: "H:|-12-[v0]|", views: likesCommentLabel)
        addConstraintsWithFormat(format: "H:|-12-[v0]-12-|", views: dividerLineView)
        addConstraintsWithFormat(format: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton,commentButton, shareButton)
        
        
        
        
        addConstraintsWithFormat(format: "V:|-12-[v0]", views: nameLabel)
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|", views: profileImageView, statusTextView, statusImageView, likesCommentLabel, dividerLineView, likeButton)
        
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: commentButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: shareButton)
        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0(44)]-8-[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImageView, "v1": nameLabel]))
        
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0(44)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": profileImageView]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        
    }
    

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
    
}

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
}






















