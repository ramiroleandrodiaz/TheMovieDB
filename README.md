# TheMovieDB

## Project
This project is an application that shows tv shows, details and you can subscribe them to remind you what you need to watch. This was mainly made as a challenge, following some zeplin project (not complete). API used was TDMB (developer.themoviedb.org) and the main purpose of this app is to showcase some iOS skills, patterns, error handling, code legilibility, etc.

## Decisions Made

**API**

For the API calling, I didn't use either URLSession (the native framework) nor the proposed wrapped in TMDB. I wanted to showcase that I know how to handle API Calls myself, and the reason I went with AlamoFire is that I wanted to showcase that I can use Pods as well (and set up a pods project). Later on, I ended up using more pods, so I could've used URLSession but I already went with AlamoFire.

**Other Pods**

I chose to use as well _SVPullToRefresh_ and _SDWebImage_. _SVPullToRefresh_ is a pod that I used to easily handle infinite scrolling in tableviews (to get paginated tv shows). _SDWebImage_ is to easily handle downloading images, as this framework is bulletproof and also provides a smart and transparent caching automatically.

**Shows vs Movies**

The Prompt of the challenge said that I should display a list of shows/movies and genres. I couldn't do both of them, as these are paginated endpoints, so handling 2 paginated endpoints at the same time would be a mess. In order to keep compliance to the zeplin project I chose shows and shows only.

**Assumptions**

As TV Shows (and movies) doesn't a have a single genre, neither the gender name we need to do some extra work. First of all, as a show or a movie have an array of genres (_[genre_id]_) we are supposing that the first genre in the array is the main genre to display in the show/movie card. Also, when we first fetch the shows/movies we pre-fetch the genres in order to later display its names in the cards. When the genres are fetched, this data is mapped into a dictionary of genres in order to efficiently get the genre name using the genreID as the key.

**Localization**

I didn't use localized strings, as for this project does not seem to add much value, but it is important to tell that the strings that I used in _ShowsConstants.swift_ would be better if it were localized strings _(future work maybe?)_. 

**Future Work**

- Add Localized Strings
- Add a First screen to select Shows or Movies and change endpoint depending on selection
- Maybe add login in the first screen as use watchlist endpoint instead of "locally" subscribing to shows.
