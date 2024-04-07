//
//  MarketDataModel.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-04-03.
//

import Foundation

// Json Data
/*
 URL:https://pro-api.coingecko.com/api/v3/global?x_cg_pro_api_key=CG-Kn77CExSCifZkz7Y5hBAiqKj
 JSON RESPONSE:
 "data": {
 "active_cryptocurrencies": 13668,
 "upcoming_icos": 0,
 "ongoing_icos": 49,
 "ended_icos": 3376,
 "markets": 1040,
 "total_market_cap": {
 "btc": 39639751.552161835,
 "eth": 793879872.6589297,
 "ltc": 25753129186.47416,
 "bch": 4269149215.2868156,
 "bnb": 4675765338.993478,
 "eos": 2676921139038.393,
 "xrp": 4457485705512.27,
 "xlm": 20290254747197.25,
 "link": 145046482167.46948,
 "dot": 300939818011.34735,
 "yfi": 313049788.7664875,
 "usd": 2630771361281.825,
 "aed": 9661757747586.83,
 "ars": 2255941688497752,
 "aud": 4040346548970.7036,
 "bdt": 288092549079054.94,
 "bhd": 991577187637.539,
 "bmd": 2630771361281.825,
 "brl": 13328540024798.256,
 "cad": 3571377353794.5293,
 "chf": 2392168291127.6465,
 "clp": 2567817002606349.5,
 "cny": 19034946184554.645,
 "czk": 61841808097559.234,
 "dkk": 18226725868484.35,
 "eur": 2443810332949.6104,
 "gbp": 2092983818065.8726,
 "gel": 7063621105041.709,
 "hkd": 20595046217222.008,
 "huf": 964536714754377.4,
 "idr": 41890811158916450,
 "ils": 9809975406081.459,
 "inr": 219487751273764.44,
 "jpy": 399127477076872.56,
 "krw": 3552001107118190,
 "kwd": 809348916984.2712,
 "lkr": 785907868108387,
 "mmk": 5512817597503064,
 "mxn": 43622924558503.164,
 "myr": 12508002437214.436,
 "ngn": 3412110455582525.5,
 "nok": 28529918289378.914,
 "nzd": 4406060598987.961,
 "php": 148643840824374.47,
 "pkr": 731091361300218,
 "pln": 10492723712846.734,
 "rub": 243477271255362.9,
 "sar": 9867547206551.727,
 "sek": 28280723733724.242,
 "sgd": 3556750265025.8003,
 "thb": 96575616672655.7,
 "try": 84207615994974.86,
 "twd": 84273601002258.55,
 "uah": 103242446425589.6,
 "vef": 263419136405.14923,
 "vnd": 65711795442873690,
 "zar": 49532644621373.266,
 "xdr": 1986861132123.1226,
 "xag": 100162620808.33636,
 "xau": 1156592321.2739427,
 "bits": 39639751552161.836,
 "sats": 3963975155216183.5
 },
 "total_volume": {
 "btc": 2165813.1764449836,
 "eth": 43375536.46007665,
 "ltc": 1407084160.2869163,
 "bch": 233255236.48933384,
 "bnb": 255471686.49205452,
 "eos": 146260025560.5607,
 "xrp": 243545453661.83386,
 "xlm": 1108606874770.096,
 "link": 7924963451.446387,
 "dot": 16442570844.78082,
 "yfi": 17104228.226596966,
 "usd": 143738521443.06754,
 "aed": 527893375159.2028,
 "ars": 123258800646380.7,
 "aud": 220754052447.82706,
 "bdt": 15740629403541.549,
 "bhd": 54177204809.71379,
 "bmd": 143738521443.06754,
 "brl": 728236845039.1582,
 "cad": 195130792399.82193,
 "chf": 130701868763.74557,
 "clp": 140298858624934.84,
 "cny": 1040020071901.3151,
 "czk": 3378875941152.8477,
 "dkk": 995861010820.618,
 "eur": 133523455939.67308,
 "gbp": 114355205412.63281,
 "gel": 385937930074.6368,
 "hkd": 1125259889887.4836,
 "huf": 52699783529951.484,
 "idr": 2288805232811853.5,
 "ils": 535991603457.30585,
 "inr": 11992241251851.969,
 "jpy": 21807289780735.016,
 "krw": 194072124554579.7,
 "kwd": 44220724906.395485,
 "lkr": 42939966815410.11,
 "mmk": 301206050100956.2,
 "mxn": 2383443414864.6675,
 "myr": 683404800201.0643,
 "ngn": 186428862311658.5,
 "nok": 1558800712278.0696,
 "nzd": 240735719267.71503,
 "php": 8121513794837.6875,
 "pkr": 39944935109028.4,
 "pln": 573295199496.2949,
 "rub": 13302966381003.354,
 "sar": 539137177260.56464,
 "sek": 1545185368311.4192,
 "sgd": 194331606220.59836,
 "thb": 5276641122175.004,
 "try": 4600885654869.589,
 "twd": 4604490904464.425,
 "uah": 5640899402275.959,
 "vef": 14392538152.094355,
 "vnd": 3590322008722872,
 "zar": 2706335185879.4966,
 "xdr": 108556937196.14078,
 "xag": 5472625721.392203,
 "xau": 63193203.56723027,
 "bits": 2165813176444.9836,
 "sats": 216581317644498.34
 },
 "market_cap_percentage": {
 "btc": 49.62665059621736,
 "eth": 15.122036723653151,
 "usdt": 4.001014048207999,
 "bnb": 3.285999058892238,
 "sol": 3.217883672514115,
 "usdc": 1.2484745489154867,
 "xrp": 1.2309770181765667,
 "steth": 1.2045489570475514,
 "doge": 1.0181348160623493,
 "ada": 0.790387928071076
 },
 "market_cap_change_percentage_24h_usd": -0.7381745891556885,
 "updated_at": 1712129425
 }
 }
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    enum CodingKeys: String, CodingKey {
           case totalMarketCap = "total_market_cap"
           case totalVolume = "total_volume"
           case marketCapPercentage = "market_cap_percentage"
           case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        /// first Way
//        if let item = totalMarketCap.first(where: { (key, value) -> Bool in
//            return key == "usd"
//        }){
//            return "\(item.value)"
//        }

        /// Second Way
        if let item = totalMarketCap.first(where: {$0.key == "usd"}){
            return "$" + item.value.formattedWithAbbreviations()
        }
        
        return ""
    }
    
    var volume: String{
        if let item = totalVolume.first(where: {$0.key == "usd"}){
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: {$0.key == "btc"}){
            return item.value.asPercentString()
        }
            return ""
    }
}
