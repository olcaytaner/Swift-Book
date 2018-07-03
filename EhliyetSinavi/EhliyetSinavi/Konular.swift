//
//  Konular.swift
//  EhliyetSinavi
//
//  Created by Olcay Taner YILDIZ on 1/11/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class Konular: UIViewController {

    @IBOutlet weak var trafikSayac: UILabel!
    @IBOutlet weak var motorSayac: UILabel!
    @IBOutlet weak var ilkYardimSayac: UILabel!
    @IBOutlet weak var trafikGosterge: UIStepper!
    @IBOutlet weak var motorGosterge: UIStepper!
    @IBOutlet weak var ilkYardimGosterge: UIStepper!
    @IBOutlet weak var trafik: UISwitch!
    @IBOutlet weak var motor: UISwitch!
    @IBOutlet weak var ilkYardim: UISwitch!
    var tercihler : Tercihler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _tercihler = tercihler{
            trafik.isOn = _tercihler.trafikVarMi
            motor.isOn = _tercihler.motorVarMi
            ilkYardim.isOn = _tercihler.ilkYardimVarMi
            trafikGosterge.value = Double(_tercihler.trafikSoruSayisi)
            motorGosterge.value = Double(_tercihler.motorSoruSayisi)
            ilkYardimGosterge.value = Double(_tercihler.ilkYardimSoruSayisi)
        }
        trafikSayac.text = String(format:"%d", Int(trafikGosterge.value))
        motorSayac.text = String(format:"%d", Int(motorGosterge.value))
        ilkYardimSayac.text = String(format:"%d", Int(ilkYardimGosterge.value))
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    @IBAction func konuTikla(_ sender: UISwitch) {
        let temelTercihler = UserDefaults.standard
        switch (sender.tag){
            case 1:temelTercihler.set(trafik.isOn, forKey:"trafikVarMi")
            case 2:temelTercihler.set(motor.isOn, forKey:"motorVarMi")
            case 3:temelTercihler.set(ilkYardim.isOn, forKey:"ilkYardimVarMi")
            default:break
        }
    }
    
    @IBAction func konuDegerDegistir(_ sender: UIStepper) {
        let temelTercihler = UserDefaults.standard
        switch (sender.tag){
            case 1:temelTercihler.set(Int(trafikGosterge.value), forKey: "trafikSoruSayisi")
                    trafikSayac.text = String(format:"%d", Int(trafikGosterge.value))
            case 2:temelTercihler.set(Int(motorGosterge.value), forKey: "motorSoruSayisi")
                    motorSayac.text = String(format:"%d", Int(motorGosterge.value))
            case 3:temelTercihler.set(Int(ilkYardimGosterge.value), forKey: "ilkYardimSoruSayisi")
                    ilkYardimSayac.text = String(format:"%d", Int(ilkYardimGosterge.value))
            default:break
        }
    }
    
}
