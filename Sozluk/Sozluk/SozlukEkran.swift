//
//  SozlukEkran.swift
//  Sozluk
//
//  Created by Olcay Taner YILDIZ on 1/22/15.
//  Copyright (c) 2015 Olcay Taner YILDIZ. All rights reserved.
//

import UIKit

class SozlukEkran : UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate{
    fileprivate var sozluk : Sozluk?
    fileprivate var sozlukKelimeler : [SozlukKelime] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sozluk = Sozluk(dosyaAd: "turkish-dictionary")
    }

    func searchDisplayController(_ controller: UISearchDisplayController,shouldReloadTableForSearch searchString: String?)->Bool{
        if let sozluk = sozluk{
            sozlukKelimeler = sozluk.kelimeAra(searchString!)
        }
        return true
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool{
        if let sozluk = sozluk{
            sozlukKelimeler = sozluk.kelimeAra(self.searchDisplayController!.searchBar.text!)
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return sozlukKelimeler[section].anlamSayisi()
        } else {
            return 0
        }
    }
    
    override func numberOfSections(in tableView: UITableView?)-> Int{
        return sozlukKelimeler.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var anlam : Anlam
        var sozlukKelime : SozlukKelime
        var anlamBilgi, koken : NSMutableAttributedString
        var anlamGosterge : UITextView
        let CellIdentifier = "SozlukHucre"
        var cell : UITableViewCell
        cell = self.tableView.dequeueReusableCell(withIdentifier: CellIdentifier)! as UITableViewCell
        sozlukKelime = sozlukKelimeler[(indexPath as NSIndexPath).section]
        anlam = sozlukKelime.anlam((indexPath as NSIndexPath).row)
        if (!sozlukKelime.sinif.isEmpty){
            anlamBilgi = NSMutableAttributedString(string: sozlukKelime.sinif)
            anlamBilgi.append(NSAttributedString(string: ". "))
            anlamBilgi.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSMakeRange(0, anlamBilgi.length))
        } else {
            anlamBilgi = NSMutableAttributedString(string: "")
        }
        if (!sozlukKelime.koken.isEmpty){
            koken = NSMutableAttributedString(string: sozlukKelime.koken)
            koken.append(NSAttributedString(string: ". "))
            anlamBilgi.append(NSAttributedString(attributedString: koken))
            anlamBilgi.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSMakeRange(anlamBilgi.length - koken.length, koken.length))
        }
        anlamBilgi.append(NSAttributedString(string: anlam.anlam))
        anlamGosterge = cell.viewWithTag(1) as! UITextView
        anlamGosterge.attributedText = anlamBilgi
        return cell
    }

}
