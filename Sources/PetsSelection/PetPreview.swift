import Combine
import DependencyInjectionUtils
import SwiftUI
import Yage

struct PetPreview: View {
    @EnvironmentObject private var selectionViewModel: PetsSelectionViewModel
    @StateObject private var viewModel: PetPreviewViewModel
    
    let size: CGFloat = 80
    
    init(species: Species) {
        let vm = PetPreviewViewModel(species: species)
        _viewModel = StateObject(wrappedValue: vm)
    }

    var body: some View {
        VStack {
            if let frame = viewModel.previewImage {
                Image(frame: frame)
                    .pixelArt()
                    .frame(width: size, height: size)
            }
            Text(viewModel.title).multilineTextAlignment(.center)
        }
        .frame(width: size)
        .frame(minHeight: size)
        .onTapGesture {
            selectionViewModel.showDetails(of: viewModel.species)
        }
    }
}

private class PetPreviewViewModel: ObservableObject {
    @Inject private var assets: PetsAssetsProvider
    @Inject private var names: SpeciesNamesRepository
    
    let species: Species
    var previewImage: NSImage?
    
    @Published var title = ""
    
    private var disposables = Set<AnyCancellable>()
    
    init(species: Species) {
        self.species = species
        loadImage()
        bindTitle()
    }
    
    func loadImage() {
        let path = assets.frames(for: species.id, animation: "front").first
        previewImage = assets.image(sprite: path)
    }
    
    private func bindTitle() {
        names.name(forSpecies: species.id)
            .sink { [weak self] name in self?.title = name }
            .store(in: &disposables)
    }
}
