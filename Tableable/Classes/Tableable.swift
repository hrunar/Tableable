//
//  Tableable.swift
//  Tableable
//
//  Created by Runar Svendsen on 25/08/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import Foundation

public class TableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    let sections: [TableViewSectionable]
    var selectedIndexPath: NSIndexPath?
    
    public init(sections: [TableViewSectionable]) {
        self.sections = sections
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows()
    }
    
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].header()
    }
    
    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].headerHeight()
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return sections[indexPath.section].cell(tableView, index: indexPath.row)
    }
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return sections[indexPath.section].height(indexPath.row)
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.selectedIndexPath = indexPath
        sections[indexPath.section].cellSelected(atIndex: indexPath.row)
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
}

/** Configures a single tableview section **/
public protocol TableViewSectionable {
    
    /** Number of rows for this section **/
    func rows() -> Int
    
    /** Optional section header title **/
    func header() -> String?
    
    /** Dequeue, configure and return the section-specific tableView cell **/
    func cell(tableView: UITableView, index: Int) -> UITableViewCell
    
    /** Returns the needed row height **/
    func height(index: Int) -> CGFloat
    
    /** Defines the height needed for the section title.
     Default implementation is provided, override if you need more than the standard section height **/
    func headerHeight() -> CGFloat
    
    /** Called when a cell in this section is selected **/
    func cellSelected(atIndex index:Int)
}

/** Default implementation for some of the methods in TableViewSectionable. **/
extension TableViewSectionable {
    /** Returning default row height - override if needed **/
    func height(index: Int) -> CGFloat {
        return 44.0
    }
    
    /** If sectionHeader is set, return standard height, otherwise 0 **/
    func headerHeight() -> CGFloat {
        return (header() != nil) ? 44.0 : 0
    }
    
    /** No-op implementation for didSelectCellAtIndexPath **/
    func cellSelected(atIndex index: Int) {}
}