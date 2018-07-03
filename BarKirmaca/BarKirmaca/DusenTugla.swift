//
//  DusenTugla.swift
//  BarKirmaca
//
//  Created by Olcay Taner YILDIZ on 1/23/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class DusenTugla{
    var tip : TuglaTip
    var yer : CGRect
    fileprivate var hiz : CGPoint
    
    init(tip : TuglaTip, yer : CGRect, yukseklik : CGFloat){
        self.tip = tip
        self.yer = yer
        hiz = CGPoint(x: 0, y: yukseklik / 1000.0)
    }
    
    func hareketEttir(){
        yer.origin.x += hiz.x
        yer.origin.y += hiz.y
    }
    
    func cubuklaTemas(_ cubuk : Cubuk)->Bool{
        if (yer.origin.x + yer.size.width > cubuk.yer.origin.x && yer.origin.x < cubuk.yer.origin.x + cubuk.yer.size.width
    && yer.origin.y + yer.size.height > cubuk.yer.origin.y && yer.origin.y < cubuk.yer.origin.y + cubuk.yer.size.height){
            return true
        } else {
            return false
        }
    }
}
