//
//  Soru.swift
//  EhliyetSinavi
//
//  Created by Olcay Taner YILDIZ on 1/11/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Soru{
    var soruTipi : String = ""
    var soruCumle : String = ""
    var cevap1 : String = ""
    var cevap2 : String = ""
    var cevap3 : String = ""
    var cevap4 : String = ""
    var dogruCevap : String = ""
    
    init(soruTipi:String, soruCumle:String, cevap1:String, cevap2:String, cevap3:String, cevap4:String, dogruCevap:String){
        self.soruTipi = soruTipi
        self.soruCumle = soruCumle
        self.cevap1 = cevap1
        self.cevap2 = cevap2
        self.cevap3 = cevap3
        self.cevap4 = cevap4
        self.dogruCevap = dogruCevap
    }
}
