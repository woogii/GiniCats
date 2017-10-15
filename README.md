# GiniCats

This is a simple demo application that shows a list of cats. The list displays information such as a cat's image, an image ID and a favorite button. If users tap a favorite button below the cat image, the cat image is saved on the application. 
The app has a slide-out side menu that can be seen when users swipe the screen to the right or tap the icon on the top left corner. The slide-out menu contains a single menu called 'My Favorite Cats' which displays a list of favorite cat images with image IDs.

## Tasks
* Query Images from [The Cat API](htpp://thecatapi.com)
* Display Cat Images in the UICollectionView
* Enable users to mark favorite cats
* Display favorite cat list
* Cache the images of favorite cats on the device

## How to solve 

* Use a open source library([SWXMLHash](https://github.com/drmohundro/SWXMLHash)) to get a foundation object from XML data and parse the object. 
* Populate cat images on a custom `UICollectionViewCell` via `UICollectionViewDataSource` Methods.
* Use a open source library([SDWebImage](https://github.com/rs/SDWebImage)) to download cat images asynchronously
* Cat images are cached automatically since [SDWebImage](https://github.com/rs/SDWebImage) provides a built-in cache mechanism
* Populate cached favorite cat images on a custom `UITableViewCell` via `UITableViewDataSource` Methods.


## Design decision 

This application follows the MVC (Model-View-Controller) pattern. 

* **Model** Layer - *__CatImageInfo__*, *__FavoriteCatImageInfo__* structs are defined with Initializer and member variables. They store information related to the cat image such as a cat image URL, a image ID, a image source URL, and so on during the initialization process.

* **Controller** Layer - *__CatImageListCollectionViewController__* holds the *__CatImageInfo__* array and the values of the array are assigned after cat image information is downloaded via the API. The array is used as the Datasource of `UICollectionView` to populate the cat image information. 

* *__MenuViewController__* is a subclass of `UITableViewController` and has a static cell segueing to *__FavoriteCatListViewController__*. 
* *__FavoriteCatListViewController__* calls a API request to get favorite cat image information and stores information on the *__FavoriteCatImageInfo__* array. The array is used as the Datasource of `UITableView` to populate the favorite cat image information. 

* **View** Layer - *__CatImageCollectionViewCell__*, *__FavoriteCatImageTableViewCell__* are responsible for displaying cat images and favorite cat images, respectively. Both cells have property observers of *__CatImageInfo__*, *__FavoriteCatImageInfo__* type which trigger the cell's UI updates when those properties are assigned a new value in the Controller layer.


# Open Source Licence

*  [SDWebImage](https://github.com/rs/SDWebImage)
*  [SWXMLHash](https://github.com/drmohundro/SWXMLHash)
*  [SwiftLint](https://github.com/realm/SwiftLint)

## Image Licence 

* [Icons8](https://icons8.com/) 

# How to build 

1) Clone the repository 

```
$ git clone https://github.com/woogii/GiniCats.git
$ cd GiniCats
```
2) Install SwiftLint

```
$ brew install swiftlint
```
3) Set up the third party library 

```
$ pod install
```

4) Open the workspace in XCode 

```
$ open GiniCats.xcworkspace/
```

5) Add your API Key in Constant.swift

```
static let APIValue = "Your API Key"
```
6) Compile and run the app in your simulator or iPhone 

# Compatibility 
The code of this project works in Swift3.0, Xcode 8.3.1 and iOS9 