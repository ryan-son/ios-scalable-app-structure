//
//  Animal+CoreData.swift
//  iOSScalableAppStructure
//
//  Created by Geonhee on 2022/08/02.
//

import CoreData

extension AnimalEntity {

  var age: Age {
    get {
      guard let ageValue = ageValue else { return .unknown }
      return Age(rawValue: ageValue) ?? .unknown
    }
    set {
      self.ageValue = newValue.rawValue
    }
  }

  var coat: Coat {
    get {
      guard let coatValue = coatValue else { return .unknown }
      return Coat(rawValue: coatValue) ?? .unknown
    }
    set {
      self.coatValue = newValue.rawValue
    }
  }

  var gender: Gender {
    get {
      guard let genderValue = genderValue else { return .unknown }
      return Gender(rawValue: genderValue) ?? .unknown
    }
    set {
      self.genderValue = newValue.rawValue
    }
  }

  var size: Size {
    get {
      guard let sizeValue = sizeValue else { return .unknown }
      return Size(rawValue: sizeValue) ?? .unknown
    }
    set {
      self.sizeValue = newValue.rawValue
    }
  }

  var status: AdoptionStatus {
    get {
      guard let statusValue = statusValue else { return .unknown }
      return AdoptionStatus(rawValue: statusValue) ?? .unknown
    }
    set {
      self.statusValue = newValue.rawValue
    }
  }

  var breed: String {
    return breeds?.primary ?? breeds?.secondary ?? ""
  }

  var picture: URL? {
    guard let photos = photos,
          photos.allObjects.isNotEmpty else { return nil }
    let photosArray = photos.allObjects as? [PhotoSizesEntity]
    guard let photosArray = photosArray,
          let firstPhoto = photosArray.first else { return nil }
    return firstPhoto.medium ?? firstPhoto.full
  }

  var photoLink: URL? {
    guard let phoneNumber = contact?.phone else { return nil }
    let formattedPhoneNumber = phoneNumber.replacingOccurrences(of: "(", with: "")
      .replacingOccurrences(of: ")", with: "")
      .replacingOccurrences(of: "-", with: "")
      .replacingOccurrences(of: " ", with: "")
    return URL(string: "tel:\(formattedPhoneNumber)")
  }

  var emailLink: URL? {
    guard let emailAddress = contact?.email else { return nil }
    return URL(string: "mailto:\(emailAddress)")
  }

  var address: String {
    guard let address = contact?.address else { return "No address" }
    return [
      address.address1,
      address.address2,
      address.city,
      address.state,
      address.postcode,
      address.country
    ]
      .compactMap { $0 }
      .joined(separator: ", ")
  }

  @objc var animalSpecies: String {
    return species ?? "None"
  }
}

extension Animal: UuidIdentifiable {

  init(managedObject: AnimalEntity) {
    self.age = managedObject.age
    self.coat = managedObject.coat
    self.description = managedObject.desc
    self.distance = managedObject.distance
    self.gender = managedObject.gender
    self.id = Int(managedObject.id)
    self.name = managedObject.name ?? "No name"
    self.organizationId = managedObject.organizationId
    self.publishedAt = managedObject.publishedAt?.description
    self.size = managedObject.size
    self.species = managedObject.species
    self.status = managedObject.status
    self.tags = []
    self.type = managedObject.type ?? "No type"
    self.url = managedObject.url
    self.attributes = AnimalAttributes(managedObject: managedObject.attributes)
    self.colors = ApiColors(managedObject: managedObject.colors)
    self.contact = Contact(managedObject: managedObject.contact)
    self.environment = AnimalEnvironment(managedObject: managedObject.environment)
    let pictures = managedObject.photos?.allObjects as? [PhotoSizesEntity]
    self.photos = pictures?.map(PhotoSizes.init(managedObject:)) ?? []
    let videos = managedObject.videos?.allObjects as? [VideoLinkEntity]
    self.videos = videos?.map(VideoLink.init(managedObject:)) ?? []
    self.breeds = Breed(managedObject: managedObject.breeds)
  }

  private func checkForExistingAnimal(
    id: Int,
    context: NSManagedObjectContext = PersistenceController.shared.container.viewContext
  ) -> Bool {
    let fetchRequest = AnimalEntity.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id = %d", id)

    guard let fetchedResults = try? context.fetch(fetchRequest) else {
      return false
    }
    return fetchedResults.isNotEmpty
  }

  mutating func toManagedObject(
    context: NSManagedObjectContext = PersistenceController.shared.container.viewContext
  ) {
    guard let id = self.id else { return }
    guard checkForExistingAnimal(id: id, context: context) == false else { return }

    let persistedValue = AnimalEntity(context: context)
    persistedValue.timestamp = Date()
    persistedValue.age = self.age
    persistedValue.coat = self.coat ?? .short
    persistedValue.desc = self.description
    persistedValue.distance = self.distance ?? 0
    persistedValue.gender = self.gender
    persistedValue.id = Int64(id)
    persistedValue.name = self.name
    persistedValue.organizationId = self.organizationId
    persistedValue.publishedAt = self.publishedAt
    persistedValue.size = self.size
    persistedValue.species = self.species
    persistedValue.status = self.status
    persistedValue.type = self.type
    persistedValue.url = self.url
    persistedValue.attributes = self.attributes.toManagedObject(context: context)
    persistedValue.colors = self.colors.toManagedObject(context: context)
    persistedValue.contact = self.contact.toManagedObject(context: context)
    persistedValue.environment = self.environment?.toManagedObject(context: context)
    let convertedPhotos = self.photos.map { photo -> PhotoSizesEntity in
      var mutablePhoto = photo
      return mutablePhoto.toManagedObject(context: context)
    }
    persistedValue.addToPhotos(NSSet(array: convertedPhotos))
    let convertedVideos = self.videos.map { video -> VideoLinkEntity in
      var mutableVideo = video
      return mutableVideo.toManagedObject(context: context)
    }
    persistedValue.addToVideos(NSSet(array: convertedVideos))
    persistedValue.breeds = self.breeds.toManagedObject(context: context)
  }
}
