//
//  Tercihler.swift
//  EhliyetSinavi
//
//  Created by Olcay Taner YILDIZ on 1/11/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

class Tercihler{
    var trafikVarMi : Bool = true
    var motorVarMi : Bool = true
    var ilkYardimVarMi : Bool = true
    var trafikSoruSayisi : Int = 10
    var motorSoruSayisi : Int = 10
    var ilkYardimSoruSayisi : Int = 10
    
    init(trafikVarMi : Bool, motorVarMi : Bool, ilkYardimVarMi : Bool, trafikSoruSayisi : Int, motorSoruSayisi : Int, ilkYardimSoruSayisi : Int){
        self.trafikVarMi = trafikVarMi
        self.motorVarMi = motorVarMi
        self.ilkYardimVarMi = ilkYardimVarMi
        self.trafikSoruSayisi = trafikSoruSayisi
        self.motorSoruSayisi = motorSoruSayisi
        self.ilkYardimSoruSayisi = ilkYardimSoruSayisi
    }
}
