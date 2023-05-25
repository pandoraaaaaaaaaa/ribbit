//
//  ReminderView.swift
//  Karlaban
//
//  Created by Sekarwulan on 20/05/23.
//

import SwiftUI

struct ReminderView: View {
    @Binding var currentLocation: String
    @Binding var locationManager: String
    @Binding var getDate: Date
    @State var duration: Int = 15
    @State var chosenActivity: String = "Dry Hair"
    @State var isActive = false
    
    var body: some View {
        VStack{
            Divider()
                .hidden()
            HStack{
                Image(systemName: "location.fill")
                Text("\(currentLocation)")
                    .font(.system(size: 18, weight: .semibold))
                    .padding()
                }
            .frame(width: 329, height: 57)
            .background(.white)
            .cornerRadius(30)
            .shadow(radius: 4)
            Divider()
                .hidden()
            HStack{
                Image(systemName: "mappin")
                Text("\(locationManager)")
                    .font(.system(size: 18, weight: .semibold))
                    .padding()
            }
            .frame(width: 329, height: 57)
            .background(Color("Sage"))
            .cornerRadius(30)
            .shadow(radius: 4)

            HStack{
                Text("5.5 km")
                    .font(.system(size: 30, weight: .bold))
    
            }
            .padding(.horizontal, 45)
            .frame(maxWidth: .infinity, alignment: .leading)
            ScrollView(.horizontal){
                HStack{
                    HStack{
                        Image(systemName: "figure.walk")
                            .font(.system(size: 20))
                        Text("Walk")
                            .font(.system(size: 20, weight: .semibold))
                    }
                    .frame(width: 124, height: 40)
                    .background(.white)
                    .cornerRadius(10)
                    HStack{
                        Image(systemName: "car")
                            .font(.system(size: 20))
                        Text("Drive")
                            .font(.system(size: 20, weight: .semibold))
                    }
                    .frame(width: 124, height: 40)
                    .background(.white)
                    .cornerRadius(10)
                    HStack{
                        Image("bike")
                            .font(.system(size: 20))
                        Text("Ride")
                            .font(.system(size: 20, weight: .semibold))
                    }
                    .frame(width: 124, height: 40)
                    .background(.white)
                    .cornerRadius(10)

                }
                .padding(.leading, 30)
            }
            .padding(.bottom, 20)
            VStack{
                Text("Don't forget to prepare, ribbit.")
                    .font(.system(size: 17, weight: .semibold))
                    .padding(.bottom, 20)
                HStack{
                    Text("Activity")
                        .font(.system(size: 17, weight: .semibold))
                    Spacer()
                    Menu {
                        ForEach(["Bath", "Dry Hair", "Eat", "Game", "Nangis"], id: \.self){ activity in
                            Button {
                               chosenActivity = activity
                            } label: {
                                Text("\(activity)")
                            }
                        }
                    } label: {
                        Text("\(chosenActivity)")
                        Image(systemName: "chevron.down")
                    }
                    .foregroundColor(.black)
                    
                }
                .padding(.horizontal)
                Rectangle()
                    .frame(width: 280, height: 3)
                HStack{
                    Text("Duration")
                        .font(.system(size: 17, weight: .semibold))
                    Stepper(duration == 0 ? "Off" : "\(duration) min", value: $duration, in: 0...60, step: 1)
                                        .frame(width: 200)
                }
                Rectangle()
                    .frame(width: 280, height: 3)
                Spacer()
                Text("Leave the house by 8:00 AM")
                    .font(.system(size:20, weight: .bold))
            }
            .padding(16)
            .frame(width: 336, height: 264)
            .background(.white)
            .cornerRadius(30)
            .shadow(radius: 8)
            Spacer()
            Text("Add Reminder")
                .font(.system(size:20, weight: .semibold))
                .padding(20)
                .background(Color("Sage"))
                .cornerRadius(30)
            
           
            Spacer()
                
                
            }
            .padding(.vertical, 20)
            .background(Color("Background"))
        }
    }
    
    struct ReminderView_Previews: PreviewProvider {
        @State static var getDate = Date.now
        
        static var previews: some View {
            ReminderView(currentLocation: .constant("Taman Raya, Citra Raya"), locationManager: .constant("Apple Developer Academy"), getDate: $getDate, duration: 15, chosenActivity: "Dry Hair")
        }
    }
