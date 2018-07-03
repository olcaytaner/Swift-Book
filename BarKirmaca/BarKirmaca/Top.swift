//
//  Top.swift
//  BarKirmaca
//
//  Created by Olcay Taner YILDIZ on 1/23/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Top{
    var merkez : CGPoint
    fileprivate var hiz : CGPoint
    var yariCap : CGFloat
    
    init(cubukX : CGFloat, cubukY : CGFloat, ekranGenislik: CGFloat){
        hiz = CGPoint(x: -ekranGenislik / 600.0, y: -ekranGenislik / 600.0)
        yariCap = ekranGenislik / 50
        merkez = CGPoint(x: cubukX + yariCap, y: cubukY - yariCap)
    }
    
    func hareketEttir(){
        merkez.x += hiz.x
        merkez.y += hiz.y
    }
    
    func sinirlarlaTemas(_ ekranGenislik : CGFloat, ekranYukseklik : CGFloat)->Bool{
        if (merkez.x < 0 || merkez.x > ekranGenislik){
            hiz.x *= -1
        }
        if (merkez.y < 0){
            hiz.y *= -1
        }
        if (merkez.y > ekranYukseklik){
            return true
        } else {
            return false
        }
    }
    
    func tuglaylaTemas(_ tugla : Tugla)->Bool{
        if (merkez.x + yariCap > tugla.yer.origin.x && merkez.x - yariCap < tugla.yer.origin.x + tugla.yer.size.width
    && merkez.y + yariCap > tugla.yer.origin.y && merkez.y - yariCap < tugla.yer.origin.y + tugla.yer.size.height){
            hiz.y *= -1
            return true
        } else {
            return false
        }
    }
    
    func cubuklaTemas(_ cubuk : Cubuk)->Bool{
        if (merkez.x + yariCap > cubuk.yer.origin.x && merkez.x - yariCap < cubuk.yer.origin.x + cubuk.yer.size.width
    && merkez.y + yariCap > cubuk.yer.origin.y && merkez.y - yariCap < cubuk.yer.origin.y + cubuk.yer.size.height){
            hiz.y *= -1
            return true
        } else {
            return false
        }
    }
    
    func hizlandir(){
        hiz.x *= 1.25
        hiz.y *= 1.25
    }
    
    func yavaslat(){
        hiz.x *= 0.8
        hiz.y *= 0.8
    }

}
