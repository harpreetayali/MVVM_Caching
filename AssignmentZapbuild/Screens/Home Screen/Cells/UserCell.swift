//
//  UserCell.swift
//  AssignmentZapbuild
//
//  Created by Harpreet Singh on 16/01/24.
//

import SwiftUI

struct UserCell: View {
    let user:UsersModel
    var onRowTapped:(UsersModel) -> ()
    var body: some View {
        HStack{
            Text(user.name ?? "")
                .font(.subheadline)
                .fontWeight(.semibold)
                .lineLimit(1)
        }
        .padding(5)
        .onTapGesture {
            onRowTapped(user)
        }
    }
}

//#Preview {
//
//    UserCell(user: MockData.userModel){ user in
//    }
//}
