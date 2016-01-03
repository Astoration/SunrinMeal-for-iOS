//
//  ViewController.swift
//  Meals
//
//  Created by Sunrin on 2016. 1. 2..
//  Copyright © 2016년 astoration. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let tableView = UITableView()
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()
//        Alamofire.request( .GET, "http://schoool.kr/school/search",
//            parameters: ["query": "선린"]).responseJSON {
//                response in print(response)
//        }
        
        self.view.addSubview(self.tableView)
        self.tableView.frame=self.view.bounds
        self.tableView.registerClass( MealCell.self , forCellReuseIdentifier: "cell")
        self.tableView.dataSource=self
        self.tableView.delegate=self
        loadMeals()

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func loadMeals() {
        let URLString = "http://schoool.kr/school/B100000658/meals"
        let parameter = [
            "year" : 2015,
            "month" : 11,
        ]
        Alamofire.request(.GET, URLString, parameters: parameter).responseJSON { response in
            guard let dicts = response.result.value?["data"] as? [[String: AnyObject]] else {
                return
            }
            self.meals = dicts.flatMap{
                guard let date = $0["date"] as? String else {return nil}
                let lunch = $0["lunch"] as? [String] ?? []
                let dinner = $0["dinner"] as? [String] ?? []
                return Meal(date: date, lunch: lunch, dinner: dinner)
            }
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.meals.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let meal = self.meals[section]
        return Int(!meal.lunch.isEmpty) + Int(!meal.dinner.isEmpty)
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! MealCell
        let meal = self.meals[indexPath.section]
        cell.textLabel?.numberOfLines=0
        if indexPath.row == 0 {
            cell.titleLabel.text = "점심"
            cell.contentLabel.text = meal.lunch.joinWithSeparator(", ")
        } else {
            cell.titleLabel.text = "저녁"
            cell.contentLabel.text = meal.dinner.joinWithSeparator(", ")
        }
        return cell
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let meal = self.meals[section]
        return meal.date
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let meal = self.meals[indexPath.section]
        let mealType: MealCell.MealType
        if indexPath.row == 0 {
            mealType = .Lunch
        }else {
            mealType = .Dinner
        }
        return MealCell.cellHeightThatFirstWidth(tableView.frame.width, forMeal: meal, mealType: mealType)
    }
}
