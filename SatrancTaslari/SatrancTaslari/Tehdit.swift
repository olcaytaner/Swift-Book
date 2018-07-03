//
//  Tehdit.swift
//  SatrancTaslari
//
//  Created by Olcay Taner YILDIZ on 1/18/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Tehdit : Kare{
    var tehditSayisi : Int = 0
    
    init(x : Int, y : Int, tehditSayisi : Int){
        super.init(x: x, y: y)
        self.tehditSayisi = tehditSayisi
    }
}
