//
//  ContentView.swift
//  ebayApp
//
//  Created by Megha Chandwani on 13/11/23.
//

import SwiftUI
import Inject
import SimpleToast
import UIKit
import Combine

struct parentSearchResults :Codable {
    let searchResult: [childSearchResult]
}
struct childSearchResult:Codable {
    let count: String
    let item : [SearchResults]?
     enum CodingKeys: String, CodingKey {
            case count = "@count"
            case item
        }
}

struct SearchResults : Codable,Hashable{
    let itemId:[String]
    let title:[String]
    let galleryURL:[String]
    let sellingStatus:[sellingStatusObject]
    let shippingInfo:[shippingInfoObject]
    let postalCode:[String]
    let condition:[conditionObject]
    
    func hash(into hasher: inout Hasher) {
          hasher.combine(itemId) // Replace 'identifier' with a property that uniquely identifies each SearchResults object
      }
    static func == (lhs: SearchResults, rhs: SearchResults) -> Bool {
           return lhs.itemId == rhs.itemId // Replace 'identifier' with a property that uniquely identifies each SearchResults object
       }
    
}
struct shippingServiceCostObject:Codable{
    var __value__ : String

}
struct shippingInfoObject:Codable{
    var shippingServiceCost :[shippingServiceCostObject]
}

struct sellingStatusObject :Codable {
    let currentPrice:[sellingPriceObject]
    let timeLeft:[String]
}

struct conditionObject:Codable{
    let conditionDisplayName:[String]
}
struct sellingPriceObject:Codable{
    let __value__ : String

}

struct individualItemData:Codable {
    let Item:itemStructure
}

struct similarProducts:Codable{
//    let ack:String
    let getSimilarItemsResponse:similarProductsResponseObject
}
struct similarProductsResponseObject: Codable {
    
    let itemRecommendations:itemRecommendationsObject
}
struct itemRecommendationsObject:Codable{
    let item:[itemObject]
    
}
struct itemObject: Codable{
    let imageURL:String
    let title:String
    let buyItNowPrice:priceObjectCurrentPrice
    let shippingCost:priceObjectShippingCost
    let timeLeft:String
}
struct priceObjectCurrentPrice:Codable{
    let value: String
    let currencyId: String
    enum CodingKeys: String, CodingKey {
           case value = "__value__"
           case currencyId = "@currencyId"
       }
   
}
struct priceObjectShippingCost:Codable{
    let value : String
    let currencyId: String
    enum CodingKeys: String, CodingKey {
           case value = "__value__"
           case currencyId = "@currencyId"
       }
    
}
struct wishListPayload:Codable{
    let title:String
    let galleryURL:String
    let price:String
    let shipping:String
    let zip:String
    let _id:String
    let condition:String
}


func frameWishListPayload(item:SearchResults) -> wishListPayload {

        let payload = wishListPayload(
            title:item.title[0],
        galleryURL:item.galleryURL[0],
            price:item.sellingStatus[0].currentPrice[0].__value__,
        shipping:item.shippingInfo[0].shippingServiceCost[0].__value__,
        zip:item.postalCode[0],
        _id:item.itemId[0],
            condition:item.condition[0].conditionDisplayName[0]
        )
    
    
    print(payload,"check-payloadd")
    return payload
    }
func frameWishListPayloadFromIndividualItem(item:itemStructure,itemId:String,shippingCost:String) -> wishListPayload {

        let payload = wishListPayload(
            title:item.Title,
            galleryURL:item.PictureURL[0],
            price:String(item.CurrentPrice.Value),
            shipping:   shippingCost,
            zip:item.PostalCode,
            _id:itemId,
            condition:item.ConditionDisplayName
        )
    
    
    print(payload,"check-payloadd")
    return payload
    }




struct itemStructure:Codable{
    let PictureURL:[String]
    let Title:String
    let CurrentPrice:individualCurrentPriceObject
    let ItemSpecifics:itemSpecificsObject
    let Storefront:storeFrontObject?
    let Seller:sellerObjectIndividualItem
    let GlobalShipping: Bool
    let HandlingTime: Int?
    let ReturnPolicy: returnPolicyObject?
    let PostalCode: String
    let ConditionDisplayName:String
    let ViewItemURLForNaturalSearch:String
    enum CodingKeys: String, CodingKey {
            case PictureURL
            case Title
            case CurrentPrice
            case ItemSpecifics
            case Storefront="Storefront"
            case Seller
            case GlobalShipping
            case HandlingTime = "HandlingTime"
            case ReturnPolicy="ReturnPolicy"
            case PostalCode
            case ConditionDisplayName
            case ViewItemURLForNaturalSearch
       }
}

struct returnPolicyObject:Codable{
    let ReturnsAccepted:String?
    let ReturnsWithin:String?
    let ShippingCostPaidBy:String?
    let Refund:String?
    enum CodingKeys:String,CodingKey{
        case ReturnsAccepted = "ReturnsAccepted"
        case ReturnsWithin = "ReturnsWithin"
        case ShippingCostPaidBy = "ShippingCostPaidBy"
        case Refund = "Refund"
        
    }
    
    
}
struct sellerObjectIndividualItem:Codable{
    let FeedbackScore:Float?
    let PositiveFeedbackPercent:Float?
    enum CodingKeys:String,CodingKey{
        case FeedbackScore = "FeedbackScore"
        case PositiveFeedbackPercent = "PositiveFeedbackPercent"
       
        
    }
    
}
struct storeFrontObject:Codable{
    let StoreName:String
    let StoreURL:String
}

struct itemSpecificsObject:Codable{
    let NameValueList:[itemNameValueList]
}

struct itemNameValueList:Codable{
    let Name: String
    let Value:[String]
}

struct individualCurrentPriceObject:Codable{
    let Value:Float
}
struct wishListedItems:Codable {
    var data:[wishListedItemsObject]?
}
struct wishListedItemsObject: Codable,Hashable {
   
    let id: String
    let title: String
    var galleryURL:String
    let price:String
    let shipping:String
    let zip:String
    let shippingCost:String?
    let shipToLocations:String?
    let handlingTime:String?
    let expeditedShipping:String?
    let oneDayShipping:String?
    let returnAccepted:String?
    let condition:String
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title
        case galleryURL
        case price
        case shipping
        case zip
        case shippingCost = "Shipping Cost"
        case shipToLocations = "Ship To Locations"
        case handlingTime = "Handling Time"
        case expeditedShipping = "Expedited Shipping"
        case oneDayShipping = "One Day Shipping"
        case returnAccepted = "Return Accepted"
        case  condition
       }

}
struct googleSearchEngine: Decodable{
    let items:[googleSearchEngineResponseObject]
}
struct googleSearchEngineResponseObject:Codable{
    let link:String
}
struct currentLocation:Codable{
    let zip:String
}


class Toast:ObservableObject{
    @Published var isAddedToastShown: Bool
    init(initialValue: Bool = false) {
        self.isAddedToastShown = initialValue
    }
    func updateToast(newValue: Bool) {
        
        isAddedToastShown = newValue
       }
}
let ToastInstance = Toast()

class RemovedToast:ObservableObject{
    @Published var isRemovedToastShown: Bool
    init(initialValue: Bool = false) {
        self.isRemovedToastShown = initialValue
    }
    func updateToast(newValue: Bool) {
        
        isRemovedToastShown = newValue
       }
}
let RemovedToastInstance = RemovedToast()

func updateToastOutside(globalDataInstance: Toast, newValue: Bool) {
    globalDataInstance.updateToast(newValue: newValue)
}
func updateRemovedToastOutside(globalDataInstance: RemovedToast, newValue: Bool) {
    globalDataInstance.updateToast(newValue: newValue)
}

class GlobalWishListDataClass: ObservableObject {
    @Published var myGlobalWishList: wishListedItems
    
    init(initialValue: wishListedItems = wishListedItems.init(data: [])) {
        self.myGlobalWishList = initialValue
    }
    func updateMyGlobalWishList(newValue: wishListedItems) {
        
        myGlobalWishList.data = newValue.data
       }
    

}
func updatemyGlobalWishListFromOutside(globalDataInstance: GlobalWishListDataClass, newValue: wishListedItems) {
    globalDataInstance.updateMyGlobalWishList(newValue: newValue)
}
let GlobalWishListDataClassInstance = GlobalWishListDataClass()
//let @ObservedObject var WishListedItems:GlobalWishListDataClassInstance
    
    
    
    func getInsertInWishList(payloadData:wishListPayload) async throws-> wishListedItems {
    //    self.resultsLoading = true
        let serverBaseUrl = "https://burnished-ember-404408.wl.r.appspot.com/"
        let endpoint = "\(serverBaseUrl)insertInWishList"
        var components = URLComponents(string: endpoint)!
        var queryItems = [URLQueryItem]()

        let mirror = Mirror(reflecting: payloadData)
        for case let (label?, value) in mirror.children {
            let queryItem = URLQueryItem(name: label, value: "\(value)")
               queryItems.append(queryItem)
                print("Property: \(label), Value: \(value)")
        }
                components.queryItems = queryItems


        guard let url = components.url else {throw APIError.invalidURL}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data,response) = try await URLSession.shared.data(for: request)
        print(data,response,"check data and response")
        guard let response = response as? HTTPURLResponse,response.statusCode == 200 else{
            throw APIError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
        
           
    //            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(wishListedItems.self,from:data)
            
    }
        catch let error {
            print("An unexpected error occurred:  \(error.localizedDescription)---- \(error)")
            throw APIError.invalidData
        }
        
        
    }

    func wishListItems(data:wishListPayload)
    {
        Task {
            do {
                let data = try await getInsertInWishList(payloadData:data)
    //            self.resultsLoading = false
  
                DispatchQueue.main.async {
                    
                    updatemyGlobalWishListFromOutside(globalDataInstance: GlobalWishListDataClassInstance, newValue: data)
//                    updateToastOutside(globalDataInstance: ToastInstance, newValue: true)
                    
                    
                }
            }     catch APIError.invalidURL{
                print("Invalid URL")
    //            self.resultsLoading = false
                
            }
                catch APIError.invalidResponse{
                print("Invalid Response")
    //                self.resultsLoading = false
                
            }
                catch APIError.invalidData{
                print("Invalid Data")
    //                self.resultsLoading = false
                
            }
        }
        
    }


