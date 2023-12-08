# counter

#Comments

**One label that shows the current timer value** 
Shows in mm:ss format
**Two buttons that can be clicked to start/pause and stop the timer**
The stop button disables itself wherever applicable.
**The View shows an animated ring around the text reflecting the time left the buttons reflect the current state of the timer**
A nice gradient circle that animates back after completion.
**The timer feature should be unaffected by putting the app in the background for any period of time**
Reliance on timer for UI updates only, and maintaining a previous time variable avoids any nuances of background running task etc.
**The ViewModel should use Combine or Swift Concurrency for the implementation of the logic**
The `HomeViewModel` is an `ObservableObject` and exposes `@Published` variables that are responsible for updating the UI.   
**The ViewModel should be created with dependency injection**
The `HomeViewModel` is injected in the root using vanilla constructor dependency injection. However, `HomeViewModel` being a protocol, any mock `HomeViewModel`s can be injected via here. 
**The app should show a system notification when the timer ends while the app is in the background**
Done
