//
//  ClimateSchedule.swift
//  IntelliNest
//
//  Created by Tobias on 2022-02-09.
//

import SwiftUI

struct EniroClimateScheduleView: View {
    @ObservedObject var viewModel: EniroClimateScheduleViewModel

    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 100)
                VStack {
                    Text("Anpassningsbara").font(.title3).padding(.top)
                    EniroClimateSchedulePickerView(title: "Klimat1", displayComponents: .hourAndMinute,
                                                   climate: $viewModel.climate1,
                                                   climateBool: $viewModel.climate1Bool,
                                                   updateToggle: viewModel.updateToggle,
                                                   setClimateScheduleDate: viewModel.setClimateSchedule)
                    EniroClimateSchedulePickerView(title: "Klimat2", displayComponents: .hourAndMinute,
                                                   climate: $viewModel.climate2,
                                                   climateBool: $viewModel.climate2Bool,
                                                   updateToggle: viewModel.updateToggle,
                                                   setClimateScheduleDate: viewModel.setClimateSchedule)
                    EniroClimateSchedulePickerView(title: "Klimat3", displayComponents: [.date, .hourAndMinute],
                                                   climate: $viewModel.climate3,
                                                   climateBool: $viewModel.climate3Bool,
                                                   updateToggle: viewModel.updateToggle,
                                                   setClimateScheduleDate: viewModel.setClimateSchedule)
                }
                .background(topGrayColor).cornerRadius(dashboardButtonCornerRadius)
                .padding()

                VStack {
                    Text("Automatiseringar")
                        .font(.title3)
                        .padding(.top)
                    ClimateAutomationsView(title: "Morgon",
                                           time: viewModel.climateMorning.date,
                                           climateBool: $viewModel.climateMorningBool,
                                           updateToggle: viewModel.updateToggle)
                    ClimateAutomationsView(title: "Axis",
                                           time: viewModel.climateDay.date,
                                           climateBool: $viewModel.climateDayBool,
                                           updateToggle: viewModel.updateToggle)
                }
                .padding()
                Spacer()
            }
        }
        .onAppear {
            viewModel.appearedAction(.eniroClimateSchedule)
        }
    }
}

struct EniroClimateSchedule_Previews: PreviewProvider {
    static var previews: some View {
        EniroClimateScheduleView(viewModel: EniroClimateScheduleViewModel(apiService: HassApiService(urlCreator: URLCreator()),
                                                                          appearedAction: { _ in }))
    }
}

struct ClimateAutomationsView: View {
    let title: String
    let time: Date
    @Binding var climateBool: Entity
    let updateToggle: AsyncEntityClosure
    var spaces: String {
        var tempSpaces = ""
        for _ in 0 ..< max(2, 10 - title.count) {
            tempSpaces += " "
        }
        return tempSpaces
    }

    init(title: String, time: Date, climateBool: Binding<Entity>, updateToggle: @escaping AsyncEntityClosure) {
        self.title = title
        self.time = time
        self._climateBool = climateBool
        self.updateToggle = updateToggle
    }

    var body: some View {
        HStack {
            Text("\(title)\(spaces)\(time, style: .time)")
            Toggle("", isOn: $climateBool.isActive)
                .onChange(of: climateBool.isActive, perform: { _ in
                    Task {
                        await updateToggle(climateBool)
                    }
                })
        }
        .padding([.horizontal, .bottom], 8)
    }
}