func getRemoveWishList(payloadData:String) async throws-> wishListedItems {
//    self.resultsLoading = true
    let serverBaseUrl = "https://burnished-ember-404408.wl.r.appspot.com/"
    let endpoint = "\(serverBaseUrl)removeItem/\(payloadData)"
    let components = URLComponents(string: endpoint)!



    guard let url = components.url else {throw APIError.invalidURL}
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let (data,response) = try await URLSession.shared.data(for: request)
    print(data,response,"check data and response")
    guard let response = response as? HTTPURLResponse,response.statusCode == 200 else{
        throw APIError.invalidResponse
    }
    do {
        let decoder = JSONDecoder()
    
       
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(wishListedItems.self,from:data)
        
}
    catch let error {
        print("An unexpected error occurred:  \(error.localizedDescription)---- \(error)")
        throw APIError.invalidData
    }
    
    
}
func removeWishListItems(data:String)
{
    Task {
        do {
            let data = try await getRemoveWishList(payloadData:data)
//            self.resultsLoading = false

            DispatchQueue.main.async {
                
                updatemyGlobalWishListFromOutside(globalDataInstance: GlobalWishListDataClassInstance, newValue: data)
//                updateRemovedToastOutside(globalDataInstance: RemovedToastInstance, newValue: true)
                
                
            }
        }     catch APIError.invalidURL{
            print("Invalid URL")
//            self.resultsLoading = false
            
        }
            catch APIError.invalidResponse{
            print("Invalid Response")
//                self.resultsLoading = false
            
        }
            catch APIError.invalidData{
            print("Invalid Data")
//                self.resultsLoading = false
            
        }
    }
    
}



struct ContentView: View {
    @ObserveInjection var inject
    @State private var keyword = ""
    @State private var distance = "10"
    @State private var zip = ""
    @State  var serverBaseUrl = "https://burnished-ember-404408.wl.r.appspot.com/"
    @State var resultsLoading:Bool = false
    enum Categories: String, CaseIterable, Identifiable {
        case all = "All"
        case art = "Art"
        case baby = "Baby"
        case books = "Books"
        case clothing = "Clothing Shoes & Accesories"
        case computers = "Computers Tablets & Networking"
        case health = "Health & Beauty"
        case music = "Music"
        case video = "Video Games & Consoles"
        var id: Self { self }
    }

    @State var isUsedSelected:Bool = false
    @State var isNewSelected:Bool = false
    @State var isUnspecifiedSelected:Bool = false
    @State var isFreeShippingSelected:Bool = false
    @State var isPickUpSelected:Bool = false
    @State var isCustomLocationSelected:Bool = false
    @State var shouldPresentAutoComplete: Bool = false
    @State var submitButtonClicked:Bool = false
    @State private var selectedCategory: Categories = .all
    @State private var selectedCategoryId: String = "All"
    @State  var postalCode: PostalCodes?
//    @State var conditionsArray:Array =  [""]
    @State private var isToastShown = false
    @State var payloadStructData : searchAPIPayload?
    @State var SearchResultsTable : parentSearchResults?
    private let toastOptions = SimpleToastOptions(
            alignment:.bottom,
            hideAfter: 2
            
           
        )
    @StateObject var isAddedToastShown = ToastInstance
    @StateObject var isRemovedToastShown = RemovedToastInstance
    
    var body: some View {
        
        NavigationView{
            VStack{
            Form{
                
                HStack{
                    Text("Keyword")
                    TextField("Required",text: $keyword)
                }
                
                List {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(Categories.allCases) { category in
                            Text(category.rawValue).tag(category)
                               
                        }
                    }
                    .pickerStyle(.menu)
                    .accentColor(.blue)
                }
                
                VStack(alignment: .leading)
                {
                    Text("Condition")
                    Spacer().frame(height: 10)
                    HStack{
                        Spacer()
                        
                        Toggle("", isOn:$isUsedSelected)
                            .toggleStyle(ToggleCheckboxStyle())
                        Text("Used")
                        
                        Spacer()
                        Toggle("", isOn:$isNewSelected)
                            .toggleStyle(ToggleCheckboxStyle())
                        Text("New")
                        Spacer()
                        
                        Toggle("", isOn:$isUnspecifiedSelected)
                            .toggleStyle(ToggleCheckboxStyle())
                        Text("Unspecified")
                        Spacer()
                    }
                }
                VStack(alignment: .leading)
                {
                    Text("Shipping")
                    Spacer().frame(height: 10)
                    HStack(alignment: .center){
                        Spacer()
                        Toggle("", isOn:$isPickUpSelected)
                            .toggleStyle(ToggleCheckboxStyle())
                        Text("Pickup")
                        
                        Spacer()
                        Toggle("", isOn:$isFreeShippingSelected)
                            .toggleStyle(ToggleCheckboxStyle())
                        Text("Free Shipping")
                        
                        Spacer()
                        
                    }
                }
                HStack{
                    Text("Distance")
                    TextField("10",text: $distance).foregroundColor(Color.gray).opacity(0.8)
                }
                HStack{
                    Text("Custom Location")
                    Toggle("", isOn:$isCustomLocationSelected)
                }.onAppear{
                    fetchIP()
                    print("Called")
                }
                if isCustomLocationSelected {
                    HStack{
                        Text("Zipcode")
                        TextField("Required",text: $zip)
                            .keyboardType(.numberPad)
                            .onChange(of: zip) {
                                oldValue, newValue in
                                print("Changing from \(oldValue) to \(newValue)")
                                if zip.count > 2 && zip.count < 5 {
                                    
                                    fetchPostalCode(zip:zip)
                                }
                            }
                            .sheet(isPresented: $shouldPresentAutoComplete) {
                                print("Sheet dismissed!")
                            } content: {
                                Spacer()
                                
                                Text("Pincode Suggestions").font(.system(size: 22)).fontWeight(.bold)
                                
                                List{
                                    if let postalCodes = self.postalCode {
                                        
                                        ForEach(postalCodes.postalCodes, id: \.postalCode) { postCode in
                                            
                                            Text(postCode.postalCode).onTapGesture {
                                                zip = postCode.postalCode
                                                self.shouldPresentAutoComplete = false
                                                
                                            }
                                        }
                                    }
                                }
                            }
                    }
                    
                }
                HStack{
                    Spacer()
                    
                    Button(action: {
                        
                        
                        if keyword.count == 0
                        {
                            self.isToastShown = true
                        }
                        else
                        {
                            self.submitButtonClicked = true
                            self.resultsLoading = true
                            
                            let payloadData =  framePayload()
                            fetchSearchResults(payloadData:payloadData)
                            
                        }
                        
                    }) {
                        Text("Submit")
                            .foregroundColor(.white)
                            .padding() // Add padding to the text
                            .frame(maxWidth: 100)
                            .background(Color.blue)
                            .cornerRadius(8)
                        
                    }.padding(.trailing, 20)
                    
                    
                    Button(action: {
                        clearForm()
                    }) {
                        Text("Clear")
                            .foregroundColor(.white)
                            .padding() // Add padding to the text
                            .frame(maxWidth: 100)
                            .background(Color.blue)
                            .cornerRadius(8)
                        
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                    
                    
                    
                    
                    
                }
//            }
                if  submitButtonClicked {
//                    List{
                        Section{
                            
                            Text("Results").font(.title).fontWeight(.bold)
                            
                            
                            
                            
                            if self.resultsLoading
                            {
                                HStack{
                                    Spacer()
                                    VStack(){
                                        Text("Please wait").foregroundColor(Color.secondary)
                                        ProgressView().progressViewStyle(CircularProgressViewStyle()).id(UUID()).foregroundColor(Color.secondary)
                                    }
                                    Spacer()
                                }
                            }
                            
                            if let unwrappedSearchResultsTable = SearchResultsTable {
                                
                                DetailView(SearchResultsTable: Binding<parentSearchResults>(
                                    get: { unwrappedSearchResultsTable },
                                    set: { newValue in
                                        
                                        SearchResultsTable = newValue
                                    }))
                                
                            }
                            
                        }
                      
                    }
                    
                    
                    
                }
                    
                }
            .navigationTitle("Product Search")
            .navigationBarItems(
                trailing: ZStack{
//                Button(action: {
                        NavigationLink (
                            destination: WishListedItemsView()
                           
                        )
                    {
                        Circle().stroke(Color.blue,lineWidth: 2).frame(width:23,height:23).overlay(Image(systemName: "heart.fill").foregroundColor(Color.blue).font(.system(size: 12)))

                    }.buttonStyle(PlainButtonStyle())
                    
                }
                    
                    
                    
//                    Circle().stroke(Color.blue,lineWidth: 2).frame(width:23,height:23)
//                    .overlay(Image(systemName: "heart.fill").foregroundColor(Color.blue).font(.system(size: 12)))
                   
                    // You can use any desired image here
                  
            )
            
          
        }
       
        
       
        .enableInjection()
        
        .simpleToast(isPresented: $isToastShown, options: toastOptions) {
            Text("Keyword is mandatory.")
                .padding()
                .background(Color.black.opacity(0.8))
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .padding(.top)
                
            }
        .simpleToast(isPresented: $isAddedToastShown.isAddedToastShown, options: toastOptions) {
            Text("Added to favourites")
                .padding()
                .background(Color.black.opacity(0.8))
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .padding(.top)
            
        }
        .simpleToast(isPresented: $isRemovedToastShown.isRemovedToastShown, options: toastOptions) {
            Text("Removed from favourites")
                .padding()
                .background(Color.black.opacity(0.8))
                .foregroundColor(Color.white)
                .cornerRadius(10)
                .padding(.top)
            
        }
        
        }

    

