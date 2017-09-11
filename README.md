# getHW
This bash script checks a given $HOME html page for any links (in the form of href tags) to homework files. Then, the script downloads these files to a specified folder. If there are any files in this folder that have the same name as the files that would be downloaded, these files are not downloaded.

Only works for course websites that list all their homework in the same page. Mostly tested with Berkeley's CS70 Fall 2017 course website http://www.eecs70.org/, may work with other websites as well.

Inspired by Josh Schreuder's BASH script to download NASA's picture of the day. Link: https://gist.github.com/JoshSchreuder/882666

# TODO
Automatically download solution files in addition to other files.

Add date checking to only check for new homeworks during days after they are released

Only check once for every homework, no matter how many times there is a link

Only check for the latest homework, rather than go through every homework

