% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/findJobs.R
\name{findJobs}
\alias{findJobs}
\alias{findExperiments}
\alias{findSubmitted}
\alias{findNotSubmitted}
\alias{findStarted}
\alias{findNotStarted}
\alias{findDone}
\alias{findNotDone}
\alias{findErrors}
\alias{findOnSystem}
\alias{findRunning}
\alias{findQueued}
\alias{findExpired}
\alias{findTagged}
\title{Find and Filter Jobs}
\usage{
findJobs(expr, ids = NULL, reg = getDefaultRegistry())

findExperiments(prob.name = NA_character_, prob.pattern = NA_character_,
  algo.name = NA_character_, algo.pattern = NA_character_, prob.pars,
  algo.pars, repls = NULL, ids = NULL, reg = getDefaultRegistry())

findSubmitted(ids = NULL, reg = getDefaultRegistry())

findNotSubmitted(ids = NULL, reg = getDefaultRegistry())

findStarted(ids = NULL, reg = getDefaultRegistry())

findNotStarted(ids = NULL, reg = getDefaultRegistry())

findDone(ids = NULL, reg = getDefaultRegistry())

findNotDone(ids = NULL, reg = getDefaultRegistry())

findErrors(ids = NULL, reg = getDefaultRegistry())

findOnSystem(ids = NULL, reg = getDefaultRegistry())

findRunning(ids = NULL, reg = getDefaultRegistry())

findQueued(ids = NULL, reg = getDefaultRegistry())

findExpired(ids = NULL, reg = getDefaultRegistry())

findTagged(tags = character(0L), ids = NULL, reg = getDefaultRegistry())
}
\arguments{
\item{expr}{[\code{expression}]\cr
Predicate expression evaluated in the job parameters.
Jobs for which \code{expr} evaluates to \code{TRUE} are returned.}

\item{ids}{[\code{\link[base]{data.frame}} or \code{integer}]\cr
A \code{\link[base]{data.frame}} (or \code{\link[data.table]{data.table}})
with a column named \dQuote{job.id}.
Alternatively, you may also pass a vector of integerish job ids.
If not set, defaults to all jobs.
Invalid ids are ignored.}

\item{reg}{[\code{\link{Registry}}]\cr
Registry. If not explicitly passed, uses the default registry (see \code{\link{setDefaultRegistry}}).}

\item{prob.name}{[\code{character}]\cr
Exact name of the problem (no substring matching).
If not provided, all problems are matched.}

\item{prob.pattern}{[\code{character}]\cr
Regular expression pattern to match problem names.
If not provided, all problems are matched.}

\item{algo.name}{[\code{character}]\cr
Exact name of the problem (no substring matching).
If not provided, all algorithms are matched.}

\item{algo.pattern}{[\code{character}]\cr
Regular expression pattern to match algorithm names.
If not provided, all algorithms are matched.}

\item{prob.pars}{[\code{expression}]\cr
Predicate expression evaluated in the problem parameters.}

\item{algo.pars}{[\code{expression}]\cr
Predicate expression evaluated in the algorithm parameters.}

\item{repls}{[\code{integer}]\cr
Whitelist of replication numbers. If not provided, all replications are matched.}

\item{tags}{[\code{character}]\cr
Return jobs which are tagged with any of the tags provided.}
}
\value{
[\code{\link{data.table}}] with column \dQuote{job.id} containing matched jobs.
}
\description{
These functions are used to find and filter jobs, depending on either their parameters (\code{findJobs} and
\code{findExperiments}), their tags (\code{findTagged}), or their computational status (all other functions).

For a summarizing overview over the status, see \code{\link{getStatus}}.
Note that \code{findOnSystem} and \code{findExpired} are somewhat heuristic and may report misleading results,
depending on the state of the system and the \code{\link{ClusterFunctions}} implementation.
}
\examples{
tmp = makeRegistry(file.dir = NA, make.default = FALSE)
batchMap(identity, i = 1:3, reg = tmp)
ids = findNotSubmitted(reg = tmp)

# get all jobs:
findJobs(reg = tmp)

# filter for jobs with parameter i >= 2
findJobs(i >= 2, reg = tmp)

# filter on the computational status
findSubmitted(reg = tmp)
findNotDone(reg = tmp)

# filter on tags
addJobTags(2:3, "my_tag", reg = tmp)
findTagged(tags = "my_tag", reg = tmp)

# combine filter functions using joins
# -> jobs which are not done and not tagged (using an anti-join):
ajoin(findNotDone(reg = tmp), findTagged("my_tag", reg = tmp))
}
