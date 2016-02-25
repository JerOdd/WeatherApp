# WeatherApp

I'll try to show in the weather app project different part of iOS developement. I have designed it with a multi-tier architecture (Data Access Layer, Business Layer, UI and Application layer).

- Data Access Layer : In this part, you can find a "Storage" part where CoreData is used to save, delete, fetch objects in database. You can also find a "Request" part where NSURLSession is used (DataTask and DownloadTask) to download weather data and weather images.
- Business layer : Here is the business logic of the app. Classes inside are all singleton, they decide when to download image, when to reload the app, you'll find a lot of delegate methods inside
- UI and Application layer: All graphic components are in here. You'll find Main.storyboard where there are some auto-layout constraint and where all graphic components are created. Then, you'll see all the ViewControllers with pull to refresh tableView, updating of badge values for example.

There is also a Common part when you can find all basic objects.

How to use the App?

When you start the app, you have to pull to refresh the tableView. Some cities will be displayed. You can click on the city and the detail will appear or refresh (it depends on the device you use). You have some description of the weather. Then you can tap on the "Add to favorites" Button. It will add the city to your favorites.

Greetings to http://openweathermap.org/ for their great free weather API.
