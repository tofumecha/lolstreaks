//
//  Participant.swift
//  lolstreaks
//
//  Created by Sean Chang on 12/8/15.
//  Copyright © 2015 Sean Chang. All rights reserved.
//

import Foundation

class Participant {
    var teamId: Int
    var spell1Id: Int
    var spell2Id: Int
    var championId: Int
    var profileIconId: Int
    var summonerName: String
    var summonerId: Int
    
    init(teamId: Int, spell1Id: Int, spell2Id: Int, championId: Int, profileIconId: Int, summonerName: String, summonerId: Int) {
        self.teamId = teamId
        self.spell1Id = spell1Id
        self.spell2Id = spell2Id
        self.championId = championId
        self.profileIconId = profileIconId
        self.summonerName = summonerName
        self.summonerId = summonerId
    }
    
    init(json:[String:AnyObject]){
        guard let teamId = json["teamId"] as? Int,
            let spell1Id = json["spell1Id"] as? Int,
            let spell2Id = json["spell2Id"] as? Int,
            let championId = json["championId"] as? Int,
            let profileIconId = json["profileIconId"] as? Int,
            let summonerName = json["summonerName"] as? String,
            let summonerId = json["summonerId"] as? Int else {
                self.teamId = -1
                self.spell1Id = -1
                self.spell2Id = -1
                self.championId = -1
                self.profileIconId = -1
                self.summonerName = ""
                self.summonerId = -1
                return
        }
        
        self.teamId = teamId
        self.spell1Id = spell1Id
        self.spell2Id = spell2Id
        self.championId = championId
        self.profileIconId = profileIconId
        self.summonerName = summonerName
        self.summonerId = summonerId
    }
}