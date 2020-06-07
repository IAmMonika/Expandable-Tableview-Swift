//
//  ViewController.swift
//  Expandable_table_cell_demo
//
//  Created by Caliente itech on 29/04/20.
//  Copyright © 2020 Caliente iTech. All rights reserved.
//

import UIKit

class  viewcell: UITableViewCell {
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_detail: UILabel!
    
    @IBOutlet weak var img_up_down: UIImageView!
}

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
   
    
    var S1DataArr : [[String:String]] = [[ "title" : "What is iOS?",
    "details" : "iOS (formerly iPhone OS) is a mobile operating system created and developed by Apple Inc. exclusively for its hardware. It is the operating system that presently powers many of the company's mobile devices, including the iPhone, and iPod Touch; it also powered the iPad prior to the introduction of iPadOS in 2019."],
    [ "title" : "what is cupertino design ios? how to create a Cupertino (iOS-style) app using Flutter?",
      "details" : "The Material design language was created for any platform, not just Android. When you write a Material app in Flutter, it has the Material look and feel on all devices, even iOS. If you want your app to look like a standard iOS-styled app, then you would use the Cupertino library."],
    [ "title" : "List products for sale, Add product search, Add customer info",
      "details" : "In this step, you'll update the home page with three tabs using a CupertinoTabScaffold. You'll also add a data source that provides the list of items for sale, with photos and prices. In the previous step, you created a CupertinoStoreHomePage class using a CupertinoPageScaffold. Use this scaffold for pages that have no tabs. The final app has three tabs, so swap out the CupertinoPageScaffold for a CupertinoTabScaffold."]]
    
    var S2DatasArr : [[String:String]] = [[ "title" : "what is react native?",
                                            "details" : "React Native is a JavaScript framework for writing real, natively rendering mobile applications for iOS and Android. ... React Native also exposes JavaScript interfaces for platform APIs, so your React Native apps can access platform features like the phone camera, or the user's location"],
    [ "title" : "In accordance with the ancient traditions of our people, we must first build an app that does nothing except say Hello, world!. Here it is",
      "details" : "First of all, we need to import React to be able to use JSX, which will then be transformed to the native components of each platform."]
    ]

    
    

    @IBOutlet weak var tbl_expand: UITableView!
    var selectedIndexPath: NSIndexPath?
    var cell_max_height = CGFloat(0)
    var cell_defult_height = CGFloat(0)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tbl_expand.delegate = self
        tbl_expand.dataSource = self
        tbl_expand.reloadData()
        tbl_expand.tableFooterView = UIView()

    }
}

extension ViewController
{
   
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0) {
            return "General"
        }
        else {
            return "Device"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return S1DataArr.count
        }
        else {
            return S2DatasArr.count
        }
        //return DatasArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if selectedIndexPath?.row == indexPath.row && selectedIndexPath?.section == indexPath.section {
            return cell_max_height
        }else
        {
            if let cell = tableView.cellForRow(at: indexPath) as? viewcell{
                cell.img_up_down.image = UIImage(named: "down")
            }
        }
        
        var dic = [String:String]()
        if indexPath.section == 0
        {
            dic = S1DataArr[indexPath.row]
        }
        else if indexPath.section == 1
        {
            dic = S2DatasArr[indexPath.row]
        }
        
        cell_defult_height = 20 + getHeight(for: dic["title"] ?? "", font: UIFont.systemFont(ofSize: 17), width: self.view.frame.size.width - 57)
        
        if cell_defult_height > 49
        {
            return cell_defult_height
        }
        else{
            return 50
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_id", for: indexPath) as! viewcell
        
        if indexPath.section == 0
        {
            let dic = S1DataArr[indexPath.row]
            cell.lbl_title.text = dic["title"]
            cell.lbl_detail.text = dic["details"]
        }
        else if indexPath.section == 1
        {
            let dic = S2DatasArr[indexPath.row]
            cell.lbl_title.text = dic["title"]
            cell.lbl_detail.text = dic["details"]
        }
        if selectedIndexPath?.row == indexPath.row  && selectedIndexPath?.section == indexPath.section {
            cell.img_up_down.image = UIImage(named: "up")
        }else{
            cell.img_up_down.image = UIImage(named: "down")
        }

        
        cell.selectionStyle = .none
            return cell
        
    }
    func getHeight(for string: String, font: UIFont, width: CGFloat) -> CGFloat {
        let textStorage = NSTextStorage(string: string)
        let textContainter = NSTextContainer(size: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainter)
        textStorage.addLayoutManager(layoutManager)
        textStorage.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, textStorage.length))
        textContainter.lineFragmentPadding = 0.0
        layoutManager.glyphRange(for: textContainter)
        return layoutManager.usedRect(for: textContainter).size.height
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedIndexPath == indexPath as NSIndexPath
        {
            selectedIndexPath = nil
            let cell = tableView.cellForRow(at: indexPath) as! viewcell
            cell.img_up_down.image = UIImage(named: "down")
            
            tableView.beginUpdates()
            tableView.endUpdates()
        }else{
            selectedIndexPath = indexPath as NSIndexPath
            let cell = tableView.cellForRow(at: indexPath) as! viewcell
            cell.img_up_down.image = UIImage(named: "up")
            cell_max_height = cell.lbl_detail.frame.maxY  + 10
            
            tableView.beginUpdates()
            tableView.endUpdates()
            tbl_expand.scrollToRow(at: indexPath, at: .bottom, animated: true)

        }
        
        
    }
   
    
    
}

