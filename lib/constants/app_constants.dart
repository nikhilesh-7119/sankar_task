class AppConstants {
  // App
  static const appTitle = 'Flutter Demo';

  // External URLs
  static const quoteApiUrl = 'http://api.quotable.io/random';

  // Firestore collections
  static const usersCollection = 'users';
  static const tasksCollection = 'tasks';

  // Firestore / model field keys (shared)
  static const fieldId = 'id';
  static const fieldName = 'name';
  static const fieldEmail = 'email';
  static const fieldPassword = 'password';
  static const fieldTitle = 'title';
  static const fieldDescription = 'description';
  static const fieldLastDateText = 'lastDateText';
  static const fieldCompleted = 'completed';
  static const fieldContent = 'content';
  static const fieldAuthor = 'author';

  // Validation
  static const emailRegex = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';
  static const emailRequired = 'Email required';
  static const invalidEmail = 'Invalid email';
  static const nameRequired = 'Name required';
  static const passwordRequired = 'Password required';

  // Auth / snackbar messages
  static const errorTitle = 'Error';
  static const successful = 'Successful';
  static const errorInFirebase = 'Error in firebase';
  static const errorInLogin = 'Error in login';
  static const userLoggedIn = 'User logged in';
  static const userLoggedOut = 'User logged out';
  static const userCreated = 'User Created';
  static const passwordMismatchTitle = 'Password Mismatch';
  static const passwordMismatchMsg = 'Both passwords are different';

  // Task snackbar messages
  static const errorAddingTaskTitle = 'Error in Adding task';
  static const errorAddingTaskMsg = 'please check your internet';
  static const successTitle = 'Success';
  static const taskUpdated = 'Task Updated';
  static const unableToUpdateTask = 'Unable to update task';
  static const unableToFetchTask = 'Unable to fetch task';
  static const unableToDeleteTask = 'Unable to delete task';
  static const unableToFetchQuote = 'Unable to fetch quote';

  // Default user display
  static const guest = 'Guest';

  // Home screen
  static const homeTitle = 'Home';
  static const tasksHeading = 'Tasks';
  static const noTasksFound = 'No Tasks Found';

  // Task dialog
  static const editTaskTitle = 'Edit Task';
  static const addTaskTitle = 'Add Task';
  static const titleHint = 'Title';
  static const descriptionHint = 'Description';
  static const completedLabel = 'Completed';
  static const cancelLabel = 'Cancel';
  static const updateLabel = 'Update';
  static const addLabel = 'Add';

  // Quote card
  static const motivationalQuoteHeading = 'Motivational Quote';

  // Splash screen
  static const splashTitle = 'TaskManager';
  static const splashPlanner = 'PLANNER';
  static const splashTagline =
      'Your perfect schedule, beautifully\nplanned and effortlessly managed';
  static const getStartedLabel = 'Get Started';
  static const splashFooter = 'Version 1.0 • Made with ♡';

  // Auth screen
  static const welcomeHeading = 'Welcome';
  static const welcomeSubtitle = 'Sign in to plan your dream scheduler';
  static const loginTabLabel = 'Login';
  static const signupTabLabel = 'Sign Up';
  static const firestoreNoticeText = 'Firestore data only. Directly connected.';

  // Sign-in form
  static const signInHeading = 'Sign in to your account';
  static const signInSubheading = 'Enter your email and password to\ncontinue';
  static const emailLabel = 'Email';
  static const passwordLabel = 'Password';
  static const emailHint = 'your@email.com';
  static const passwordHint = '••••••••';
  static const continueLabel = 'Continue';

  // Sign-up form
  static const signUpHeading = 'Create your account';
  static const signUpSubheading =
      'Start planning your perfect\ndaily scheduler with us.';
  static const fullNameLabel = 'Full Name';
  static const fullNameHint = 'Sarah Johnson';
  static const confirmPasswordLabel = 'Confirm Password';
  static const createAccountLabel = 'Create Account';
}
