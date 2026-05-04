//
//  UserDetailView.swift
//  Plan
//
//  Created by Fede Garcia on 04/05/2026.
//

import SwiftUI

struct UserDetailView: View {
    var user: User
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue, .black] , startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            VStack{
                Text(user.name)
                    .font(.largeTitle.bold())
                    .foregroundStyle(.blue)
                Text(user.email)
                    .font(.title3)
                    .foregroundStyle(.secondary)

                Text(user.phone)
                    .font(.title3.bold())
                    .foregroundStyle(.secondary)

                Text(user.website)
                    .font(.title3.bold())
                    .foregroundStyle(.secondary)

            }
        }
        .navigationTitle(user.username)
        .navigationBarTitleDisplayMode(.inline)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    UserDetailView(user: User(id: 2, name: "Federdsico fede fede feedfe fedefe", username: "Fede", email: "jhagsgs@shdhds.com", address: Address(street: "casa", suite: "10", city: "SM", zipcode: "1663", geo: Geo(lat: "15", lng: "13")), phone: "12344556", website: "jorge.com", company: Company(name: "Apple", catchPhrase: "hola", bs: "no se que es esto")))
}