    func clearForm(){
        self.submitButtonClicked = false
        SearchResultsTable = parentSearchResults(searchResult: [childSearchResult(count: "", item: [])])
        self.keyword = ""
        self.isUsedSelected = false
        self.isNewSelected = false
        self.isUnspecifiedSelected = false
        self.isFreeShippingSelected = false
        self.isPickUpSelected = false
        self.isCustomLocationSelected = false
        self.selectedCategory = .all
        self.distance = "10"
        self.zip = ""
    }
  
    

    func framePayload() -> searchAPIPayload {
      
        var conditionsArray: [String] = []
        if isUsedSelected{
            conditionsArray.append("Used")
            
        }
        if isNewSelected{
            conditionsArray.append("New")
        }
        if isUnspecifiedSelected{
            conditionsArray.append("Unspecified")
        }
       
                
        switch selectedCategory {
        case .all:
            selectedCategoryId = "All Categories"
        case .art:
            selectedCategoryId = "550"
        case .baby:
            selectedCategoryId = "2984"
        case .books:
            selectedCategoryId = "267"
        case .clothing:
            selectedCategoryId = "11450"
        case .computers:
            selectedCategoryId = "58058"
        case .health:
            selectedCategoryId =  "26395"
        case .music:
            selectedCategoryId =  "11233"
        case .video:
            selectedCategoryId =  "1249"
        }
        if zip == ""{
            zip = "90007"
            
        }
               
        
        let payload = searchAPIPayload(Condition: conditionsArray, FreeShippingOnly: isFreeShippingSelected, LocalPickupOnly: isPickUpSelected, MaxDistance: distance, buyerPostalCode: zip, categoryId: selectedCategoryId, keywords: keyword)
        
        
        print(payload,"check-payloadd")
        return payload
        }
     
        
        
    
        
                
   
    
   
        
    func fetchPostalCode(zip:String) {
            Task {
                do {
                    let data = try await getPinCodes(zip:zip)
                    
                    DispatchQueue.main.async {
                        
                        self.postalCode = data
                        self.shouldPresentAutoComplete = true
                    }
                }     catch APIError.invalidURL{
                    print("Invalid URL")
                    
                }
                    catch APIError.invalidResponse{
                    print("Invalid Response")
                    
                }
                    catch APIError.invalidData{
                    print("Invalid Data")
                    
                }
            }
        }
    
    func fetchSearchResults(payloadData:searchAPIPayload) {
            // Asynchronously fetch postal code
      
            Task {
                do {
                    let data = try await getSearchItem(payloadData:payloadData)
                    self.resultsLoading = false
                    // Update the UI on the main thread
                    DispatchQueue.main.async {
                        
                        self.SearchResultsTable = data
                        
                    }
                }     catch APIError.invalidURL{
                    print("Invalid URL")
                    self.resultsLoading = false
                    
                }
                    catch APIError.invalidResponse{
                    print("Invalid Response")
                        self.resultsLoading = false
                    
                }
                    catch APIError.invalidData{
                    print("Invalid Data")
                        self.resultsLoading = false
                    
                }
            }
        }
    
    
    func getSearchItem(payloadData:searchAPIPayload) async throws -> parentSearchResults {
        let endpoint = "\(serverBaseUrl)getItemsByKeyword"
        var components = URLComponents(string: endpoint)!
        var queryItems = [URLQueryItem]()

        let mirror = Mirror(reflecting: payloadData)
        for case let (label?, value) in mirror.children {
            let queryItem = URLQueryItem(name: label, value: "\(value)")
               queryItems.append(queryItem)
//            print("Property: \(label), Value: \(value)")
        }
                components.queryItems = queryItems
        
        
        
        guard let url = components.url else {throw APIError.invalidURL}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data,response) = try await URLSession.shared.data(for: request)
        print(data,response,"check data and response")
        guard let response = response as? HTTPURLResponse,response.statusCode == 200 else{
            throw APIError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
        
           
         
            
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(parentSearchResults.self,from:data)
            
    }
        catch let error {
            print("An unexpected error occurred: \(error.localizedDescription)")
            throw APIError.invalidData
        }
    
}
    func getPinCodes(zip:String) async throws -> PostalCodes {
        let endpoint = "\(serverBaseUrl)pinCodeSuggestion"
        
        var components = URLComponents(string: endpoint)!
        components.queryItems = [
            URLQueryItem(name:"postalcode_startsWith",value: zip),
              
           ]
        guard let url = components.url else {throw APIError.invalidURL}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data,response) = try await URLSession.shared.data(for: request)
  
        guard let response = response as? HTTPURLResponse,response.statusCode == 200 else{
            throw APIError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
        
           
         
            
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(PostalCodes.self,from:data)
            
    }
        catch let error {
            print("An unexpected error occurred: \(error.localizedDescription)")
            throw APIError.invalidData
        }
    
}
    
    func getIpAddress() async throws-> currentLocation {
        
        
        let endpoint = "https://ip-api.com/json/"
        let components = URLComponents(string: endpoint)!
    


        guard let url = components.url else {throw APIError.invalidURL}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data,response) = try await URLSession.shared.data(for: request)
        print(data,response,"check data and response")
        guard let response = response as? HTTPURLResponse,response.statusCode == 200 else{
            throw APIError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
        
           
    //            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(currentLocation.self,from:data)
            
    }
        catch let error {
            print("An unexpected error occurred:  \(error.localizedDescription)---- \(error)")
            throw APIError.invalidData
        }
        
        
    }
    func fetchIP(){
        Task {
            do {
                let data = try await getIpAddress()
    //            self.resultsLoading = false

                DispatchQueue.main.async {
                    
                    zip = data.zip
                    print(zip,"Okay ip checkkkk")
                    
                    
                }
            }     catch APIError.invalidURL{
                print("Invalid URL")
    //            self.resultsLoading = false
                
            }
                catch APIError.invalidResponse{
                print("Invalid Response")
    //                self.resultsLoading = false
                
            }
                catch APIError.invalidData{
                print("Invalid Data")
    //                self.resultsLoading = false
                
            }
        }
        
    }
    
   

struct PostCodeObject:Codable {
    let postalCode: String
    }
struct PostalCodes: Codable {
let postalCodes: [PostCodeObject]
}
    
    struct searchAPIPayload :Codable {
        let Condition : [String]
        let FreeShippingOnly: Bool
        let LocalPickupOnly:Bool
        let MaxDistance:String
        let buyerPostalCode:String
        let categoryId:String
        let keywords:String
        
    }
}

struct WishListedItemsView:View{
    @State  var serverBaseUrl = "https://burnished-ember-404408.wl.r.appspot.com/"
    @State var resultsLoading:Bool?
    @State var sumOfItems:Double = 0.00
    @ObservedObject var wishList = GlobalWishListDataClassInstance
    
