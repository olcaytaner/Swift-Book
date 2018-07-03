//
//  Anlam.swift
//  Sozluk
//
//  Created by Olcay Taner YILDIZ on 1/22/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Anlam{
    var sinif : String = ""
    var anlam : String = ""
    
    init(sinif : String, anlam : String){
        self.sinif = sinif
        self.anlam = anlam
    }
    
    init(anlam : String){
        self.anlam = anlam
    }
}
