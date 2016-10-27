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
    var selectedIndexPath: IndexPath?
    
    public init(sections: [TableViewSectionable]) {
        self.sections = sections
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows()
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].header()?.headerString ?? .none
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].header()?.headerHeight ?? 0
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sections[section].header()?.headerView
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return sections[(indexPath as NSIndexPath).section].cell(tableView, index: (indexPath as NSIndexPath).row)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return sections[(indexPath as NSIndexPath).section].height((indexPath as NSIndexPath).row)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedIndexPath = indexPath
        sections[(indexPath as NSIndexPath).section].cellSelected(atIndex: (indexPath as NSIndexPath).row)
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
}

/** Configures a single tableview section **/
public protocol TableViewSectionable {
    
    /** Number of rows for this section **/
    func rows() -> Int
    
    /** Optional section header title **/
    func header() -> TableViewSectionHeader?
    
    /** Dequeue, configure and return the section-specific tableView cell **/
    func cell(_ tableView: UITableView, index: Int) -> UITableViewCell
    
    /** Called when a cell in this section is selected **/
    func cellSelected(atIndex index:Int)
    
    /** Height of cells in this section **/
    func height(_ index:Int) -> CGFloat
}

public struct TableViewSectionHeader {
    fileprivate let headerString: String?
    fileprivate let headerView: UIView?
    fileprivate let headerHeight: CGFloat
    
    /** Create a header, providing the title string, and an optional height. The default height is set to 44.0 points if nothing else is specified */
    public init(string: String, height: CGFloat = 44.0) {
        self.headerString = string
        self.headerHeight = height
        self.headerView = .none
    }
    
    public init(view: UIView, height: CGFloat = 44.0) {
        self.headerView = view
        self.headerHeight = height
        self.headerString = .none
    }
}

/** Default implementation for some of the methods in TableViewSectionable. **/
public extension TableViewSectionable {
    /** Returning default row height - override if needed **/
    func height(_ index: Int) -> CGFloat {
        return 44.0
    }
    
    func header() -> TableViewSectionHeader? {
        return nil
    }
    
    /** No-op implementation for didSelectCellAtIndexPath **/
    func cellSelected(atIndex index: Int) {}
}
