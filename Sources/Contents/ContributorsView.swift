import DesignSystem
import DependencyInjectionUtils
import Kingfisher
import SwiftUI

struct ContributorsView: View {
    @StateObject private var vm = ContributorsViewModel()
    
    private let columns = [GridItem(.adaptive(minimum: 250, maximum: 800), spacing: Spacing.xl.rawValue)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: Spacing.xl.rawValue) {
                ForEach(vm.contributors) {
                    ItemView(contributor: $0)
                }
            }
            .padding(.top, .xl)
            .padding(.horizontal, .lg)
            .padding(.bottom, .xxl)
        }
        .environmentObject(vm)
    }
}

private struct ItemView: View {
    let contributor: Contributor
    
    var body: some View {
        VStack {
            HStack(spacing: .md) {
                ProfilePic(url: contributor.avatarUrl)
                VStack(spacing: .xs) {
                    Text(contributor.name).font(.title2.bold()).textAlign(.leading)
                    RolesView(roles: contributor.roles)
                }
                Spacer()
            }
            PetsView(pets: contributor.pets ?? [])
            Spacer()
        }
        .onTapGesture {
            if let url = URL(string: contributor.link ?? "") {
                NSWorkspace.shared.open(url)
            }
        }
    }
}

private struct PetsView: View {
    let pets: [String]
    
    private let columns = [GridItem(.adaptive(minimum: 32, maximum: 200), spacing: Spacing.xs.rawValue)]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: Spacing.sm.rawValue) {
            ForEach(pets, id: \.self) {
                PetThumbnail(species: $0)
            }
            Spacer()
        }
    }
}

private struct RolesView: View {
    let roles: [Role]
    
    var body: some View {
        HStack(spacing: .sm) {
            ForEach(roles, id: \.self) {
                RoleView(role: $0)
            }
            Spacer()
        }
    }
}

private struct PetThumbnail: View {
    @EnvironmentObject var vm: ContributorsViewModel
    
    let species: String
    
    var body: some View {
        if let asset = vm.thumbnail(for: species) {
            Image(nsImage: asset)
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
        }
    }
}

private struct ProfilePic: View {
    let url: URL?
    
    var body: some View {
        KFImage
            .url(url)
            .placeholder(placeholder)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 56, height: 56)
            .background(Color.white.opacity(0.4))
            .cornerRadius(28)
    }
    
    @ViewBuilder func placeholder(_: Progress) -> some View {
        Image(systemName: "questionmark")
            .font(.title)
            .foregroundColor(.black.opacity(0.8))
    }
}

private struct RoleView: View {
    let role: Role
    
    private var background: Color {
        role.isHightlighted ? .accent : .white.opacity(0.8)
    }
    
    private var foreground: Color {
        role.isHightlighted ? .white : .black.opacity(0.8)
    }
    
    var body: some View {
        Text(role.description)
            .font(.caption.bold())
            .padding(.horizontal, .sm)
            .frame(height: 20)
            .foregroundColor(foreground)
            .background(background)
            .cornerRadius(10)
    }
}

private class ContributorsViewModel: ObservableObject {
    @Inject private var assets: PetsAssetsProvider
    
    var contributors: [Contributor] { Contributors.all }
    
    func thumbnail(for species: String) -> NSImage? {
        assets.image(sprite: "\(species)_front-1")
    }
}

private extension Contributor {
    var profileUrl: URL? { URL(string: link ?? "") }
    var avatarUrl: URL? { URL(string: thumbnail ?? "") }
}

extension Contributor: Identifiable {
    var id: String { name }
}
