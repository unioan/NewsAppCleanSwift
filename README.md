# Intro

The application allows users to get the top latest news sorted by categories and search the news of interest by making a query. 
When a row with a particular news has been tapped the app loads a web page with the news in the browser.
A user can save news by swiping the row towards the left side of the screen. Saved news are available to a user on the separate “Saved news” screen. 
Saved news are appointed to sections with the respective date of save and can be removed from saved if a user decides so. 

![DemoNewsApp](https://user-images.githubusercontent.com/76248402/176926999-55a349d3-cd27-4dfb-b467-f530190b4486.gif)

## Architecture
The project implements **CleanSwift** architecture and consist of 4 scenes:
- Sign in scene;
- Sign up scene;
- Profile scene;
- Saved news scene;

Each scene comprises a view, viewController, interactor, presenter, and model. Those classes create a specific data flow known as VIP. View Controller is responsible for updating UI and holds a weak reference to an interactor. Interactor processes business logic and holds a weak reference to a presenter. The presenter prepares data received from the interactor to be displayed in a viewController. 
 
Navigation between different scenes is carried out through the **Coordinator** pattern. The pattern allows to encapsulate navigation logic in separate the class making it easy to create, configure and navigate to the next scene. 

Networking and password management are implemented using Singleton. UserDefaults is used to persist user accounts in the device memory.

## Layout
All view classes make heavy use of StackViews. Those stacks are initialized using an anonymous function making stacks neatly organized and easily constrained in the separate function lately.
This is how NewsCell uses anonymous function to create cellStack:

```swift
    private lazy var cellStack: UIStackView = {
        let textStack = UIStackView(arrangedSubviews: [newsTitleLabel, newsDescriptionView])
        textStack.axis = .vertical
        textStack.spacing = 2
        newsTitleLabel.setContentHuggingPriority(.required, for: .vertical)
        newsDescriptionView.setContentHuggingPriority(.required, for: .vertical)
        
        let stack = UIStackView(arrangedSubviews: [newsImageView, textStack, chevronImageView])
        stack.axis = .horizontal
        stack.spacing = 5
        newsImageView.setContentHuggingPriority(.required, for: .vertical)
        textStack.setContentHuggingPriority(.required, for: .vertical)
        return stack
    }()
```

Then we can use cellStack in functions that responsible for setting up views and constraints.  

```swift
private func setViews() {
    cardView.addSubViewsAndTamicOff([cellStack])
}

private func setConstrains() {
    NSLayoutConstraint.activate([cellStack.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 5),
                                 cellStack.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
                                 cellStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
                                 cellStack.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -5)])
}
```

# Scenes
## Sign up & Log in scenes
To use the application user needs to create an account. The process begins when the "sign up" button is pressed. After that user ends up on a sign up sceen where data for user's account is to be provided. When necessary data has been provided and the "submit" button pressed log in screen comes back. 

![SignUpDemo](https://user-images.githubusercontent.com/76248402/177310066-9b9da66c-cdb3-4434-be38-92cf25d62047.gif)

Log in scene checks if a user has entered the correct login and password. If there is a mistake in one of them the application will show the respective alert. When correct credentials have been provided user is taken to the profile screen where account details are displayed along with the top general news.

![LogInDemo](https://user-images.githubusercontent.com/76248402/177337468-d18d80aa-39b5-4317-b651-48d5b82b6721.gif)

## Profile scene 
The screen consists of three main parts. The first one is user data which is displayed right under the navigation bar. The second one is a collection view containing a news categories bar and search bar to look for news globaly. The last one is table view which is responsible for showing news for chosen category or news found through global search. 

![ProfileViewScheme](https://user-images.githubusercontent.com/76248402/177387276-7d17fdd7-e7d5-410e-bc17-1f1cf46a43ee.jpeg)

### News categories & search bar
When a particular category is selected it changes its appearane and scrolled to be in the center of the screen. When user decides to search news by query, news categories bar becomes deactivated until user taps "cancel" button in the search bar. 

![News categories and Search bar](https://user-images.githubusercontent.com/76248402/177397926-5160a2b4-b794-4079-bbe6-dd2119d4c909.gif)

### Fetching news from the web
Class NewsService handles all logic related to fetching news. The class can be configured to fetch news by category or query. 
There are private isSearchingMode property and configureSearchingMode(_ query: String?, for category: SearchArticlesCategoryType?) method that help the class to switch between those two searching modes. If data is provided for the function's query parameter the class uses URL for query mode. If there is none, it uses URL to fetch news for the selected category. 

```swift 
    final class NewsService {
        
    private var isSearchingMode = false
    
        private func configureSearchingMode(_ query: String?, for category: SearchArticlesCategoryType?) {
        if let query = query {
            isSearchingMode = true
            pageNumber += 1
            self.query = query
        }
        if let category = category {
            isSearchingMode = false
            pageNumber += 1
            self.query = ""
            searchArticlesCategory = category
        }
    }
```

Then fetchNewsModels(compleation: @escaping ([Article]) -> Void) function is called. It assembles URL, uses it to fetch JSON data and then decode it to swift's data model. 

```swift 
 private func fetchNewsModels(compleation: @escaping ([Article]) -> Void) {
        var url: URL!
        
        if isSearchingMode {
            guard let queryUrl = URL(string: link + String(pageNumber) + "&q=" + query + apiKey) else { return }
            url = queryUrl
        } else {
            guard let categoryUrl = URL(string: link + String(pageNumber) + searchArticlesCategory.apiCategoryRequest + apiKey) else { return }
            url = categoryUrl
        }
        
        session.dataTask(with: url) { [weak self] data, _ , _ in
            guard let data = data,
                  let newsModel = try? self?.decoder.decode(NewsModel.self, from: data) else { return }
            compleation(newsModel.articles)
        }.resume()
    }
```

### Internet connection check
The application monitors if a device is connected to the internet. If the connection is lost it will let user know about the problem. 

![NoInternetDemo](https://user-images.githubusercontent.com/76248402/177763408-c35ceb4e-e284-4b67-8917-a587db2cbec9.gif)
