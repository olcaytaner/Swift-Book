//
//  Cubuk.swift
//  BarKirmaca
//
//  Created by Olcay Taner YILDIZ on 1/23/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Cubuk{
    var yer : CGRect
    
    init(ekranGenislik : CGFloat, ekranYukseklik: CGFloat){
        yer = CGRect(x: ekranGenislik / 2 - 0.075 * ekranGenislik, y: ekranYukseklik - 3.5 * 0.05 * ekranGenislik, width: 0.15 * ekranGenislik, height: 0.05 * ekranGenislik)
    }
    
    func buyult(){
        yer.size.width *= 1.25
    }
    
    func kucult(){
        yer.size.width *= 0.8
    }
    
    func yeniPozisyon(_ x : CGFloat){
        yer.origin.x = x
    }
}