    @State var delayedText:Bool?
    var body: some View{
        VStack{
            if wishList.myGlobalWishList.data!.isEmpty {
                if self.resultsLoading ?? false{
                    Text("Loading..")
                }
                else
                {
                    VStack{
                        if self.delayedText ?? false
                        {
                            Text("No items in wishlist.")
                        }
                    }
                    .onAppear {
                        // After 2 seconds, set the flag to show the text
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            self.delayedText = true
                        }
                    }
                    
                }
            }
                else{
                    if let items = wishList.myGlobalWishList.data{
//                        Form{
                            Section{
                                
//                                ScrollView{
                                    List{
                                        
                                        if wishList.myGlobalWishList.data?.count ?? 0 > 0
                                        {
                                            HStack{
                                                let wishlistCount = wishList.myGlobalWishList.data?.count
                                                Text("Wishlist total (" + String(wishlistCount ?? 0) + ") items:")
                                                Spacer()
                                                let sum = wishList.myGlobalWishList.data?.compactMap { Double($0.price) }.reduce(0, +)
                                                Text(String(sum ?? 0.00))
                                            
                                            }
                                        }
                                        ForEach(items, id: \.self) { item in
                                            
                                            HStack
                                            {
                                                AsyncImage(url: URL(string: item.galleryURL)) { phase in
                                                    switch phase {
                                                    case .success(let image):
                                                        image
                                                            .resizable()
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 65, height: nil)
                                                            .cornerRadius(3)// Set frame size for the image
                                                    case .failure(_):
                                                        Text("Failed to load the image")
                                                    case .empty:
                                                        ProgressView().progressViewStyle(CircularProgressViewStyle()).id(UUID()).foregroundColor(Color.secondary)
                                                        // Placeholder or loading indicator while the image is being fetched
                                                    @unknown default:
                                                        EmptyView()
                                                    }
                                                }
                                                VStack(alignment: .leading) {
                                                    Text(truncateTextIfNeeded(text:item.title)).lineLimit(1).frame(alignment: .leading).padding(.leading)
                                                    
                                                    
                                                    Text("$\(item.price)").padding(.leading).foregroundColor(Color.blue).fontWeight(.bold)
                                                    
                                                    
                                                    
                                                    
                                                    HStack
                                                    {
                                                        if item.shipping == "0.0"
                                                        {
                                                            Text("FREE SHIPPING").padding(.leading).foregroundColor(Color.gray)
                                                        }
                                                        else
                                                        {
                                                            Text("$\(item.shipping)").padding(.leading).foregroundColor(Color.gray)
                                                        }
                                                        Spacer()
                                                        ZStack{
                                                            Button(action: {
                                                                print("Removed")
                                                                removeWishListItems(data:item.id)
                                                            }) {
                                                                Image(systemName: "heart.fill")
                                                                    .font(.system(size: 27)).foregroundColor(Color.red)
                                                            }.buttonStyle(PlainButtonStyle())
                                                            
                                                        }
                                                    }
                                                    
                                                    
                                                    HStack{
                                                        Text(item.zip).padding(.leading).foregroundColor(Color.gray)
                                                        Spacer()
                                                        Text(item.condition).foregroundColor(Color.gray)
                                                    }
                                                    
                                                    
                                                    Spacer()
                                                   
                                                }
                                                
                                            }
                                            
                                            
                                            
                                        }.onDelete { indexSet in
                                            for index in indexSet{
                                                removeWishListItems(data: items[index].id)
                                                print(index,items[index].id,"Check itemssssss"
                                                
                                                )
                                                
                                                
                                            }
                                           
                                        }
                                    }
                                    
                                    
//                                }
                            }
                            .enableInjection()
                           
                      
                            
                        }
//                    }
                }
            
        }.navigationTitle("Favourites")
            .onAppear{
                
                fetchWishlistedItems()
                
                    
                
            }
        
    }

    func getWishlistedItems() async throws-> wishListedItems {
        
        let endpoint = "\(serverBaseUrl)getWishlistedItems"
        let components = URLComponents(string: endpoint)!

 
        guard let url = components.url else {throw APIError.invalidURL}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data,response) = try await URLSession.shared.data(for: request)
        print(data,response,"check data and response")
        guard let response = response as? HTTPURLResponse,response.statusCode == 200 else{
            throw APIError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
        
           
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(wishListedItems.self,from:data)
            
    }
        catch let error {
            print("An unexpected error occurred:  \(error.localizedDescription)---- \(error)")
            throw APIError.invalidData
        }
        
        
    }
    
    func fetchWishlistedItems()
    {
//        print("Calleddd")
        Task {
            do {
                self.resultsLoading = true
                let data = try await getWishlistedItems()
                self.resultsLoading = false
                // Update the UI on the main thread
                DispatchQueue.main.async {
                    
                    wishList.updateMyGlobalWishList(newValue: data)
//                    myGlobalWishList = data
                    print(data )
                    
                    
                }
            }     catch APIError.invalidURL{
                print("Invalid URL")
                self.resultsLoading = false
                
            }
                catch APIError.invalidResponse{
                print("Invalid Response")
                    self.resultsLoading = false
                
            }
                catch APIError.invalidData{
                print("Invalid Data")
                    self.resultsLoading = false
                
            }
        }
        
    }
}


struct DetailView: View {
    
    @Binding var SearchResultsTable:parentSearchResults
    @StateObject var WishListedItems = GlobalWishListDataClassInstance
    @StateObject var isAddedToastShown = ToastInstance
    @StateObject var isRemovedToastShown = RemovedToastInstance
    var body: some View {
        Section{
            if let items = SearchResultsTable.searchResult[0].item {
                // Unwrap the optional item array and iterate over it
                
                ForEach(items, id: \.self) { item in
                    
                    NavigationLink (
                        destination: IndividualItem(itemId:item.itemId[0],shippingCost:item.shippingInfo[0].shippingServiceCost[0].__value__,itemTitle:item.title[0])
                        
                    ) {
                        HStack
                        {
                            AsyncImage(url: URL(string: item.galleryURL[0])) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 65, height: nil)
                                        .cornerRadius(3)// Set frame size for the image
                                case .failure(_):
                                    Text("Failed to load the image")
                                case .empty:
                                    ProgressView().progressViewStyle(CircularProgressViewStyle()).id(UUID()).foregroundColor(Color.secondary)
                                    // Placeholder or loading indicator while the image is being fetched
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            VStack(alignment: .leading) {
                                Text(truncateTextIfNeeded(text:item.title[0])).lineLimit(1).frame(alignment: .leading).padding(.leading)
                                
                                
                                Text("$\(item.sellingStatus[0].currentPrice[0].__value__)").padding(.leading).foregroundColor(Color.blue).fontWeight(.bold)
                                
                                
                                
                                
                                HStack
                                {
                                    if item.shippingInfo[0].shippingServiceCost[0].__value__ == "0.0"
                                    {
                                        Text("FREE SHIPPING").padding(.leading).foregroundColor(Color.gray)
                                    }
                                    else
                                    {
                                        Text("$\(item.shippingInfo[0].shippingServiceCost[0].__value__)").padding(.leading).foregroundColor(Color.gray)
                                    }
                                    Spacer()
                                    ZStack{
                                        Button(action: {
                                            if (WishListedItems.myGlobalWishList.data?.first(where: { $0.id == item.itemId[0] })) != nil {
                                               
                                                removeWishListItems(data: item.itemId[0])
                                                DispatchQueue.main.asyncAfter(deadline: .now()+2)
                                                {
                                                    isRemovedToastShown.updateToast(newValue: true)
                                                }
                                                
                                                
                                            } else {
                                                let payloadData = frameWishListPayload(item:item)
                                                wishListItems(data:payloadData)
                                                DispatchQueue.main.asyncAfter(deadline: .now()+2)
                                                {
                                                    isAddedToastShown.updateToast(newValue: true)
                                                }
                                               
                                                
                                            }
                                            
                                            
                                            
                                            
                                            //                                            self.isWishlistSelected.toggle()
                                        }) {
                                            if (WishListedItems.myGlobalWishList.data?.first(where: { $0.id == item.itemId[0] })) != nil {
                                                
                                                Image(systemName: "heart.fill")
                                                    .font(.system(size: 27)).foregroundColor(Color.red)
                                            } else {
                                                Image(systemName: "heart")
                                                    .font(.system(size: 27)).foregroundColor(Color.red)
                                            }
                                            
                                            
                                            
                                        }.buttonStyle(PlainButtonStyle())
                                        
                                    }
                                }
                                
                                
                                HStack{
                                    Text(item.postalCode[0]).padding(.leading).foregroundColor(Color.gray)
                                    Spacer()
                                    
                                    Text(item.condition[0].conditionDisplayName[0]).foregroundColor(Color.gray)
                                }
                                
                                
                                Spacer()
                            }
                            
                        }.onAppear{
                            fetchWishList()
                        }
                        
                        
                        
                    }
                    
                }
                /*Text(item.itemId[0])*/ // Replace 'someProperty' with the actual property you want to display
                
            } else {
                // Handle the case when the item array is nil
                Text("No Results found.").foregroundColor(Color.red)
            }
        }
   
        
      
        
           
    }
    
    func fetchWishList(){
        let instanceWishList = WishListedItemsView()
        instanceWishList.fetchWishlistedItems()
    }
}


class UserData: ObservableObject {
    @Published var selectedTabIndex = 0
}

struct PhotosView:View {
    @Binding var GooglePhotos:googleSearchEngine
    var body:some View {
//        VStack{
//        ScrollView{
//            VStack{
        if GooglePhotos.items.count != 0 {
            VStack {
                HStack
                {
                    Text("Powered By").frame(width:100)
                    Image("google")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:100)
                }
                ScrollView{
                    ForEach(0..<GooglePhotos.items.count, id: \.self) { index in
                        if URL(string: GooglePhotos.items[index].link) != nil {
                            AsyncImage(url: URL(string: GooglePhotos.items[index].link)) { phase in
                                switch phase {
                                    
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 160)
                                        .padding(.horizontal,100)
                                        .padding(.bottom,30)
                                    
                                case .failure(_):
                                    
                                    
                                    AsyncImage(url: URL(string: GooglePhotos.items[index].link)) { phase in
                                        switch phase {
                                            
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 160)
                                                .padding(.horizontal,100)
                                                .padding(.bottom,30)
                                            
                                        case .failure(_):
                                            Text("Failed")
                                            //
                                        case .empty:
                                            ProgressView().progressViewStyle(CircularProgressViewStyle()).id(UUID()).foregroundColor(Color.secondary)
                                            // Placeholder or loading indicator while the image is being fetched
                                        @unknown default:
                                            EmptyView()
                                            Text("hereee")
                                        }
                                    }
                                    
                                    
                                    
                                    
                                case .empty:
                                    ProgressView().progressViewStyle(CircularProgressViewStyle()).id(UUID()).foregroundColor(Color.secondary)
                                    // Placeholder or loading indicator while the image is being fetched
                                @unknown default:
                                    EmptyView()
                                    Text("hereee")
                                }
                            }
                            
                        } else {
                            Text("Invalid URL") // Display if the URL is invalid
                        }
                    }
                }
            }.padding(.top,50)
        }
        }
    }

