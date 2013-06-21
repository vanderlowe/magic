require(stringr)
require(openNLP) ## Loads the package for use in the task
require(openNLPmodels.en) ## Loads the model files for the English language

# Which paper are you reading?
citekey <- "mauss2005"

# Load plain text copied from PDF
txt <- paste(readLines("~/Downloads/mauss2005.txt"), collapse = " ")

# Split into sentences
x = sentDetect(txt, language = "en") ## sentDetect() is the function to use. It detects and seperates sentences in a text. The first argument is the string vector (or text) and the second argument is the language.

# Remove hyphenation
x2 <- gsub("-[ \\s\\n]+", "", x)

citations <- x2[str_detect(x2, "\\([^\\)]+?\\d{4}?[^\\)]*?\\)")]

function.template <- "magicCite(from = '%s', 
to = '', 
sentence = '%s', 
section = 'i'
)

"

output <- c()

for (cite in citations) {
  output <- c(output, sprintf(function.template, citekey, cite))
}

writeLines(output, paste(citekey, "R", sep = "."))