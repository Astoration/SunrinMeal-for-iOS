//
//  MealCell.swift
//  Meals
//
//  Created by Sunrin on 2016. 1. 2..
//  Copyright © 2016년 astoration. All rights reserved.
//

import UIKit

class MealCell : UITableViewCell {
    enum MealType{
        case Lunch
        case Dinner
    }
    
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    
    class func cellHeightThatFirstWidth(width: CGFloat, forMeal meal: Meal, mealType: MealType)->CGFloat {
        let text: String
        let size = CGSize(width: width-30, height: .max)
        if mealType == .Lunch{
            text = meal.lunch.joinWithSeparator(", ")
        }else{
            text = meal.dinner.joinWithSeparator(", ")
        }
        let rect = text.boundingRectWithSize(size, options: [.UsesLineFragmentOrigin, .UsesFontLeading], attributes: [NSFontAttributeName: UIFont.systemFontOfSize(17)], context: nil)
        return ceil(rect.size.height) + 10
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .None
        self.titleLabel.font=UIFont.boldSystemFontOfSize(15)
        self.contentLabel.font = UIFont.systemFontOfSize(15)
        self.contentLabel.numberOfLines = 0
        self.addSubview(self.titleLabel)
        self.addSubview(self.contentLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.sizeToFit()
        self.titleLabel.frame.origin.x = 10
        self.titleLabel.frame.origin.y = 10
        self.titleLabel.frame.size.width = 50
        self.contentLabel.frame.origin.x = 50
        self.contentLabel.frame.origin.y = 10
        self.contentLabel.frame.size.width = self.contentView.frame.width-self.contentLabel.frame.origin.x-10
        self.contentLabel.sizeToFit()
    }
    
}