struct SimilarProductsView:View{
    
    
    @Binding var SimilarProducts:[itemObject]

    
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
   
 
        
    var body:some View{
       
            LazyVGrid(columns: columns){
                let SortedLists = SimilarProducts
                
                ForEach(0..<(SortedLists.count ),id:\.self)
                {
                    index in
                    
                    VStack {
                    
                        AsyncImage(url: URL(string: SortedLists[index].imageURL)) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height:200)
                                    .cornerRadius(10)
                                    .padding(.top,3)
                                    .padding(.horizontal,12)
                            case .failure(_):
                                Text("Failed to load the image")
                            case .empty:
                                ProgressView().progressViewStyle(CircularProgressViewStyle()).id(UUID()).foregroundColor(Color.secondary)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        
                        Text(SortedLists[index].title)
                            .padding(.horizontal,16)
                            .truncationMode(.tail)
                            .lineLimit(2)
                            .padding(.top,12)
                            .padding(.bottom,1)
                        HStack{
                            Text("$" + (SortedLists[index].shippingCost.value)).foregroundColor(Color.gray).font(.system(size: 14))
                            Spacer().frame(width:10)
                            let str = SortedLists[index].timeLeft
                            if let indexP = str.firstIndex(of: "P")
                            {
                                
                                if let indexD = str.firstIndex(of: "D")
                                {
                                    let nextIndex = str.index(after: indexP)
                                    let time_left = str[nextIndex..<indexD]
                                    Text(time_left + " days left")
                                        .foregroundColor(Color.gray)
                                        .font(.system(size: 14))
                                    
                                }
                                
                            }
                        }
                        .padding(.horizontal,16)
                        HStack(){
                            Spacer()
                            Text("$" + SortedLists[index].buyItNowPrice.value).foregroundColor(Color.blue).font(.system(size: 17)).fontWeight(.bold)
                        }
                        .padding(.trailing,22)
                        .padding(.bottom,20)
                        .padding(.top,12)
                        
                    }
                    
                    .background(Color.secondary.opacity(0.1))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5),lineWidth:3))
                    .padding(.horizontal,10)
                    .padding(.bottom,4)
                    
                    
                }
                
            }


    }
                

        }


struct ItemInfoView: View{
    @Binding var itemData:individualItemData?
    var body: some View {
        ScrollView
        {
            
            
            Section
            {
                if let unwrappedItemData = itemData {
                    VStack
                    {
                        Spacer()
                        AutoScroller(imageNames:(unwrappedItemData.Item.PictureURL))
                    }
                }
                else {
                    
                    ProgressView().progressViewStyle(CircularProgressViewStyle()).id(UUID()).foregroundColor(Color.secondary)
                }
            }
            Section
            {
                VStack(alignment: .leading,spacing: 0) {
                    Text(itemData?.Item.Title ?? "").padding(.horizontal, 20)
                    Spacer().frame(height: 10)
                    Text( "$" + String(itemData?.Item.CurrentPrice.Value ?? 0.0)).padding(.horizontal, 20).foregroundColor(Color.blue).fontWeight(.bold)
                    Spacer().frame(height: 10)
                    HStack
                    {
                        Image(systemName: "magnifyingglass")
                        
                            .foregroundColor(Color.black)
                        Text("Description")
                    }.padding(.horizontal, 20).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom,25)
                    
                    Divider().background(Color.black).fontWeight(.bold).padding(.leading,20).padding(.trailing,20)
                    HStack(alignment: .top){
                       
                        HStack
                        {
                            
                            VStack(alignment:.leading,spacing:0){
                                if let itemSpecifics = self.itemData?.Item.ItemSpecifics.NameValueList {
                                    ForEach(0..<itemSpecifics.count,id:\.self){index in
                                        Text(itemSpecifics[index].Name).lineLimit(1)
                                            .truncationMode(.tail)
                                        Divider().background(Color.black).fontWeight(.bold)
                                        
                                    }
                                    
                                }
                               
                            }
                            VStack(alignment:.leading,spacing: 0){
                                if let itemSpecifics = self.itemData?.Item.ItemSpecifics.NameValueList {
                                    ForEach(0..<itemSpecifics.count,id:\.self){index in
                                        Text(itemSpecifics[index].Value[0]).lineLimit(1)
                                            .truncationMode(.tail).padding(.trailing,20)
                                       
                                        Divider().background(Color.black).padding(.leading,-10).padding(.trailing,20).fontWeight(.bold)
                                    }
                                    
                                }
                                
                            }
                          
                        }
                        

                        
                    }.padding(.leading,20)
                    
                }
                
            }
        }
    }
}

