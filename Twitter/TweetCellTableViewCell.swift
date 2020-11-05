//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Jonathan Zamora on 11/3/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var favorited:Bool = false
    var tweetId:Int = -1
    var retweeted:Bool = false
    
    @available(iOS 13.0, *)
    func setFavorite(_ isFavorited:Bool) {
        favorited = isFavorited
        
        let heartFill = UIImage(systemName: "heart.fill")?.withTintColor(UIColor.red, renderingMode: .alwaysOriginal)
        let heartNoFill = UIImage(systemName: "heart")
        
        if (favorited) {
            favButton.setImage(heartFill, for: UIControl.State.normal)
        }
        
        else {
            favButton.setImage(heartNoFill, for: UIControl.State.normal)
        }
    }
    
    @available(iOS 13.0, *)
    func setRetweeted(_ isRetweeted:Bool) {
        retweeted = isRetweeted
        
        let retweetFill = UIImage(systemName: "arrow.left.arrow.right")?.withTintColor(UIColor.green, renderingMode: .alwaysOriginal)
        let retweetNoFill = UIImage(systemName: "arrow.left.arrow.right")
        
        if (retweeted) {
            retweetButton.setImage(retweetFill, for: UIControl.State.normal)
            // retweetButton.isEnabled = false
        }
        
        else {
            retweetButton.setImage(retweetNoFill, for: UIControl.State.normal)
            // retweetButton.isEnabled = true
        }
    }
    
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                if #available(iOS 13.0, *) {
                    self.setFavorite(true)
                }
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })
        }
        
        else
        {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                if #available(iOS 13.0, *) {
                    self.setFavorite(false)
                }
            }, failure: { (error) in
                print("Unfavorite did not succeed: \(error)")
            })
        }
    }
    
    
    @IBAction func retweet(_ sender: Any) {
        let toBeRetweeted = !retweeted
        
        if (toBeRetweeted) {
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
                if #available(iOS 13.0, *) {
                    self.setRetweeted(true)
                }
            }, failure: { (error) in
                print("Error is retweeting: \(error)")
            })
        }
        
        else {
            TwitterAPICaller.client?.unRetweet(tweetId: tweetId, success: {
                if #available(iOS 13.0, *) {
                    self.setRetweeted(false)
                }
            }, failure: { (error) in
                print("Error is retweeting: \(error)")
            })
        }
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
