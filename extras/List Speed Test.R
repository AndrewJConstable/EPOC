runTest <- function(iter=1000, size=50) {
	
	if (size > 50) size = 50		# max size of named list below
	cat(iter,"iterations over a list size of",size,"\n")
	# list index
	lst1 <- c(1:50)
	s1 <- sample(lst1, size, replace=F)
	st <- as.numeric(Sys.time())
	for (i in 1:iter) {
		for(j in 1:size) {
			a <- lst1[[s1[[j]]]]
		}
	}
	en <- as.numeric(Sys.time())
	cat("Index (secs): ",en - st,"\n")
	
	# named list
	lst2 <- c("a1"=1,
			  "a2"=1,
			  "a3"=1,
			  "a4"=1,
			  "a5"=1,
			  "a6"=1,
			  "a7"=1,
			  "a8"=1,
			  "a9"=1,
			  "a10"=1,
			  "a11"=1,
			  "a12"=1,
			  "a13"=1,
			  "a14"=1,
			  "a15"=1,
			  "a16"=1,
			  "a17"=1,
			  "a18"=1,
			  "a19"=1,
			  "a20"=1,
			  "a21"=1,
			  "a22"=1,
			  "a23"=1,
			  "a24"=1,
			  "a25"=1,
			  "a26"=1,
			  "a27"=1,
			  "a28"=1,
			  "a29"=1,
			  "a30"=1,
			  "a31"=1,
			  "a32"=1,
			  "a33"=1,
			  "a34"=1,
			  "a35"=1,
			  "a36"=1,
			  "a37"=1,
			  "a38"=1,
			  "a39"=1,
			  "a40"=1,
			  "a41"=1,
			  "a42"=1,
			  "a43"=1,
			  "a44"=1,
			  "a45"=1,
			  "a46"=1,
			  "a47"=1,
			  "a48"=1,
			  "a49"=1,
			  "a50"=1
			  )
	s2 <- sample(names(lst2), size, replace=F)
	st <- as.numeric(Sys.time())
	for (i in 1:iter) {
		for(j in 1:size) {
			a <- lst2[[s2[[j]]]]
		}
	}
	en <- as.numeric(Sys.time())
	cat("Named (secs): ",en - st,"\n")
}