struct ShippingInfoView:View{
    @Binding var itemData:individualItemData?
    @State var shippingCost:String
    var body: some View{
        VStack()
        {
            if itemData?.Item.Storefront != nil ||
                itemData?.Item.Seller.FeedbackScore != nil ||
                itemData?.Item.Seller.PositiveFeedbackPercent != nil
                
            {
                Section{
                    VStack(){
                        //                 Spacer()
                        Divider()
                        //
                        HStack(alignment:.top,spacing:0){
                            VStack{
                                Spacer().frame(height:10)
                                Image(systemName: "storefront")
                                Spacer().frame(height:10)
                            }
                            
                            VStack
                            {
                                Spacer().frame(height:7)
                                Text("Seller").padding(.leading,9)
                                Spacer().frame(height:7)
                            }
                            Spacer()
                            
                        }.padding(.leading,5)
                        //                    Spacer().frame(height:10)
                        Divider()
                        //                            }
                        //                            Spacer()
                        //                            VStack(alignment:.leading)
                        //                            {
                        HStack(){
                            VStack()
                            {
                                
                                if ((itemData?.Item.Storefront?.StoreName) != nil)
                                {
                                    Text("Store Name")
                                }
                                if ((itemData?.Item.Seller.FeedbackScore) != nil)
                                {
                                    Text("Feedback Score")
                                }
                                if ((itemData?.Item.Seller.PositiveFeedbackPercent) != nil)
                                {
                                    Text("Popularity")
                                }
                                
                                
                            }.padding(.leading,35)
                            Spacer().frame(width:58)
                            VStack
                            {
                                if ((itemData?.Item.Storefront?.StoreName) != nil)
                                {
                                    Text(itemData?.Item.Storefront?.StoreName ?? "").foregroundColor(Color.blue)
                                        .truncationMode(.tail)
                                        .lineLimit(1)
                                    
                                        .onTapGesture {
                                            
                                            let storeurl = "\(itemData?.Item.Storefront?.StoreURL ?? "")"
                                            
                                            if let url = URL(string: storeurl) {
                                                print(url,"CHECK URL")
                                                UIApplication.shared.open(url)
                                            }
                                        }
                                       
                                }
                                if ((itemData?.Item.Seller.FeedbackScore) != nil)
                                {
                                    Text(String(itemData?.Item.Seller.FeedbackScore ?? 0))
                                }
                                if ((itemData?.Item.Seller.PositiveFeedbackPercent) != nil)
                                {
                                    Text(String(itemData?.Item.Seller.PositiveFeedbackPercent ?? 0))
                                }
                                
                                
                            }
                            .padding(.trailing,40)
                        }
                        
                    }
                    //                            Spacer().frame(height:20)
                    
                }.frame(maxHeight: 150, alignment: .top)
            }
            //                    if itemData?.Item.HandlingTime != nil ||
            //                        shippingCost != nil ||
            //                        itemData?.Item.GlobalShipping != nil
            //
            //                    {
            Section{
                Spacer()
                VStack(){
                    
                    Divider()
                    
                    HStack(alignment:.top,spacing:0){
                        VStack{
                            Spacer().frame(height:10)
                            Image(systemName: "sailboat")
                            Spacer().frame(height:10)
                        }
                        
                        VStack
                        {
                            Spacer().frame(height:7)
                            Text("Shipping Info").padding(.leading,9)
                            Spacer().frame(height:7)
                        }
                        Spacer()
                        
                    }.padding(.leading,5)
                    
                    Divider()
                    //                            }
                    //
                    HStack(){
                        VStack()
                        {
                            
                            
                            Text("Shipping Cost")
                            
                            if ((itemData?.Item.GlobalShipping) != nil)
                            {
                                Text("Global Shipping")
                            }
                            if ((itemData?.Item.HandlingTime) != nil)
                            {
                                Text("Handling Time")
                            }
                            
                        }
                        .padding(.trailing,55)
                        Spacer().frame(width:50)
                        VStack
                        {
                            if (shippingCost != "0.0")
                            {
                                Text("$" + shippingCost)
                            }
                            else{
                                Text("FREE")
                            }
                            if ((itemData?.Item.GlobalShipping) != nil)
                            {
                                if(itemData?.Item.GlobalShipping == true)
                                {
                                    Text("Yes")
                                }
                                else
                                {
                                    Text("No")
                                }
                                
                            }
                            if ((itemData?.Item.HandlingTime) != nil)
                            {
                                Text(String(itemData?.Item.HandlingTime ?? 0))
                            }
                            
                            
                        }.padding(.trailing,25)
                    }
                    
                    
                    
                }
                
            }.frame(maxHeight: .infinity, alignment: .top)
            if itemData?.Item.ReturnPolicy != nil
            {
                Section{
                    VStack(){
                        //                 Spacer()
                        Divider()
                        //
                        HStack(alignment:.top,spacing:0){
                            VStack{
                                Spacer().frame(height:10)
                                Image(systemName: "return")
                                Spacer().frame(height:10)
                            }
                            
                            VStack
                            {
                                Spacer().frame(height:7)
                                Text("Return policy").padding(.leading,9)
                                Spacer().frame(height:7)
                            }
                            Spacer()
                            
                        }
                      
                        Divider()
                     
                        HStack(){
                            VStack(alignment:.center)
                            {
                                
                                if ((itemData?.Item.ReturnPolicy?.ReturnsAccepted) != nil)
                                {
                                    Text("Policy")
                                }
                                if ((itemData?.Item.ReturnPolicy?.Refund) != nil)
                                {
                                    Text("Refund Mode")
                                }
                                if ((itemData?.Item.ReturnPolicy?.ReturnsWithin) != nil)
                                {
                                    Text("Refund Within")
                                }
                                if ((itemData?.Item.ReturnPolicy?.ShippingCostPaidBy) != nil)
                                {
                                    Text("Shipping Cost Paid By")
                                }
                                
                                
                            }.padding(.leading,30)
//                                    Spacer().frame(width:20)
                            VStack
                            {
                                if ((itemData?.Item.ReturnPolicy?.ReturnsAccepted) != nil)
                                {
                                    if itemData?.Item.ReturnPolicy?.ReturnsAccepted == "ReturnsNotAccepted"
                                    {
                                        Text("Returns Not Accepted").padding(.leading,30).lineLimit(1)
                                            .truncationMode(.tail)
                                    }
                                    else{
                                        Text(itemData?.Item.ReturnPolicy?.ReturnsAccepted ?? "")
                                    }
                                    
                                   
                                }
                                if ((itemData?.Item.ReturnPolicy?.Refund) != nil)
                                {
                                    Text(String(itemData?.Item.ReturnPolicy?.Refund ?? "")).padding(.trailing,20)
                                }
                                if ((itemData?.Item.ReturnPolicy?.ReturnsWithin) != nil)
                                {
                                    Text(String(itemData?.Item.ReturnPolicy?.ReturnsWithin ?? ""))
                                }
                                if ((itemData?.Item.ReturnPolicy?.ShippingCostPaidBy) != nil)
                                {
                                    Text(String(itemData?.Item.ReturnPolicy?.ShippingCostPaidBy ?? ""))
                                }
                                
                                
                            }
                        }
                        
                    }.frame(maxHeight: 100, alignment: .top)
                Spacer().frame(height:280)
                    
                }
            }
            
            
        }.padding(.top,50)
    }
    
}
struct DefaultSimilarProducts:View{
    @Binding var SimilarProducts:similarProducts
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View{
        
           
                LazyVGrid(columns: columns){
                    let SortedLists = SimilarProducts.getSimilarItemsResponse.itemRecommendations.item
                    
                    ForEach(0..<(SortedLists.count ),id:\.self)
                    {
                        index in
                        
                        VStack {
                        
                            AsyncImage(url: URL(string: SortedLists[index].imageURL)) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height:200)
                                        .cornerRadius(10)
                                        .padding(.top,3)
                                        .padding(.horizontal,12)
                                case .failure(_):
                                    Text("Failed to load the image")
                                case .empty:
                                    ProgressView().progressViewStyle(CircularProgressViewStyle()).id(UUID()).foregroundColor(Color.secondary)
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            
                            Text(SortedLists[index].title)
                                .padding(.horizontal,16)
                                .truncationMode(.tail)
                                .lineLimit(2)
                                .padding(.top,12)
                                .padding(.bottom,1)
                            HStack{
                                Text("$" + (SortedLists[index].shippingCost.value)).foregroundColor(Color.gray).font(.system(size: 14))
                                Spacer().frame(width:10)
                                let str = SortedLists[index].timeLeft
                                if let indexP = str.firstIndex(of: "P")
                                {
                                    
                                    if let indexD = str.firstIndex(of: "D")
                                    {
                                        let nextIndex = str.index(after: indexP)
                                        let time_left = str[nextIndex..<indexD]
                                        Text(time_left + " days left")
                                            .foregroundColor(Color.gray)
                                            .font(.system(size: 14))
                                        
                                    }
                                    
                                }
                            }
                            .padding(.horizontal,16)
                            HStack(){
                                Spacer()
                                Text("$" + SortedLists[index].buyItNowPrice.value).foregroundColor(Color.blue).font(.system(size: 17)).fontWeight(.bold)
                            }
                            .padding(.trailing,22)
                            .padding(.bottom,20)
                            .padding(.top,12)
                            
                        }
                        
                        .background(Color.secondary.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5),lineWidth:3))
                        .padding(.horizontal,10)
                        .padding(.bottom,4)
                        
                        
                    }
                    
                }


        
        
        
    }
}
    
