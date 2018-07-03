//
//  Bulmaca.swift
//  Piramit
//
//  Created by Olcay Taner YILDIZ on 1/9/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Bulmaca {
    fileprivate var sayilar : [[Int]] = []
    fileprivate var oynama : [Int] = []
    var buyukluk : Int = 0
    
    init(bulmacaBilgisi:String){
        var k: Int
        buyukluk = Int(sqrt(Double(2 * bulmacaBilgisi.utf16.count)))
        k = 0
        for i in 0..<buyukluk{
            oynama.append(-1)
            var satir : [Int] = []
            for _ in 0...i{
                satir.append(Int(String(Array(bulmacaBilgisi.characters)[k]))!)
                k += 1
            }
            sayilar.append(satir)
        }
    }
    
    func sayi(_ satir:Int, sutun:Int)->Int{
        return sayilar[satir][sutun]
    }
    
    func oynananDeger(_ satir:Int)->Int{
        return oynama[satir]
    }
    
    func oyna(_ satir: Int, deger:Int){
        oynama[satir] = deger
    }

    
}
