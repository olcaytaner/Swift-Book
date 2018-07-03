//
//  ViewController.swift
//  VucutKitleEndeksi
//
//  Created by Olcay Taner YILDIZ on 1/5/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class VucutKitleEndeksi: UIViewController {

    @IBOutlet weak var Boy: UITextField!
    @IBOutlet weak var Durum: UILabel!
    @IBOutlet weak var VucutKitleEndeks: UITextField!
    @IBOutlet weak var Kilo: UITextField!
    fileprivate var boy: Double = 0.0
    fileprivate var kilo: Double = 0.0
    fileprivate var vucutKitleEndeks: Double = 0.0

    override func viewDidLoad() {
        VucutKitleEndeks.isEnabled = false
        super.viewDidLoad()
    }
    
    @IBAction func BoyDegerIzleyici(_ sender: UITextField) {
        if (!Boy.text!.isEmpty){
            boy = atof(Boy.text!)
            sonucGoster()
        }
    }
    
    @IBAction func KiloDegerIzleyici(_ sender: UITextField) {
        if (!Kilo.text!.isEmpty){
            kilo = atof(Kilo.text!)
            sonucGoster()
        }
    }

    func sonucGoster(){
        vucutKitleEndeks = kilo / (boy * boy)
        if (vucutKitleEndeks < 20){
            Durum.text = "Zayıf"
        } else {
            if (vucutKitleEndeks < 25){
                Durum.text = "Normal"
            } else {
                if (vucutKitleEndeks < 30){
                    Durum.text = "Hafif Şişman"
                } else {
                    if (vucutKitleEndeks < 35){
                        Durum.text = "Şişman"
                    } else {
                        if (vucutKitleEndeks < 45){
                            Durum.text = "Önemli Derecede Şişman"
                        } else {
                            if (vucutKitleEndeks < 50){
                                Durum.text = "Aşırı Şişman"
                            } else {
                                Durum.text = "Ölümcül Şişman"
                            }
                        }
                    }
                }
            }
        }
        VucutKitleEndeks.text = String(format: "%.2f", vucutKitleEndeks)
    }

}

