# Intro

## About application
The application allows users to get the top latest news sorted by categories and search the news of interest by making a quivery. 
When a row with a particular news has been tapped the app loads a web page with the news in the browser.
A user can save news by swiping the row towards the left side of the screen. Saved news are available to a user on the separate “Saved news” screen. 
Saved news are appointed to sections with the respective date of save and can be removed from saved if a user decides so. 

![DemoNewsApp](https://user-images.githubusercontent.com/76248402/176926999-55a349d3-cd27-4dfb-b467-f530190b4486.gif)

## Architecture
The project implements CleanSwift a architecture and consist of 4 scenes:
- Sign in scene;
- Sign up scene;
- Profile scene;
- Saved news scene;
Each scene comprises view, viewController, interactor, presenter and model. Those classes create a specific data flow known as VIP. View Controller is responsible for updating UI and holds weak referense to interactor. Interactor process bussiness logic and holds weak referens to presentor. Presentor prepares data recived from interactor to be displayed in viewController. 
 
Navigation between different scenes is carried out through Coordinator pattern. The pattern allows to encapsulate navigation logic in separate class making it easy to create, configure and navigate to the next scene. 

Networking and password management is implemented using Singleton. For data persistance UserDefaults is used. 

## Layout

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
