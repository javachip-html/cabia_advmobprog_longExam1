# CCITBook

## Architecture and Data Flow

The application follows a models-services-screens flow:

```text
DummyJSON API
     |
     v
Services (HTTP and persistence)
     |
     v
Models (typed application data)
     |
     v
Screens and widgets (loading, error, and interaction state)
     ^
     |
shared_preferences session and theme values
```

### Models: `lib/models/`

- `user.dart` defines authenticated user data and provides `fromJson` and `toJson` serialization.
- `post.dart` defines post data, including author ID, title, body, reactions, views, and optional media, with `fromJson` and `toJson`.
- `comment.dart` defines comments and their authors, with `fromJson` and `toJson`.

Models keep API JSON conversion out of the UI layer and provide typed data to screens and reusable widgets.

### Services: `lib/services/`

- `user_service.dart` authenticates with `POST https://dummyjson.com/auth/login`, saves the signed-in user in `shared_preferences`, restores it on startup, and clears it on sign out.
- `post_service.dart` loads the feed from `GET https://dummyjson.com/posts` and profile posts from `GET https://dummyjson.com/posts/user/{userID}`.
- `comment_service.dart` loads post comments from `GET https://dummyjson.com/comments/post/{postId}` and submits comments with `POST https://dummyjson.com/comments/add`.

Services perform asynchronous HTTP requests, validate response status codes, decode JSON, and return model objects.

### Screens and Providers: `lib/screens/` and `lib/providers/`

- `splash_screen.dart` checks the saved session and routes to either `HomeScreen` or `SignInScreen`.
- `signin_screen.dart` validates credentials and starts the authenticated session.
- `newsfeed_screen.dart` loads and displays API posts.
- `profile_screen.dart` restores the authenticated user, loads posts filtered by that user's ID, and opens settings.
- `detail_screen.dart` displays a post, increments likes interactively, loads all comments, and submits new comments.
- `settings_screen.dart` persists the dark-mode preference and provides a functional Sign Out action.
- `theme_provider.dart` exposes the shared theme state used by `MaterialApp` and settings.

