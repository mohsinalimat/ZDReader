//
//  LightView.swift
//  ZDReader
//
//  Created by Noah on 2017/3/9.
//  Copyright © 2017年 ZD. All rights reserved.
//

import UIKit

class LightView: UIView {
    
    var lightStarViews:[LightStarView] = []

    init(frame: CGRect,image:UIImage?) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        makeLightView(image: image)
    }
    
    func makeLightView(image:UIImage?){
        for index in 0..<5 {
            let width = self.bounds.width/5 - 10/5
            let height = self.bounds.height
            let lightStarView = LightStarView(frame: CGRect(x: CGFloat(1) + CGFloat(index)*width + CGFloat(2*index), y: 0, width: width, height: height), image: image)
            lightStarViews.append(lightStarView)
            addSubview(lightStarView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for index in 0..<5 {
            let width = self.bounds.height
            let height = self.bounds.height
            let lightStarView = lightStarViews[index]
            lightStarView.frame = CGRect(x: CGFloat(1) + CGFloat(index)*width + CGFloat(2*index), y: 0, width: width, height: height)
        }
    }
}
