require(stringr)
require(openNLP) ## Loads the package for use in the task
require(openNLPmodels.en) ## Loads the model files for the English language

# Which paper are you reading?
citekey <- "mauss2005"

# Load plain text copied from PDF
txt <- paste(readLines("~/Downloads/mauss2005.txt"), collapse = " ")

# TODO: Split into sections
# sections <- strsplit(txt, split="^(INTRODUCTION|(I|i)ntroduction)$")

# Split into sentences
x = sentDetect(txt, language = "en") ## sentDetect() is the function to use. It detects and seperates sentences in a text. The first argument is the string vector (or text) and the second argument is the language.

# Remove hyphenation
x2 <- gsub("-[ \\s\\n]+", "", x)

# Collect sentences that are probably citations (i.e., have 4 consequtive digits)
citations <- x2[str_detect(x2, "\\d{4}")]

# Template for creating a magicCite command
# NOTE: All citations are marked to originate from Introduction section
function.template <- "magicCite(from = '%s', 
to = '', 
sentence = '%s', 
section = 'i'
)

"

# Create a placeholder for results
output <- c()

# Process each citation
for (cite in citations) {
  output <- c(output, sprintf(function.template, citekey, cite))
}

# Write into file
writeLines(output, paste(citekey, "R", sep = "."))