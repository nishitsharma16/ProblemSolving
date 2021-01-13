//
//  CustomTableView.swift
//  DSA
//
//  Created by Nishit on 03/12/20.
//  Copyright © 2020 Mine. All rights reserved.
//

import Foundation
import UIKit

private enum ScrollDirection {
    case none
    case top
    case down
}

private struct CellInfo {
    let type: AnyClass?
    let identifier: String
}

private class CellItem {
    let cell: UITableViewCell
    init(_ cell: UITableViewCell) {
        self.cell = cell
    }
}

private class CellIndexItem {
    let index: IndexPath
    let cell: UITableViewCell
    init(_ cell: UITableViewCell, _ index: IndexPath) {
        self.cell = cell
        self.index = index
    }
}

protocol DataSource: AnyObject {
    func numberOfSection() -> Int
    func numberOfRows(in section: Int) -> Int
    func heightForRow(at index: IndexPath) -> Int
}

class MyTableView: UIScrollView {
    
    private var cellTypeMap = [String: CellInfo]()
    private let queue = TableViewCellQueue<CellItem>()
    private var numberOfSections = 1
    private var visibleHeight: CGFloat = 0
    private var visibleRows = 0
    private var lastContentOffset: CGFloat = 0
    private var scrollDirection: ScrollDirection = .none
    weak var dataSource: DataSource?
    
    func registerCell(of classType: AnyClass?, for identifier: String) {
        let cellType = CellInfo(type: classType, identifier: identifier)
        if let _ = cellTypeMap[identifier] {
            
        }
        else {
            cellTypeMap[identifier] = cellType
        }
    }
    
    func dequeueCell(for identifier: String, indexPath: IndexPath) -> UITableViewCell {
        
        if visibleHeight <= self.bounds.size.height {
            if let cellInfo = cellTypeMap[identifier], let type = cellInfo.type {
                let cellType = type as! UITableViewCell.Type
                let cell = cellType.init()
                let cellItem = CellItem(cell)
                let cellHeight = cell.bounds.size.height
                visibleHeight += cellHeight
                visibleRows = Int(visibleHeight / cellHeight)
                queue.enqueueFromEnd(val: cellItem)
                return cellItem.cell
            }
        }
        else {
            return getCell(for: identifier)
        }
        return UITableViewCell()
    }
}

private extension MyTableView {
    func getCell(for identifier: String) -> UITableViewCell {
        if scrollDirection == .down {
            let cellItem = queue.dQueueFromFront()
            if let cellInfo = cellTypeMap[identifier], let cellType = cellInfo.type {
                let typeVal = type(of: cellItem.cell)
                let cellTypeVal = cellType as! UITableViewCell.Type
                if typeVal == cellTypeVal {
                    queue.enqueueFromEnd(val: cellItem)
                    return cellItem.cell
                }
                else {
                    let cell = cellTypeVal.init()
                    let cellItem = CellItem(cell)
                    queue.enqueueFromEnd(val: cellItem)
                    return cellItem.cell
                }
            }
        }
        else {
            let cellItem = queue.dQueueFromLast()
            if let cellInfo = cellTypeMap[identifier], let cellType = cellInfo.type {
                let typeVal = type(of: cellItem.cell)
                let cellTypeVal = cellType as! UITableViewCell.Type
                if typeVal == cellTypeVal {
                    queue.enqueueFromFront(val: cellItem)
                    return cellItem.cell
                }
                else {
                    let cell = cellTypeVal.init()
                    let cellItem = CellItem(cell)
                    queue.enqueueFromFront(val: cellItem)
                    return cellItem.cell
                }
            }
        }
        return UITableViewCell()
    }
}

extension MyTableView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if lastContentOffset > scrollView.contentOffset.y {
            scrollDirection = .down
        }
        else if lastContentOffset < scrollView.contentOffset.y {
            scrollDirection = .top
        }
        lastContentOffset = scrollView.contentOffset.y
    }
}



class MyTableView2: UITableView {
    private var map = [String: CellInfo]()
    private var cellsMap = [String: [UITableViewCell]]()
    private var scrollDirection: ScrollDirection = .none
    private let queue = TableViewCellQueue<UITableViewCell>()
    private let indexQueue = TableViewCellQueue<CellIndexItem>()
    private var cellsIndexMap = [IndexPath: CellIndexItem]()

    override func register(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        if let _ = map[identifier] {
            
        }
        else {
            map[identifier] = CellInfo(type: cellClass, identifier: identifier)
        }
    }
    
    func numberOfVisibleCells() -> Int {
        return 0
    }
    
    override func dequeueReusableCell(withIdentifier identifier: String) -> UITableViewCell? {
        if queue.size > numberOfVisibleCells() {
            if scrollDirection == .down {
                let item = queue.dQueueFromLast()
                if item.reuseIdentifier == identifier {
                    queue.enqueueFromFront(val: item)
                    return item
                }
                else {
                    if let id = item.reuseIdentifier, let val = cellsMap[id] {
                        let list = val.filter { $0 != item }
                        cellsMap[id] = list
                    }
                    if let val = cellsMap[identifier] {
                        let cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
                        cellsMap[identifier] = val + [cell]
                        queue.enqueueFromFront(val: cell)
                        return cell
                    }
                    else {
                        let cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
                        cellsMap[identifier] = [cell]
                        queue.enqueueFromFront(val: cell)
                        return cell
                    }
                }
            }
            else {
                let item = queue.dQueueFromFront()
                if item.reuseIdentifier == identifier {
                    queue.enqueueFromEnd(val: item)
                    return item
                }
                else {
                    if let id = item.reuseIdentifier, let val = cellsMap[id] {
                        let list = val.filter { $0 != item }
                        cellsMap[id] = list
                    }
                    if let val = cellsMap[identifier] {
                        let cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
                        cellsMap[identifier] = val + [cell]
                        queue.enqueueFromEnd(val: cell)
                        return cell
                    }
                    else {
                        let cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
                        cellsMap[identifier] = [cell]
                        queue.enqueueFromEnd(val: cell)
                        return cell
                    }
                }
            }
        }
        else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
            cellsMap[identifier, default: [cell]] += [cell]
            queue.enqueueFromEnd(val: cell)
            return cell
        }
    }
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        if queue.size > numberOfVisibleCells() {
            if scrollDirection == .down {
                let item = indexQueue.dQueueFromLast()
                if item.cell.reuseIdentifier == identifier {
                    indexQueue.enqueueFromFront(val: item)
                    return item.cell
                }
                else {
                    cellsIndexMap.removeValue(forKey: item.index)
                    let cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
                    let cellIndexItem = CellIndexItem(cell, indexPath)
                    cellsIndexMap[indexPath] = cellIndexItem
                    return cell
                }
            }
            else {
                let item = indexQueue.dQueueFromFront()
                if item.cell.reuseIdentifier == identifier {
                    indexQueue.enqueueFromEnd(val: item)
                    return item.cell
                }
                else {
                    cellsIndexMap.removeValue(forKey: item.index)
                    let cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
                    let cellIndexItem = CellIndexItem(cell, indexPath)
                    cellsIndexMap[indexPath] = cellIndexItem
                    return cell
                }
            }
        }
        else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
            let cellIndexItem = CellIndexItem(cell, indexPath)
            cellsIndexMap[indexPath] = cellIndexItem
            queue.enqueueFromEnd(val: cell)
            return cell
        }
    }
}
