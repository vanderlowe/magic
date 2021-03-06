# Putting `magic` into your literature review

Let us assume that you are interested in quickly getting a sense of which papers are important in a particular field of study. For the purposes of this example, let's say that you are interested in response coherence in basic emotions. Someone recommended you to read Paul Ekman's chapter (1999) and you found an interesting paper on emotion coherence by Iris Mauss and her colleagues (2005) on Google Scholar. In practical terms, you have two PDF documents that are relevant and now you need to find out which other papers you should also read.

The `magic` package helps you to harvest citations from a small set of papers to get a systematic overview  of the literature and highlight relevant papers.

# Creating literature review database
The first step is to let `magic` know which paper you are currently reading by using the `magicPaper` function.

## Creating a new paper with `magicPaper`
The only required argument for `magicPaper` is a __citation key__ (or citekey for short). Each paper in the literature review must be uniquely identified, so that we know which paper is which. The citekey will be in the format of first author's family name and publication year, similar to the APA style in-text citations. Since our first paper to be read is by Ekman (1999), the citekey will be `ekman1999`. Notice that there are no spaces, hyphenation, or special characters in the citekey. Non-English special characters need to be replaced with their English versions (i.e., ö = o).

Thus, to create a new paper in the literature review database, you can simply type:
```
magicPaper("ekman1999")
```

However, it would also be nice to include the paper title in the database entry, wouldn't it? This can be done by typing:
```
magicPaper("ekman1999", "Basic Emotions", update = TRUE)
```
The `update = TRUE` argument indicates that you are not creating a new paper, just updating an existing one. Of course, you could have typed `magicPaper("ekman1999", "Basic Emotions")` in the first place.

Since we will be soon needing the citekey `ekman1999`, let's store it for easy use:
```
myPDF <- "ekman1999"
```
This allows us to use `myPDF` instead of having to type `ekman1999` every time we wish to make a citation.

## Creating citations with `magicCite`
Now that Ekman's _Basic Emotions_ chapter is in our database and the citekey handily available, we can start reading the paper itself. As you read the PDF, whenever you encounter a sentence that cites another paper, copy the sentence to clipboard. For example, the first sentence in Ekman's paper has a self-citation:
_"In this chapter I consolidate my previous writings about basic emotions (Ekman, 1984,1992a, 1992b) and introduce a few changes in my thinking."_ Let's copy it to clipboard, then!

Since this sentence actually makes three citations, we need to use the `magicCite` function three times, like this:
```
magicCite(from = myPDF, 
          to = "Ekman1984",
          sentence = "In this chapter I consolidate my previous writings about basic emotions (Ekman1984) and introduce a few changes in my thinking.",
          section = "i"
)

magicCite(from = myPDF, 
          to = "Ekman1992a",
          sentence = "In this chapter I consolidate my previous writings about basic emotions (Ekman1984) and introduce a few changes in my thinking.",
          section = "i"
)

magicCite(from = myPDF, 
          to = "Ekman1992b",
          sentence = "In this chapter I consolidate my previous writings about basic emotions (Ekman1984) and introduce a few changes in my thinking.",
          section = "i"
)
```

The `from` argument indicates the source document making the citation (`ekman1999` in our case, stored in the `myPDF` variable). The `to` argument is the target of the citation, `sentence` is the textual context in which the citation occurs, and the `section` indicates whether the citation occurs in the __i__ntroduction, __m__ethod, __r__esults, or __d__iscussion (as indicated by the first letter of the section heading).

