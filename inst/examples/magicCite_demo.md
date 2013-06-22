# Putting `magic` into your literature review

Let us assume that you are interested in quickly getting a sense of which papers are important in a particular field of study. In practical terms, you have a couple of papers that you found via Google Scholar, and now you want to know which other papers you should also read.

For demonstration purposes, let's say that you wish to study basic emotions and emotion coherence. Someone recommended that you read Paul Ekman's chapter on basic emotions (1999) and you found an interesting paper on emotion coherence by Iris Mauss and her colleagues (2005) on Google Scholar.

The `magic` package helps you to systematically harvest citations from these papers to get an overview of related research and can guide your literature review by highlighting other papers that you probably should also read.

# Creating entries in the literature review database
At the moment, `magic` requires a high level of instruction from the user (although part of this can be automated in the future). The first step is to let `magic` know which paper you are currently reading. To accomplish this, we will use `magicPaper` function.

## Creating a new paper with `magicPaper`
The only required argument for `magicPaper` is a __citation key__ (or citekey for short). Each paper must be uniquely identified, so that we know which papers cite which other papers. The citekey will be in the format of first author's family name and publication year, similar to the APA style in-text citations. Since our first paper to be read is by Ekman, the citekey will be `ekman1999`. Notice that there are no spaces, hyphenation is removed, and special characters are replaced with their basic equivalents (i.e., ö = o).

Thus, to create a new paper in the literature review database, you can simply type:
```
magicPaper("ekman1999")
```

However, it would also be nice to include the paper title in the database entry, wouldn't it? This can be done by typing:
```
magicPaper("ekman1999", "Basic Emotions", update = TRUE)
```
The `update = TRUE` argument indicates that you are not creating a new paper, just updating an existing one.

Since we will be needing the citekey `ekman1999` a lot while creating citations originating from his paper, let's store it for easy use:
```
myPDF <- "ekman1999"
```
This allows us to use `myPDF` instead of having to type `ekman1999` every time we wish to make a citation.

## Creating citations with `magicCite`
Now that the paper by Ekman is in our database and the citekey handily available, we can start reading the paper itself. Currently, there are no automated parsing functions in `magic` (yet) to identify the citations for you, so you need to read the paper carefully, sentence by sentence (as a diligent academic should anyway). As you read the PDF, whenever you encounter a sentence that cites another paper, copy it to clipboard. The first sentence in Ekman's paper has a self-citation:
_"In this chapter I consolidate my previous writings about basic emotions (Ekman, 1984,1992a, 1992b) and introduce a few changes in my thinking."_ Let's copy it to clipboard, then!

Since this sentence actually makes three citations, we need to use the `magicCite` function three times, like this:
```
magicCite(from = myPDF, 
          to <- "Ekman1984",
          sentence <- "In this chapter I consolidate my previous writings about basic emotions (Ekman1984) and introduce a few changes in my thinking.",
          section <- "i"
)

magicCite(from = myPDF, 
          to <- "Ekman1992a",
          sentence <- "In this chapter I consolidate my previous writings about basic emotions (Ekman1984) and introduce a few changes in my thinking.",
          section <- "i"
)

magicCite(from = myPDF, 
          to <- "Ekman1992b",
          sentence <- "In this chapter I consolidate my previous writings about basic emotions (Ekman1984) and introduce a few changes in my thinking.",
          section <- "i"
)
```

The `from` argument indicates the source document making the citation (`ekman1999` in our case, stored in the `myPDF` variable). The `to` argument is the target of the citation, `sentence` is the textual context in which the citation occurs, and the `section` indicates whether the citation occurs in the __i__ntroduction, __m__ethod, __r__esults, or __d__iscussion (as indicated by the first letter of the section heading).

Thus, reading the entire paper, your script would include a long list of `magicCite` functions ([an example for `ekman1999`]())


