//
//  CeviriEkran.swift
//  Sozluk
//
//  Created by Olcay Taner YILDIZ on 1/22/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class CeviriEkran : UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate{
    fileprivate var ceviriSozluk : CeviriSozluk?
    fileprivate var ceviriSozlukKelimeler : [KaynakKelime] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ceviriSozluk = CeviriSozluk(dosyaAd: "english-turkish")
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController,shouldReloadTableForSearch searchString: String?)->Bool{
        if let ceviriSozluk = ceviriSozluk{
            ceviriSozlukKelimeler = ceviriSozluk.kelimeAra(searchString!)
        }
        return true
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool{
        if let ceviriSozluk = ceviriSozluk{
            ceviriSozlukKelimeler = ceviriSozluk.kelimeAra(self.searchDisplayController!.searchBar.text!)
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return ceviriSozlukKelimeler[section].ceviriSayisi()
        } else {
            return 0
        }
    }
    
    override func numberOfSections(in tableView: UITableView?)-> Int{
        return ceviriSozlukKelimeler.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var anlam : Anlam
        var ceviri : Ceviri
        var kaynakKelime : KaynakKelime
        var anlamBilgi: NSMutableAttributedString
        var anlamGosterge : UITextView
        let CellIdentifier = "CeviriSozlukHucre"
        var cell : UITableViewCell
        cell = self.tableView.dequeueReusableCell(withIdentifier: CellIdentifier)! as UITableViewCell
        kaynakKelime = ceviriSozlukKelimeler[(indexPath as NSIndexPath).section]
        ceviri = kaynakKelime.ceviri((indexPath as NSIndexPath).row)
        anlam = ceviri.anlam
        if (!ceviri.sinif.isEmpty){
            anlamBilgi = NSMutableAttributedString(string: ceviri.sinif)
            anlamBilgi.append(NSAttributedString(string: ". "))
            anlamBilgi.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSMakeRange(0, anlamBilgi.length))
            anlamBilgi.append(NSAttributedString(string: anlam.anlam))
        } else {
            anlamBilgi = NSMutableAttributedString(string: anlam.anlam)
        }
        anlamGosterge = cell.viewWithTag(1) as! UITextView
        anlamGosterge.attributedText = anlamBilgi
        return cell
    }

}
