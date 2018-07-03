//
//  Tugla.swift
//  BarKirmaca
//
//  Created by Olcay Taner YILDIZ on 1/23/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Tugla{
    var tip : TuglaTip
    var kirildi : Bool
    var yer : CGRect
    fileprivate var vurmaSayisi : Int
    
    init(tip : TuglaTip, yer : CGRect){
        self.tip = tip
        self.yer = yer
        kirildi = false
        vurmaSayisi = 0
    }
    
    func vuruldu(){
        vurmaSayisi += 1
        if (tip == .zor){
            if (vurmaSayisi == 2){
                kirildi = true
            }
        } else {
            kirildi = true
        }
    }
    
}
