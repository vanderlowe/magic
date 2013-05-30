<img src = "http://i.imgur.com/XD2QLHf.jpg" alt="magic airplane" style="width: 500px;"/>
In 1962, Arthur C. Clarke wrote:
> Any sufficiently advanced technology is indistinguishable from magic.

# magic
A package for R language that will bestow users with magical data analytic capabilities. This is mainly to allow researchers at the [Cambridge Prosociality and Well-being Lab](http://smallcopper.sociology.cam.ac.uk/) to focus more on collaborative research and less on doing silly gruntwork.

The main point of `magic` is to remove the complexity of connecting to a database by hiding it from view: you set things once and the rest is `magic`.

# installation
The easiest way to get some `magic` on your computer, please type the following to your R console:
```R
    install.packages("devtools")
    require("devtools")

    install_github("magic", "vanderlowe")
    require("magic")
```
This should get you rolling. These tools are under development, so try re-installing if you are not feeling the `magic`.

# using `magic`

Most of your R scripts that use the lab data should start with:

```R
require(magic)
```

Including this in your scripts will make the useful functions in `magic` available to you. These include: `magicSQL`, `magicExplain`, and `magicFindVariable`.

The function you will use the most is `magicSQL`. You can try it by typing:

```R
magicSQL()  # Don't forget the parentheses!
```

Without any further instructions, `magicSQL` shows you the databases that are available to you.

Let's see the tables in the `cpw_iOpener` database. You can investigate the database by typing:

```R
magicSQL(db = "cpw_iOpener")
```

This shows that the `cpw_iOpener` database has only one table, `iPPQ`. To see what variables are in the `iPPQ` table, type:

```R
magicSQL("SHOW FIELDS FROM iPPQ", db = "cpw_iOpener")
```

To create a dataset that includes `gender`, `age_group`, and `love_job` variables, you type:

```R
mydata <- magicSQL("SELECT gender, age_group, love_job FROM iPPQ", db = "cpw_iOpener")
```

Voilà.

## Finding variables by `magic`
Many datasets are complex and finding variables by listing everything is tedious. The function `magicFindVariable` helps you to quickly narrow down the variables of interest.

Let's say we are interested in close relationships, especially marriage. To find variables that might have to do something marriage, you can type:

```R
magicFindVariable("marriage")
```

This function looks at the variable descriptions and tries to find mentions of the word "marriage" in them.

Based on the results, the variable `f188` seems especially interesting, so let's find out more about it.

```R
magicExplain("f188")
```

If we were to use this variable in our analyses, the function even gives the command for downloading the data.

## An example script
Below is a more complex example script to work with the myPersonality data.

```R
# Every journey starts with a single step:
require(magic)

# Which tables does the cpw_myPersonality database have?
magicSQL(db = "cpw_myPersonality")

# Which variables do the tables big5 and address have?
magicSQL("show fields from big5", "cpw_myPersonality")
magicSQL("show fields from address", "cpw_myPersonality")

# How many observations do variables ope and location_lat have?
magicSQL("SELECT COUNT(ope) FROM big5", "cpw_myPersonality")
magicSQL("SELECT COUNT(location_lat) FROM address", "cpw_myPersonality")

# How long does it take to download data that joins the two?
system.time(nature <- magicSQL("SELECT big5.ope, address.location_lat, address.location_lon, address.hometown_lat, 
address.hometown_lon FROM big5, address WHERE big5.userid=address.userid", "cpw_myPersonality"))

# What does plotting the location data reveal?
plot(nature$location_lon, nature$location_lat)