struct PickerView:View{
    @State private var selectedSortOption = 0
    @State private var selectedOrder = 0
    @Binding var SimilarProducts:similarProducts
    let sortOptions = ["Default", "Name", "Price","Days Left","Shipping"]
    let selectedOrderOptions = ["Ascending","Descending"]
    @State private var sortedItems: [itemObject] = []
    var body: some View
    {
        VStack{
            VStack(alignment:.leading){
                HStack(alignment:.top,spacing:0)
                {
                    
                    Text("Sort By").font(.system(size: 22)).fontWeight(.bold)
                    Spacer()
                }.padding(.leading,12)
            }
    
            Picker("Options", selection: $selectedSortOption) {
                ForEach(0..<sortOptions.count, id: \.self) {
                    Text(sortOptions[$0])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal,12)
            .padding(.bottom,14)
            .onChange(of: selectedSortOption)
            {
                self.selectedOrder = 0
                print(sortOptions[selectedSortOption],"Check in here")
                if sortOptions[selectedSortOption] == "Name" && selectedOrderOptions[selectedOrder] == "Ascending"{
                    sortedItems = SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted{ $0.title < $1.title }
//
                }
                if sortOptions[selectedSortOption] == "Name" && selectedOrderOptions[selectedOrder] == "Descending"{
                    sortedItems = SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted{ $0.title > $1.title }
//
                }
                if sortOptions[selectedSortOption] == "Price" && selectedOrderOptions[selectedOrder] == "Ascending"{
                     sortedItems = SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted { (item1:itemObject, item2:itemObject) -> Bool in
                        if let price1 = Double(item1.buyItNowPrice.value), let price2 = Double(item2.buyItNowPrice.value) {
                            return price1 < price2
                        }
                        return false // Handle cases where price conversion fails
                    }
                    
                    
//                    sortedItems = SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted{ $0.buyItNowPrice.value < $1.buyItNowPrice.value }
//
                }
                if sortOptions[selectedSortOption] == "Price" && selectedOrderOptions[selectedOrder] == "Descending"{
                    sortedItems = SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted { (item1:itemObject, item2:itemObject) -> Bool in
                       if let price1 = Double(item1.buyItNowPrice.value), let price2 = Double(item2.buyItNowPrice.value) {
                           return price1 > price2
                       }
                       return false // Handle cases where price conversion fails
                   }
                    
//
                }
                if sortOptions[selectedSortOption] == "Shipping" && selectedOrderOptions[selectedOrder] == "Ascending"{
                    sortedItems = SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted { (item1:itemObject, item2:itemObject) -> Bool in
                       if let price1 = Float(item1.shippingCost.value), let price2 = Float(item2.shippingCost.value) {
                           return price1 < price2
                       }
                       return false // Handle cases where price conversion fails
                   }
//                    sortedItems = SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted{ $0.shippingCost.value < $1.shippingCost.value }
//
                }
                if sortOptions[selectedSortOption] == "Shipping" && selectedOrderOptions[selectedOrder] == "Descending" {
                    sortedItems = SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted { (item1:itemObject, item2:itemObject) -> Bool in
                       if let price1 = Float(item1.shippingCost.value), let price2 = Float(item2.shippingCost.value) {
                           return price1 > price2
                       }
                       return false // Handle cases where price conversion fails
                   }
//                    sortedItems = SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted{ $0.shippingCost.value > $1.shippingCost.value }
//
                }
                if sortOptions[selectedSortOption] == "Days Left" && selectedOrderOptions[selectedOrder] == "Ascending" {
                    sortedItems =  SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted { item1, item2 in
                                          guard let indexP1 = item1.timeLeft.firstIndex(of: "P"),
                                                let indexD1 = item1.timeLeft.firstIndex(of: "D"),
                                                let indexP2 = item2.timeLeft.firstIndex(of: "P"),
                                                let indexD2 = item2.timeLeft.firstIndex(of: "D") else {
                                              return false // Handle cases where the expected characters are not found
                                          }

                                          let nextIndex1 = item1.timeLeft.index(after: indexP1)
                                          let timeLeft1 = Int(item1.timeLeft[nextIndex1..<indexD1])

                                          let nextIndex2 = item2.timeLeft.index(after: indexP2)
                                          let timeLeft2 = Int(item2.timeLeft[nextIndex2..<indexD2])
                                            
                                          return timeLeft1! < timeLeft2!
                                      }

                }
                if sortOptions[selectedSortOption] == "Days Left" && selectedOrderOptions[selectedOrder] == "Descending" {
                    sortedItems =  SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted { item1, item2 in
                                          guard let indexP1 = item1.timeLeft.firstIndex(of: "P"),
                                                let indexD1 = item1.timeLeft.firstIndex(of: "D"),
                                                let indexP2 = item2.timeLeft.firstIndex(of: "P"),
                                                let indexD2 = item2.timeLeft.firstIndex(of: "D") else {
                                              return false // Handle cases where the expected characters are not found
                                          }

                                          let nextIndex1 = item1.timeLeft.index(after: indexP1)
                                          let timeLeft1 = Int(item1.timeLeft[nextIndex1..<indexD1])

                                          let nextIndex2 = item2.timeLeft.index(after: indexP2)
                                          let timeLeft2 = Int(item2.timeLeft[nextIndex2..<indexD2])
                                        
                                          return timeLeft1! > timeLeft2!
                                      }

                }
                
            }
            
            if sortOptions[selectedSortOption] != "Default" {
                VStack {
                    
                    HStack
                    {
                        
                        Text("Order").font(.system(size: 20)).fontWeight(.bold)
                        Spacer()
                    }.padding(.leading,12)
                    Picker("selectedOrderOptions", selection: $selectedOrder) {
                        ForEach(0..<selectedOrderOptions.count, id: \.self) {
                            Text(selectedOrderOptions[$0])
                        }
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal,12)
                    .padding(.bottom, 13)
                    .onChange(of: selectedOrder){
                        print(sortOptions[selectedSortOption],"Check in here")
                        if sortOptions[selectedSortOption] == "Name" && selectedOrderOptions[selectedOrder] == "Ascending"{
                            sortedItems = SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted{ $0.title < $1.title }
//
                        }
                        if sortOptions[selectedSortOption] == "Name" && selectedOrderOptions[selectedOrder] == "Descending"{
                            sortedItems = SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted{ $0.title > $1.title }
//
                        }
                        if sortOptions[selectedSortOption] == "Price" && selectedOrderOptions[selectedOrder] == "Ascending"{
                            sortedItems = SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted { (item1:itemObject, item2:itemObject) -> Bool in
                               if let price1 = Double(item1.buyItNowPrice.value), let price2 = Double(item2.buyItNowPrice.value) {
                                   return price1 < price2
                               }
                               return false // Handle cases where price conversion fails
                           }
//                            sortedItems = SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted{ $0.buyItNowPrice.value < $1.buyItNowPrice.value }
//
                        }
                        if sortOptions[selectedSortOption] == "Price" && selectedOrderOptions[selectedOrder] == "Descending"{
                            sortedItems = SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted { (item1:itemObject, item2:itemObject) -> Bool in
                               if let price1 = Double(item1.buyItNowPrice.value), let price2 = Double(item2.buyItNowPrice.value) {
                                   return price1 > price2
                               }
                               return false // Handle cases where price conversion fails
                           }
                            
                            
                          
//
                        }
                        if sortOptions[selectedSortOption] == "Shipping" && selectedOrderOptions[selectedOrder] == "Ascending"{
                            sortedItems = SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted { (item1:itemObject, item2:itemObject) -> Bool in
                               if let price1 = Float(item1.shippingCost.value), let price2 = Float(item2.shippingCost.value) {
                                   return price1 < price2
                               }
                               return false // Handle cases where price conversion fails
                           }
//
                        }
                        if sortOptions[selectedSortOption] == "Shipping" && selectedOrderOptions[selectedOrder] == "Descending" {
                            sortedItems = SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted { (item1:itemObject, item2:itemObject) -> Bool in
                               if let price1 = Float(item1.shippingCost.value), let price2 = Float(item2.shippingCost.value) {
                                   return price1 > price2
                               }
                               return false // Handle cases where price conversion fails
                           }
//
                        }
                        if sortOptions[selectedSortOption] == "Days Left" && selectedOrderOptions[selectedOrder] == "Ascending" {
                            sortedItems =  SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted { item1, item2 in
                                                  guard let indexP1 = item1.timeLeft.firstIndex(of: "P"),
                                                        let indexD1 = item1.timeLeft.firstIndex(of: "D"),
                                                        let indexP2 = item2.timeLeft.firstIndex(of: "P"),
                                                        let indexD2 = item2.timeLeft.firstIndex(of: "D") else {
                                                      return false // Handle cases where the expected characters are not found
                                                  }

                                                  let nextIndex1 = item1.timeLeft.index(after: indexP1)
                                                  let timeLeft1 = Int(item1.timeLeft[nextIndex1..<indexD1])

                                                  let nextIndex2 = item2.timeLeft.index(after: indexP2)
                                                  let timeLeft2 = Int(item2.timeLeft[nextIndex2..<indexD2])
                                print(timeLeft1 ?? 0,timeLeft2 as Any,"CHECKKKKKK")
                                               
                                return timeLeft1! < timeLeft2!
                                    
                                                
                                                
                                              }

                        }
                        if sortOptions[selectedSortOption] == "Days Left" && selectedOrderOptions[selectedOrder] == "Descending" {
                            sortedItems =  SimilarProducts.getSimilarItemsResponse.itemRecommendations.item.sorted { item1, item2 in
                                                  guard let indexP1 = item1.timeLeft.firstIndex(of: "P"),
                                                        let indexD1 = item1.timeLeft.firstIndex(of: "D"),
                                                        let indexP2 = item2.timeLeft.firstIndex(of: "P"),
                                                        let indexD2 = item2.timeLeft.firstIndex(of: "D") else {
                                                      return false // Handle cases where the expected characters are not found
                                                  }

                                                  let nextIndex1 = item1.timeLeft.index(after: indexP1)
                                                  let timeLeft1 = Int(item1.timeLeft[nextIndex1..<indexD1])

                                                  let nextIndex2 = item2.timeLeft.index(after: indexP2)
                                                  let timeLeft2 = Int(item2.timeLeft[nextIndex2..<indexD2])

                                                  return timeLeft1! > timeLeft2!
                                              }

                        }
                    
                        
                    }
                    
                    
                    ScrollView{

//                            if let unwrappedSimilarProducts = sortedItems? {

                                SimilarProductsView(SimilarProducts: $sortedItems
                                       )


//                            }


                    }
                }
            
                
                Spacer()
            }
            
            else{
                
            ScrollView{

//                     let unwrappedSimilarProducts = SimilarProducts {

                        DefaultSimilarProducts(SimilarProducts: Binding<similarProducts>(
                            get: { SimilarProducts },
                            set: { newValue in

                                SimilarProducts  = newValue
                            })
                               )


//                    }


            }
           
         
                            
                
            }
        
            

        }
    }
}




struct IndividualItem : View{
    var itemId:String
    var shippingCost:String
    var itemTitle:String
    @State  var serverBaseUrl = "https://burnished-ember-404408.wl.r.appspot.com/"
    @State var itemData:individualItemData?
    @State var GooglePhotos:googleSearchEngine?
    @State var SimilarProducts:similarProducts?
    @StateObject var WishListedItems = GlobalWishListDataClassInstance
    @State var itemDataLoading = false
    @ObservedObject var userData = UserData()
    
