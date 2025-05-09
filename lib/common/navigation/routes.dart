/// Generic class to define all the app routes as
/// static instances
class Routes {
  static const signin = "/signin";
  static const signup = "$signin/signup";
  static const _onboarding = "/_onboarding";
  static const candidateOnboarding = "$_onboarding/candidate";
  static const recruiterOnboarding = "$_onboarding/recruiter";
  static const dashboard = "/dashboard";
  static const jobPost = "/job-post";
  static const jobListing = "/job-listing";
  static const splash = "/splash";
}
