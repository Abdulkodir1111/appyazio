//
//  CaloriesView.swift
//  YazioApp.swift
//
//  Created by Abdulkodir Juraev on 11/11/25.
//

import SwiftUI

struct CaloriesView: View {
    @State private var totalKcal = 0 // iste'mol qilingan kaloriya
    @State private var dailyGoal: Int? = nil // foydalanuvchi kiritgan maqsad
    @State private var showGoalAlert = false
    @State private var goalInput = "" // text field uchun

    var progress: Double {
        if let goal = dailyGoal, goal > 0 {
            return min(Double(totalKcal) / Double(goal), 1.0)
        } else {
            return 0
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange.opacity(0.25), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(spacing: 25) {
                    Text("Calorie Tracker")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)

                    // Agar goal yo'q bo'lsa:
                    if dailyGoal == nil {
                        VStack(spacing: 10) {
                            Text("No goal set yet 🔥")
                                .font(.headline)
                            Button("Set your daily goal") {
                                showGoalAlert = true
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(.orange)
                        }
                    } else {
                        // 🟠 Progress Ring
                        ZStack {
                            Circle()
                                .stroke(Color.orange.opacity(0.2), lineWidth: 20)
                                .frame(width: 180, height: 180)

                            Circle()
                                .trim(from: 0, to: progress)
                                .stroke(Color.orange, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                                .rotationEffect(.degrees(-90))
                                .frame(width: 180, height: 180)
                                .animation(.easeInOut(duration: 0.5), value: progress)

                            VStack {
                                Text("\(Int(progress * 100))%")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.orange)
                                Text("\(totalKcal) kcal / \(dailyGoal ?? 0) kcal")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                        }

                        // 🍔 Qo‘shish tugmalari
                        HStack(spacing: 12) {
                            Button(action: { totalKcal += 100 }) {
                                Text("+100 kcal")
                                    .bold()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.orange)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }

                            Button(action: { totalKcal += 200 }) {
                                Text("+200 kcal")
                                    .bold()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.red.opacity(0.8))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)

                        Spacer()

                        // 🔴 Reset & Edit
                        HStack {
                            Button(action: { totalKcal = 0 }) {
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
                .navigationTitle("Kcal")
                // 🔔 Goal kiritish uchun alert
                .alert("Set your daily calorie goal (kcal)", isPresented: $showGoalAlert) {
                    TextField("e.g. 2500", text: $goalInput)
                        .keyboardType(.numberPad)
                    Button("Save") {
                        if let value = Int(goalInput), value > 0 {
                            dailyGoal = value
                            totalKcal = 0
                        }
                        goalInput = ""
                    }
                    Button("Cancel", role: .cancel) {}
                }
            }
        }
    }
}

struct KcalView_Previews: PreviewProvider {
    static var previews: some View {
        CaloriesView()
    }
}