Thus, reading the entire paper, your script would include a long list of `magicCite` functions (see a [full example for `ekman1999`](https://github.com/vanderlowe/magic/blob/master/inst/examples/ekman1999.R) and [`mauss2005`](https://github.com/vanderlowe/magic/blob/master/inst/examples/mauss2005.R)).

Note: You can also use `magicCite` to highlight important sentences that do not necessarily include a citation. For example, here is how we can highlight a sentence in `ekman1999`. The crucial part is to set `to = NULL`. A citation without a target paper is interpreted as a sentence __you__ wish to cite in your own writing (i.e., a highlighted sentence).
```
magicCite("ekman1999", 
          to = NULL, 
          "To identify separate discrete emotions does not necessarily require that one also take an evolutionary view of emotions."
)
```
# Making sense of the literature in the database

After entering citations from just two papers, we can already gain valuable insight about citation trends to guide the future direction of our literature review.

## Examining individual papers with `magicSynopsis`
The function `magicSynopsis` can be used to get a a brief summary of a paper.
```
magicSynopsis("ekman1999")
```

The function provides the following output:
```
Most frequently cited articles in ekman1999:
1) ohman1986 (4 times)
2) lazarus1991 (3 times)
3) stein1992 (3 times)
4) darwin1872 (2 times)
5) ekman1975 (2 times)
6) ekman1984 (2 times)
7) johnsonlaird1992 (2 times)
8) levenson1990 (2 times)
9) tooby1990 (2 times)

Highlighted sentences in ekman1999:
To identify separate discrete emotions does not necessarily require that one also take an evolutionary view of emotions.
```
It appears that Ekman made a reference to a paper `ohman1986` four times, suggesting that it might be relevant to us, too. Let's take a look at this paper, then.
```
magicSynopsis("ohman1986")
```
The output of the command is as follows:
```
ekman1999 [cited 4 time(s)]:
Ohman's (1986) analysis of fear is relevant to these complexities. He distinguishes fear of animals, fear of people, and fear of inanimate objects, suggesting that different actions may have evolved for fear of a predator as compared to social fears.  Similar views have since been described by Zajonc (1985), Öhman (1986), Leventhal & Scherer (1987) and Buck (1985). In all likelihood, not enough is given for automatic appraisal to ever operate without considerable amplification and detailing through social learning (see, especially, Öhman, 1986 on this point).  Öhman (1986) describes how both evolution and social learning contribute to the establishment of those events which call forth one or another emotion.

Most frequent citation words ohman1986:
fear 
```
Well, look at that! A rather nice summary of `ohman1984`, in the words of Dr. Paul Ekman himself. It seems like `ohman1984` is a paper about biological and social influences on the emotion of fear. Peeking into the PDF, we find out that the title of `Ohman1984` is _"Face the beast and fear the face: animal and social fears as prototypes for evolutionary analyses of emotion"_, which indeed matches the synopsis.

(As a sidenote, the output for `ohman1986` is slightly different from what we saw before, because it was cited by `ekman1999` whereas `ekman1999` was not cited by `Mauss2005`, the only other paper in this example. Because `ekman1999` was a source, but not the target of citations, output for `magicSynopsis("ohman1984")` was different from `magicSynopsis("ekman1999")`. For papers that are both target and sources of citations, the output combines both types of information.)

In `ekman1999`, the second most cited paper is `lazarus1991`, so let's look at that, too. The output of `magicSynopsis("lazarus1991")` is:
```
ekman1999 [cited 3 time(s)]:
Lazarus (1991) talks of "common adaptational" tasks as these are appraised and configured into core relational themes" (p. 202) and gives examples of facing an immediate danger, experiencing an irrevocable loss, progressing towards the realization of a goal, etc. Lazarus (1991) cites this same study to argue his rather similar view. Although he emphasizes what he calls "meaning analysis", Lazarus also describes common antecedent events. Lazarus (1991), has a similar but in some ways different account, describing what he calls the "core relational theme" unique to the appraisal of each emotion.

mauss2005 [cited 6 time(s)]:
For many theorists, a defining feature of emotion is response coherence (e.g., Ekman, 1972, 1992; Lazarus, 1991; Levenson, 1994; Scherer, 1984; Tomkins, 1962).  Most, but not all, of these theorists have taken a functional perspective, proposing that by imposing coherence across response systems, emotions facilitate the organism’s response to environmental demands (e.g., Ekman, 1992; Lazarus, 1991; Levenson, 1994; Plutchik, 1980; Witherington, Campos, & Hertentein, 2001).  Thus, many theorists assume that one central feature (and perhaps the function) of emotions is response coherence, variously labeled as response system coherence (Ekman, 1992), organization of response components (Frijda, Ortony, Sonnemans, & Clore, 1992; Scherer, 1984; Witherington et al., 2001), response compoent syndromes (Averill, 1980; Reisenzein, 2000), concordance (Nesse et al., 1985; Wilhelm & Roth, 2001), or organization of response tendencies (Lazarus, 1991; Levenson, 1994).  Second, different emotions should be associated with different patterns of experiential, behavioral, and physiological responding, tailored to meet the demands of different situations (e.g., Lazarus, 1991; Levenson, 1988).  As such, they provide evidence for one of the central tenets of a large number of emotion theories(e.g., Ekman, 1992; Frijda et al., 1992; Lazarus, 1991; Levenson, 1994; Scherer, 1984; Tomkins, 1962),namely, that emotion response systems, including subjective experience, facial behavior, and peripheral physiological reponding, are associated during emotional episodes.  This finding provides some support for functionalist accounts, which have relied on the claim that emotions serve to impose response coherence onemotion response systems (Ekman, 1992; Lazarus, 1991; Levenson, 1994; Plutchik, 1980; Tooby & Cosmides, 1990). 

Most frequent citation words lazarus1991:
response, levenson, coherence, ekman, emotion, different, emotions 
```
It seems that `Mauss2005` cited `lazarus1991` twice as many times as `ekman1999`. Because Dr. Mauss wrote in more length about `lazarus1991` than Dr. Ekman did, the summary is longer. Fortunately, this increased word count has made the final line of the output more useful. This paper could be about response coherence in different emotions and mentioned frequently with citations including Levenson and Ekman, who are well-respected emotion theorists. Sounds like `lazarus1991` might be an important paper to read. (Peeking into the PDFs, `lazarus1991` appears to be a book titled _Emotion and Adaptation_. Perhaps this would be a good time to read the summaries included in the output of `magicSynosis("lazarus1991")` to get a better idea of what to expect before reading the book itself.)

## Getting the big picture with `magicOverview`
Instead of examining the literature one paper at a time, `magicOverview` provides a visualization of the citation patterns in the literature review data. Let's give it a try.
```
magicOverview()
```
<img src = "http://i.imgur.com/eaBFWqF.png" alt="magicOverview() output" style="width: 750px;"/>
As a result, the function renders a network of citations. In this network, it is easy to identify central papers that receive many citations. For example, `darwin1872`, `levenson1983`, `lazarus1991`, `ekman1992`, `rosenberg1994`, `tooby1990`, and `tomkins1962` are all cited by both `ekman1999` and `mauss2005`.

The color of the citation lines indicates the section from which the citation originates. For example, it is easy to see that papers by Gottman, Gross, Kettunen, and Levenson are cited by `mauss2005` for their methods (the color for method section is green). As evident in the abundance of blue lines, most citations are located in introduction sections. The citation color also indicates that `ekman1999` is a theory paper, because it has no other sections than introduction.

By default, `magicOverview` hides papers that have been cited at least three times. We can adjust the minimum citation threshold to get an even clearer view of the literature to decide which papers we should include in our literature review.

```
magicOverview(min.citations=6)
```
<img src = "http://i.imgur.com/cUBAF5R.png" alt="magicOverview() output simplified" style="width: 750px;"/>
From this simplified graph we can easily see that `levenson1994`, `lazarus1991` and `ekman1992` are cited multiple times by both `mauss2005` and `ekman1999`. Therefore, if the content of both `mauss2005` and `ekman1999` are of interest to us, we would likely benefit from checking these papers as well. Of course, when citations from any (or all) of these papers are added to the literature database, our understanding of the field gets improved, yielding more even more targeted suggestions.
