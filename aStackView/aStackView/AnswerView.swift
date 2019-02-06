//
//  AnswerView.swift
//  aStackView
//
//  Created by Коноплев Андрей on 06/02/2019.
//  Copyright © 2019 Коноплев Андрей. All rights reserved.
//

import Foundation
import UIKit

protocol AnswerViewDelegate {
    func didSelect(answer: String, question: String)-> Void
}

class AnswerView: UIView {
    
    let label = UILabel()
    var toucheFlag: Bool = false
    
    var delegate: AnswerViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(frame: CGRect, text: String, delegate: AnswerViewDelegate) {
        super.init(frame: frame)
        self.delegate = delegate
        commonInit(text: text)
    }
    
    func commonInit(text: String)-> Void {
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        
        //label
        self.label.text = text
        self.label.textAlignment = .left
        self.label.textColor = UIColor.black
        self.label.numberOfLines = 0
        self.addSubview(label)
        
        self.label.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        self.label.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        self.label.autoPinEdge(toSuperviewEdge: .top, withInset: 10)
        self.label.autoPinEdge(toSuperviewEdge: .bottom, withInset: 10)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.toucheFlag = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if self.toucheFlag {
            self.delegate.didSelect(answer: self.label.text ?? "", question: "Вопрос")
            self.toucheFlag = false
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch = event?.allTouches!.first
        let movement = touch!.location(in: self)
        if movement.y > self.frame.height || movement.y < -self.frame.height {
            self.toucheFlag = false
        }
    }
}
