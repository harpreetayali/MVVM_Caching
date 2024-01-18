//
//  UserDetail.swift
//  AssignmentZapbuild
//
//  Created by Harpreet Singh on 16/01/24.
//

import SwiftUI

struct UserDetail: View {
    private var userId:Int
    @ObservedObject var viewModel:UserDetailViewModel
    
    init(userId: Int) {
        self.userId = userId
        self.viewModel = UserDetailViewModel(userId:userId,
                                             repository: UserDetailRepository(
                                                usersService: UserDetailService(),
                                                usersOfflineService: UserDetailOfflineService(
                                                    persistentContainer: PersistenceController.shared.container)))
    }
    
    var body: some View {
        ZStack{
            Form{
                Section{
                    SectionRow(title: "Username", value: viewModel.user?.username ?? "")
                    SectionRow(title: "Name", value: viewModel.user?.name ?? "")
                    SectionRow(title: "Email", value: viewModel.user?.email ?? "")
                    
                } header: {
                    Text("Personal Information")
                }
                if let company = viewModel.user?.company{
                    Section{
                        SectionRow(title: "Name", value: company.name ?? "")
                        SectionRow(title: "About", value: company.catchPhrase ?? "")
                    } header: {
                        Text("Company Information")
                    }
                }
            }
            
            if viewModel.isLoading{
                LoadingView()
            }
        }.toolbar{
            ToolbarItem(placement: .principal) {
                Text("User Detail")
            }
        }
    }
}

#Preview {
    UserDetail(userId: 1)
}

struct SectionRow: View {
    let title:String
    let value:String
    var body: some View {
        HStack{
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
        }
    }
}
