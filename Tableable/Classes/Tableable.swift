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
        return sections[section].header()?.headerString ?? .None
    }
    
    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].header()?.headerHeight ?? 0
    }

    public func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sections[section].header()?.headerView
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
    func header() -> TableViewSectionHeader?
    
    /** Dequeue, configure and return the section-specific tableView cell **/
    func cell(tableView: UITableView, index: Int) -> UITableViewCell
    
    /** Called when a cell in this section is selected **/
    func cellSelected(atIndex index:Int)
    
    /** Height of cells in this section **/
    func height(index:Int) -> CGFloat
}

public struct TableViewSectionHeader {
    private let headerString: String?
    private let headerView: UIView?
    private let headerHeight: CGFloat
    
    /** Create a header, providing the title string, and an optional height. The default height is set to 44.0 points if nothing else is specified */
    public init(string: String, height: CGFloat = 44.0) {
        self.headerString = string
        self.headerHeight = height
        self.headerView = .None
    }
    
    public init(view: UIView, height: CGFloat = 44.0) {
        self.headerView = view
        self.headerHeight = height
        self.headerString = .None
    }
}

/** Default implementation for some of the methods in TableViewSectionable. **/
public extension TableViewSectionable {
    /** Returning default row height - override if needed **/
    func height(index: Int) -> CGFloat {
        return 44.0
    }
    
    func header() -> TableViewSectionHeader? {
        return nil
    }
    
    /** No-op implementation for didSelectCellAtIndexPath **/
    func cellSelected(atIndex index: Int) {}
}