    var body: some View{
        TabView(selection: $userData.selectedTabIndex) {
            
            VStack
            {
                if itemDataLoading{
                    ProgressView().progressViewStyle(CircularProgressViewStyle()).id(UUID()).foregroundColor(Color.secondary)
                }
               
                if let unwrappedItemData = itemData {
                    
                    ItemInfoView(itemData: Binding<individualItemData?>(
                        get: { unwrappedItemData },
                        set: { newValue in
                            
                            itemData = newValue
                        }))
                    
                }
                
            }
                .tabItem {
                    Image(systemName: "info.circle")
                    Text("Info")
                    
                }
                .tag(0)
            
            Section
            {
                if itemDataLoading{
                    ProgressView().progressViewStyle(CircularProgressViewStyle()).id(UUID()).foregroundColor(Color.secondary)
                }
                if let unwrappedItemData = itemData {
                    
                    ShippingInfoView(itemData: Binding<individualItemData?>(
                        get: { unwrappedItemData },
                        set: { newValue in
                            
                            itemData = newValue
                        }),shippingCost:shippingCost)
                    
                }
                   
            
            }.tabItem {
                    Image(systemName: "shippingbox")
                    Text("Shipping")
                }
                .tag(1)
            
            VStack{
               
                    if let unwrappedGooglePhotos = GooglePhotos {
                        
                        PhotosView(GooglePhotos: Binding<googleSearchEngine>(
                            get: { unwrappedGooglePhotos },
                            set: { newValue in
                                
                                GooglePhotos = newValue
                            }))
                        
                    
                }
            }.tabItem {
                    Image(systemName: "photo.stack")
                    Text("Photos")
            }.onAppear{
                self.itemDataLoading = true
                fetchGooglePhotos(itemTitle: itemTitle)
            }
                .tag(2)
            VStack(alignment:.leading){
                if itemDataLoading{
                    ProgressView().progressViewStyle(CircularProgressViewStyle()).id(UUID()).foregroundColor(Color.secondary)
                }
                if let unwrappedSimilarProducts = SimilarProducts {
                    
                    PickerView(SimilarProducts: Binding<similarProducts>(
                        get: { unwrappedSimilarProducts },
                        set: { newValue in
                            
                            SimilarProducts  = newValue
                        })
                           )
                    
                    
                }
                
                
            }.tabItem {
                    Image(systemName: "list.bullet.indent")
                    Text("Similar")
                }.onAppear
            {
                self.itemDataLoading = true
                fetchSimilarProducts(itemId: itemId)
                self.itemDataLoading = false
            }
                .tag(3)
        
    }.onAppear
        {
            self.itemDataLoading = true
            fetchIndividualItemData(itemId:itemId)
          
            
          
            
            
    }
            .navigationBarItems(trailing:
                                    HStack{
                
                Button(action: {
                    let facebook_url = "\(itemData?.Item.ViewItemURLForNaturalSearch ?? ""))"
                
                    if let url = URL(string: "https://www.facebook.com/dialog/share?app_id=1322665478423355&href=\(facebook_url)") {
                        print(url,"CHECK URL")
                        UIApplication.shared.open(url)
                    }
                }) {
                   
                        
                    Image("fb")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:22)
                    
            
                    
                    
                    
                    
                }.buttonStyle(PlainButtonStyle())
                
                
                Button(action: {
                    if (WishListedItems.myGlobalWishList.data?.first(where: { $0.id == itemId })) != nil {
                        
                        removeWishListItems(data: itemId)
                    } else {
                        let payloadData = frameWishListPayloadFromIndividualItem(item:itemData!.Item,itemId:itemId,shippingCost:shippingCost)
                        wishListItems(data:payloadData)
                    }
                }) {
                    if (WishListedItems.myGlobalWishList.data?.first(where: { $0.id == itemId})) != nil {
                        
                        Image(systemName: "heart.fill")
                            .font(.system(size: 18)).foregroundColor(Color.red)
                    } else {
                        Image(systemName: "heart")
                            .font(.system(size: 18)).foregroundColor(Color.red)
                    }
                    
                    
                    
                }.buttonStyle(PlainButtonStyle())
            }
            )
            .navigationBarTitle("",displayMode:.inline)
           
    }


    
    func fetchIndividualItemData(itemId:String)
    {
        Task {
            do {
                let data = try await getIndividualItemData(payloadData:itemId)
                self.itemDataLoading = false
                // Update the UI on the main thread
                DispatchQueue.main.async {
                    
                    self.itemData = data
                    print(itemData ??  "Check-result-item-data")
                    
                    
                }
            }     catch APIError.invalidURL{
                print("Invalid URL")
                self.itemDataLoading = false
                
            }
                catch APIError.invalidResponse{
                print("Invalid Response")
                    self.itemDataLoading = false
                
            }
                catch APIError.invalidData{
                print("Invalid Data")
                    self.itemDataLoading = false
                
            }
        }
        
    }
    func fetchSimilarProducts(itemId:String)
    {
        Task {
            do {
                let data = try await getSimilarProducts(payloadData:itemId)
                self.itemDataLoading = false
                // Update the UI on the main thread
                DispatchQueue.main.async {
                    
                    self.SimilarProducts = data
                    print(SimilarProducts ??  "Check-result-item-data")
                    
                    
                }
            }     catch APIError.invalidURL{
                print("Invalid URL")
                self.itemDataLoading = false
                
            }
                catch APIError.invalidResponse{
                print("Invalid Response")
                    self.itemDataLoading = false
                
            }
                catch APIError.invalidData{
                print("Invalid Data")
                    self.itemDataLoading = false
                
            }
        }
        
    }

    
    func fetchGooglePhotos(itemTitle:String)
    {
        Task {
            do {
                let data = try await fetchPhotos(payloadData:itemTitle)
                self.itemDataLoading = false
                // Update the UI on the main thread
                DispatchQueue.main.async {
                    
                    self.GooglePhotos = data
                    print(GooglePhotos ??  "Check-result-item-data")
                    
                    
                }
            }     catch APIError.invalidURL{
                print("Invalid URL")
                self.itemDataLoading = false
                
            }
                catch APIError.invalidResponse{
                print("Invalid Response")
                    self.itemDataLoading = false
                
            }
                catch APIError.invalidData{
                print("Invalid Data")
                    self.itemDataLoading = false
                
            }
        }
        
    }
    

        
    
    func getIndividualItemData(payloadData:String) async throws -> individualItemData {
        let endpoint = "\(serverBaseUrl)getSingleItem"
        var components = URLComponents(string: endpoint)!
        components.queryItems = [
            URLQueryItem(name:"item_id",value: payloadData),
              
           ]
 
        guard let url = components.url else {throw APIError.invalidURL}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data,response) = try await URLSession.shared.data(for: request)
        print(data,response,"check data and response")
        guard let response = response as? HTTPURLResponse,response.statusCode == 200 else{
            throw APIError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
        
           
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(individualItemData.self,from:data)
            
    }
        catch let error {
            print("An unexpected error occurred:  \(error.localizedDescription)---- \(error)")
            throw APIError.invalidData
        }
        
    }
    func getSimilarProducts(payloadData:String) async throws -> similarProducts {
        let endpoint = "\(serverBaseUrl)getSimilarProducts"
        var components = URLComponents(string: endpoint)!
        components.queryItems = [
            URLQueryItem(name:"item_id",value: payloadData),
              
           ]
 
        guard let url = components.url else {throw APIError.invalidURL}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data,response) = try await URLSession.shared.data(for: request)
        print(response,"check data and response")
        guard let response = response as? HTTPURLResponse,response.statusCode == 200 else{
            throw APIError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
        
           
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(similarProducts.self,from:data)
            
    }
        catch let error {
            print("An unexpected error occurred:  \(error.localizedDescription)---- \(error)")
            throw APIError.invalidData
        }
        
    }
    
    func fetchPhotos(payloadData:String) async throws -> googleSearchEngine {
        let endpoint = "\(serverBaseUrl)searchEngine"
        var components = URLComponents(string: endpoint)!
        components.queryItems = [
            URLQueryItem(name:"q",value: payloadData),
              
           ]
 
        guard let url = components.url else {throw APIError.invalidURL}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data,response) = try await URLSession.shared.data(for: request)
        print(data,response,"check data and response")
        guard let response = response as? HTTPURLResponse,response.statusCode == 200 else{
            throw APIError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
        
           
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(googleSearchEngine.self,from:data)
            
    }
        catch let error {
            print("An unexpected error occurred:  \(error.localizedDescription)---- \(error)")
            throw APIError.invalidData
        }
        
    }
}



struct AutoScroller: View {
    var imageNames: [String]
  
 
    
    // Step 3: Manage Selected Image Index
    @State private var selectedImageIndex: Int = 0
  
    var body: some View {
        ZStack {
            // Step 4: Background Color
            

            // Step 5: Create TabView for Carousel
            TabView(selection: $selectedImageIndex) {
                // Step 6: Iterate Through Images
                ForEach(0..<imageNames.count, id: \.self) { index in
                    let url = URL(string: imageNames[index])
                    ZStack(alignment: .topLeading) {
                        // Step 7: Display Image
                        if url == URL(string: imageNames[index]){
                               // Use AsyncImage to load image asynchronously from the URL
                            AsyncImage(url:  URL(string: imageNames[index]) ) { phase in
                                   switch phase {
                                   case .success(let image):
                                       // On successful load, display the image
                                       image
                                           .resizable()
                                           .aspectRatio(contentMode: .fit)
//                                           .tabViewStyle(PageTabViewStyle())
//                                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                                           .frame(width: 150) // Adjust size as needed
                                   case .failure(_):
                                       // Show placeholder or error message
                                       Text("Failed to load the image")
                                   case .empty:
                                       // Show placeholder or loading indicator
                                       ProgressView().progressViewStyle(CircularProgressViewStyle()).id(UUID()).foregroundColor(Color.secondary)
                                   @unknown default:
                                       EmptyView()
                                   }
                               }
                           } else {
                               Text("Invalid URL")
                           }
                    }

                }
            }
            .frame(height: 250)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea()
            .edgesIgnoringSafeArea(.all)
            

            // Step 12: Navigation Dots
            HStack {
                ForEach(0..<imageNames.count, id: \.self) { index in
                    // Step 13: Create Navigation Dots
                    Circle()
                        .fill(Color.black.opacity(selectedImageIndex == index ? 1 : 0.33))
                        .frame(width: 7, height: 8)
                        .onTapGesture {
                            // Step 14: Handle Navigation Dot Taps
                            selectedImageIndex = index
                        }
                }
                .offset( y: 120) // Step 15: Adjust Dots Position
            }
        
        }
        
//        .onReceive(timer) { _ in
//            // Step 16: Auto-Scrolling Logic
//            withAnimation(.default) {
//                selectedImageIndex = (selectedImageIndex + 1) % imageNames.count
//            }
//        }
    }
}

func truncateTextIfNeeded(text:String) -> String {
        if text.count > 35 {
            let endIndex = text.index(text.startIndex, offsetBy: 35)
            let substring = text[text.startIndex..<endIndex]

            if let lastWhiteSpace = substring.range(of: "\\s[\\S]*$", options: .regularExpression, range: nil, locale: nil) {
                let trimmedSubstring = substring.prefix(upTo: lastWhiteSpace.lowerBound)
                return "\(trimmedSubstring)..."
            } else {
                return "\(substring)..."
            }
        }
        return text
    }
   
func get_images(images:[String])
{
    print(images,"check-images")
}
enum APIError :Error{
    case invalidURL
    case invalidResponse
    case invalidData
}



#Preview {
    ContentView()
    
}
