//
//  Kart.swift
//  Pisti
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Kart{
    var tip : String = ""
    var deger : Int = 0
    
    init(tip : String, deger : Int){
        self.tip = tip
        self.deger = deger
    }
    
    func description()->String{
        switch (deger){
            case 2, 3, 4, 5, 6, 7, 8, 9, 10:
                return tip + String(format: "_%d", deger)
            case 1:
                return tip + "_as"
            case 11:
                return tip + "_vale"
            case 12:
                return tip + "_kiz"
            case 13:
                return tip + "_papaz"
            default:
                return tip
        }
    }
}
