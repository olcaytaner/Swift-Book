//
//  Ceviri.swift
//  Sozluk
//
//  Created by Olcay Taner YILDIZ on 1/22/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Ceviri{
    var sinif : String = ""
    var anlam : Anlam
    
    init(sinif : String, anlam : Anlam){
        self.sinif = sinif
        self.anlam = anlam
    }
    
    init(anlam : Anlam){
        self.anlam = anlam
    }
}
