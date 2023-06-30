# JobsitySeriesApp
iOS application that lists TV series using the [TVMaze API](https://www.tvmaze.com/api).

To run the app, download this repository and run it on Xcode.

* This project is implemented using MVVM architecture pattern.
* The Model layer contains any necessary data or business logic needed to get all the shows and their information.
* Views are built in SwiftUI, and responsible for displaying all the data to the user.
* View Models handle all the interactions and update the view with the requested information.

Current features:
- [x] List of series
- [x] Search by name
- [x] Serie details
- [x] Episode Details
- [ ] Bookmarked series
- [ ] PIN and FaceID authentication
- [ ] Search by Actor/Actress name


Observations:
* The whole project was developed only using the main branch, git flow was not considered for simplicity purposes.

* Dependency Injection using Swinject was scrapped because some issues with Protocols inheriting ObservableObject came up and the lack of time resulted in this decision.

* In the middle of the development process all data-related functions with completion handlers were migrated to use async/await, a wise decision, resulting in a cleaner and more efficient code. (no need to make sure to call every completion nor issues with retain cycles) You can see the full migration by at the commit history.

* `myString.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)` is a neat short line of code to remove all HTML tags from text.

