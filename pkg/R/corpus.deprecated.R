links <- function(targets, lengths, list) {
  if (missing(list) && (missing(targets) || missing(lengths))) {
    stop("Either 'list' or both 'targets' and 'lengths' must be specified.")
  }
  if (!missing(list) && (!missing(targets) || !missing(lengths))) {
    stop("Must not specify 'list' and 'targets'/'lengths'.")
  }

  if (!missing(list)) {
    targets <- unlist(list)
    lengths <- sapply(list, length)
  } else {
    if (length(targets) != sum(lengths)) {
      stop("Length of targets does not match sum of lengths.")
    }
  }

  cc <- new(.module$Links)
  cc$load(targets, lengths)
  return(cc);
}
                  
corpus <- function(words, lengths, documents, V) {
  if (missing(documents) && (missing(words) || missing(lengths))) {
    stop("Either 'documents' or both 'words' and 'lengths' must be specified.")
  }
  if (!missing(documents) && (!missing(words) || !missing(lengths))) {
    stop("Must not specify 'documents' and 'words'/'lengths'.")
  }

  if (!missing(documents)) {
    words <- unlist(lapply(documents, function(x) rep(x[1,], x[2,])))
    lengths <- sapply(documents, function(x) sum(x[2,]))
  } else {
    if (length(words) != sum(lengths)) {
      stop("Length of words does not match sum of lengths.")
    }
  }

  if (missing(V)) {
    V <- max(words) + 1L
  } else {
    if (max(words) >= V) {
      stop("V is too small.")
    }
  }

  cc <- new(.module$Corpus)
  cc$load(words, lengths, V)
  return(cc);
}
