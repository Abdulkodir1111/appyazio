//
//  WaterView.swift
//  YazioApp.swift
//
//  Created by Abdulkodir Juraev on 11/11/25.
//

import SwiftUI

struct WaterView: View {
    @State private var totalWater = 0 // ichilgan suv (ml)
    @State private var dailyGoal: Int? = nil // foydalanuvchi kiritgan maqsad
    @State private var showGoalAlert = false
    @State private var goalInput = "" // foydalanuvchi yozadigan qiymat (string)

    var progress: Double {
        if let goal = dailyGoal, goal > 0 {
            return min(Double(totalWater) / Double(goal), 1.0)
        } else {
            return 0
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 25) {
                    Text("Water Tracker")
                        .font(.title)
                        .fontWeight(.bold)

                    // Agar goal yo'q bo'lsa, foydalanuvchidan so'raymiz
                    if dailyGoal == nil {
                        VStack(spacing: 10) {
                            Text("No goal set yet 💧")
                                .font(.headline)
                            Button("Set your daily goal") {
                                showGoalAlert = true
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.blue)
                        }
                    } else {
                        // 🔵 Progress Ring
                        ZStack {
                            Circle()
                                .stroke(Color.blue.opacity(0.2), lineWidth: 20)
                                .frame(width: 180, height: 180)

                            Circle()
                                .trim(from: 0, to: progress)
                                .stroke(Color.blue, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                                .rotationEffect(.degrees(-90))
                                .frame(width: 180, height: 180)
                                .animation(.easeInOut(duration: 0.5), value: progress)

                            VStack {
                                Text("\(Int(progress * 100))%")
                                    .font(.largeTitle)
                                    .bold()
                                Text("\(totalWater) ml / \(dailyGoal ?? 0) ml")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                        }

                        // 💧 Suv qo‘shish tugmalari
                        HStack(spacing: 12) {
                            Button(action: { totalWater += 200 }) {
                                Text("+200 ml")
                                    .bold()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }

                            Button(action: { totalWater += 300 }) {
                                Text("+300 ml")
                                    .bold()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.cyan)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)

                        Spacer()

                        // 🔴 Reset & Edit goal
                        HStack {
                            Button(action: { totalWater = 0 }) {
                                Text("Reset")
                                    .foregroundColor(.red)
                            }
                            Spacer()
                            Button("Edit Goal") {
                                showGoalAlert = true
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    }
                }
                .navigationTitle("Water")
                // 🔔 Goal kiritish uchun alert
                .alert("Set your daily water goal (ml)", isPresented: $showGoalAlert) {
                    TextField("e.g. 2000", text: $goalInput)
                        .keyboardType(.numberPad)
                    Button("Save") {
                        if let value = Int(goalInput), value > 0 {
                            dailyGoal = value
                            totalWater = 0
                        }
                        goalInput = ""
                    }
                    Button("Cancel", role: .cancel) {}
                }
            }
        }
    }
}

struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        WaterView()
    }
}
