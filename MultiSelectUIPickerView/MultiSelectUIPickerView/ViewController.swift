//
//  ViewController.swift
//  MultiSelectUIPickerView
//
//  Created by Андрей Коноплев on 10/09/2018.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    var dataSource1 = ["RU", "ES", "ENG"]
    var dataSource2 = [String]()
    var dict = ["RU": ["Спартак", "ЦСКА", "Динамо"], "ES": ["Real Madrid", "Barcelona", "Valencia", "Sevilla"], "ENG": ["Arsenal", "Chelsea", "MU", "MC", "Liverpool"]]
    
    //selectedValues
    var selectedArray = [String]()
    //index selected row in component
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(row: 0)
        
        //set Up Tap Gesture
        let tapGestureRecognaizer = UITapGestureRecognizer(target: self, action: #selector(pickerTapp))
        tapGestureRecognaizer.delegate = self
        tapGestureRecognaizer.numberOfTapsRequired = 2
        self.pickerView.addGestureRecognizer(tapGestureRecognaizer)
    }
    
    @objc func pickerTapp(tapGesture: UITapGestureRecognizer) {
        
        if tapGesture.state == .ended {
            // looking for frame selection row
            let selectedItem = dataSource2[pickerView.selectedRow(inComponent: 1)]
            let rowHeight = self.pickerView.rowSize(forComponent: 1).height
            let rowWidth = self.pickerView.rowSize(forComponent: 1).width
            let selectRowFrame = CGRect(x: CGFloat(Int(self.pickerView.frame.width) / self.pickerView.numberOfComponents), y: (self.pickerView.frame.height - rowHeight) / 2, width: rowWidth, height: rowHeight)

            let userTappedOnSelectedRow = selectRowFrame.contains(tapGesture.location(in: self.pickerView))
            // if tap to selection row ....
            if userTappedOnSelectedRow {
                if selectedArray.contains(selectedItem) {
                    var index = 0
                    for item in selectedArray {
                        if item == selectedItem {
                            selectedArray.remove(at: index)
                            
                        } else {
                            index += 1
                        }
                    }
                } else {
                    selectedArray.append(selectedItem)
                }
            }
            
            //reload Data
            self.pickerView.dataSource = self
            self.pickerView.selectRow(selectedRow, inComponent: 1, animated: false)
            self.pickerView(self.pickerView, didSelectRow: selectedRow, inComponent: 1)
        }
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return dataSource1.count
        } else {
            return dataSource2.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attriburedString = NSMutableAttributedString()
        
        switch component {
        case 0:
            let attrString = NSAttributedString(string: self.dataSource1[row], attributes: [NSAttributedStringKey.foregroundColor : UIColor.black])
            attriburedString.append(attrString)
        case 1:
            let string = self.dataSource2[row]
            let attrString = NSAttributedString(string: string, attributes: [NSAttributedStringKey.foregroundColor : UIColor.black])
            attriburedString.append(attrString)
            for item in selectedArray {
                if item == string {
                    let imageAtchement = NSTextAttachment()
                    imageAtchement.image = UIImage(named: "Opened@3x")
                    imageAtchement.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
                    let imageAttachString = NSAttributedString(attachment: imageAtchement)
                    attriburedString.append(imageAttachString)
                }
            }
        default: return nil
        }
        return attriburedString
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            getData(row: row)
        case 1:
            selectedRow = row
        default:
            return
        }
    }
    
    func getData(row: Int) {
        self.dataSource2 = dict[dataSource1[row]] ?? [String]()
        self.pickerView.reloadAllComponents()
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

