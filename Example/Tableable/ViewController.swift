//
//  ViewController.swift
//  Tableable
//
//  Created by Runar Svendsen on 08/25/2016.
//  Copyright (c) 2016 Runar Svendsen. All rights reserved.
//

import UIKit
import Foundation
import Tableable
import SDWebImage

class ViewController: UITableViewController {

    var dataSource: TableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let imageURLS = [NSURL(string: "https://peoplemanaus.files.wordpress.com/2009/12/coupe.jpg")!,
                         NSURL(string: "https://peoplemanaus.files.wordpress.com/2009/12/coupe.jpg")!]
        let strings = ["The", "quick", "brown", "fox", "jumped", "over", "the", "lazy", "dog"]
        self.dataSource = TableViewDataSource(sections: [ImageDataSource(imageURLs: imageURLS),
            StringDataSource(strings: strings)])
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.tableFooterView = UIView()
    }
}

struct ImageDataSource: TableViewSectionable {
    let imageURLs: [NSURL]
    
    func rows() -> Int {
        return imageURLs.count
    }
    
    func height(index: Int) -> CGFloat {
        return index > 0 ? CGFloat(200.0) : CGFloat(100.0)
    }
    
    func header() -> TableViewSectionHeader? {
        return TableViewSectionHeader(string: "Images")
    }
    
    func cell(tableView: UITableView, index: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("imageCell") as! ImageCell
        let imageURL = imageURLs[index]
        cell.cellImage?.sd_setImageWithURL(imageURL)
        return cell
    }
    
    func cellSelected(atIndex index: Int) {
        print("Image selected")
    }
}

struct StringDataSource: TableViewSectionable {
    let strings: [String]
    
    func rows() -> Int {
        return strings.count
    }

    func header() -> TableViewSectionHeader? {
        return TableViewSectionHeader(string: "Strings")
    }
    
    func cell(tableView: UITableView, index: Int) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("subtitleCell")!
        cell.textLabel?.text = strings[index]
        return cell
    }
    
    func cellSelected(atIndex index: Int) {
        print("String selected")
    }
}

class ImageCell: UITableViewCell {
    @IBOutlet var cellImage: UIImageView?
}


