enum Role { candidate, recruiter, admin, none }

enum ApiStatus { init, loading, success, failure }

enum ApplicationStatus {
  applied,
  review,
  shortlisted,
  rejected,
  interview,
  hired
}

enum JobStatus { draft, active, closed, filled }

enum JobFilters {
  employmentType,
  experienceLevels,
  jobRoles,
  locations,
  salaryRange,
  skills,
  remote,
  none,
}
