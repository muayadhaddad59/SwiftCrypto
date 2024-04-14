//
//  PortfolioDataService.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-04-13.
//

import Foundation
import CoreData

class PortfolioDataService{
    
    private let continer: NSPersistentContainer
    private let conteinerName: String = "PortfolioContanier"
    private let entityName:String = "PortfolioEntirty"
    
    @Published var savedEntities: [PortfolioEntirty] = []
    
    init(){
        continer = NSPersistentContainer(name: conteinerName)
        continer.loadPersistentStores { _, error in
            if let error = error {
                print("Error Loading Core Data! \(error)")
                
            }
            self.getPortfolio()
        }
    }
    // MARK: - PUBLIC
    func updatedPortfolio(coin: CoinModel, amount: Double){
        /// Hard Way
//        if let entity = savedEntities.first(where: {$0.coinID == coin.id}){ }
        
        /// Easiest Way
        // Check if coin is already in portfolio
        if let entity = savedEntities.first(where: { savedEntity in
            return savedEntity.coinID == coin.id
        }){
            if amount > 0 {
                update(entity: entity, amount: amount)
            }else{
                remove(entity: entity)
            }
        }else{
            add(coin: coin, amount: amount)
        }
    }
    
    
    // MARK: - PRIVATE
    
    private func update(entity: PortfolioEntirty, amount: Double){
        entity.amount = amount
        applyChanges()
    }
    
    private func remove(entity: PortfolioEntirty){
        continer.viewContext.delete(entity)
        applyChanges()
    }
    
    private func getPortfolio(){
        let request = NSFetchRequest<PortfolioEntirty>(entityName: entityName)
        do{
            savedEntities =  try continer.viewContext.fetch(request)
        }catch let error{
            print("Error fetching portfolio entityes. \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double){
        let entity = PortfolioEntirty(context: continer.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    
    private func save(){
        do{
            try continer.viewContext.save()
        }catch let error{
            print("Error saving to Core Data. \(error)")
        }
    }
    
    private func applyChanges(){
        save()
        getPortfolio()
    }
}
