//
//  ContentView.swift
//  Karlaban
//
//  Created by Sekarwulan on 19/05/23.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @State var isEditing1 = false
    @State var isEditing2 = false
    @State var isActive = false
    @State var currentLocation: String = ""
    @StateObject var locationManager: LocationManager = .init()
    @State var getDate = Date.now
        @State private var chosenLocation: CLLocation?
        @State private var distance: CLLocationDistance?
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                Divider()
                    .hidden()
                Image("Ribbit2")
                    .padding(.vertical, 30)
                ZStack {
                    VStack(alignment: .leading){
                        
                        Text("Ribbit!")
                            .bold()
                            .font(.title2)
                            .padding(8)
                            .background(Color("Sage"))
                            .cornerRadius(30)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Where would you like to go today?")
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(1)
                        
//                        HStack{
////                            Button {
////
////                            } label: {
////                                Label {
////                                    Text("From Current Location")
////                                } icon: {
////                                    Image(systemName: "location.north.circle.fill")
////                                }
////                                .foregroundColor(.blue)
////                                .frame(maxWidth: .infinity, alignment: .center)
////
////                        }
//                        }
                        HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                            TextField("Current Location", text: $currentLocation)
                                    //Search Field
                                    if isEditing1 {
                                        Button(action: {
                                            self.isEditing1 = false
                                            self.currentLocation = ""
                         
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.gray)
                                            
                                        }
                                        .animation(.easeInOut, value: !isEditing1)
                                    }
                                }
                                .padding(8)
                                .background(Color(.systemGray6))
                                .cornerRadius(13)
                                .onTapGesture {
                                    self.isEditing1 = true
                                }
                                .animation(.easeInOut, value: isEditing1)
                        HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                            TextField("Where to?", text: $locationManager.searchText)
                                    //Search Field Animation
                                    if isEditing2 {
                                        Button(action: {
                                            self.isEditing2 = false
                                            self.locationManager.searchText = ""
                         
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.gray)
                                            
                                        }
                                        .animation(.easeInOut, value: !isEditing2)
                                    }
                                }
                                .padding(8)
                                .background(Color(.systemGray6))
                                .cornerRadius(13)
                                .onTapGesture {
                                    self.isEditing2 = true
                                }
                                .animation(.easeInOut, value: isEditing2)
                        //LIST TEMPAT
                        if let places = locationManager.fetchedPlaces, !places.isEmpty{
                            List{
                                ForEach(places,id: \.self){place in
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(place.name ?? "")
                                            .font(.title3.bold())
                                        Text(place.locality ?? "")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .listStyle(.plain)
                        }
                        HStack{
                            DatePicker("Set your arrival time", selection: $getDate, displayedComponents: .hourAndMinute)
                            
                        }
                        Spacer()
                        
                    }
                    .padding(20)
                    .frame(width:336,height:300)
                    .background(.white)
                    .cornerRadius(30)
                    .shadow(radius:8)
                
                    HStack {
                        NavigationLink(destination: ReminderView(currentLocation: $currentLocation, locationManager: $locationManager.searchText, getDate: $getDate, duration: 15, chosenActivity: "Dry Hair")){
                            Image(systemName: "chevron.right")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(20)
                                .background(Color("Sage"))
                                .cornerRadius(50)
                                                        }
                    }
                    .offset(y: 150)

                }
            }
            .padding(.bottom, 20)
            
            .background(Color("Background"))
            
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .background(.yellow)
    }
}
