# Hi and Welcome My Mangabank Downloader script
Note, this script is designed to scrape and download manga from https://mangabank.xyz/
## Requirements
To run the downloader script you just need bash, however to process the output into a pdf you need - imagemagick  
You can run the below to install it:  
```
sudo apt-get update;  
sudo apt-get install imagemagick;  
```  
## How to run it
In order to run the downloader, you need to execute the script, passing the URL or name of the manga as an argument.  
I have outlined the argument matrix below:  
| Script     | Order | Argument | Example     | Description | 
| :---       |   :----: |    :----:   | :----: | ---: |
| chapt-get.sh | 1 | Url to Mangabank page for the mange you want to download | ./chapt-get.sh https://mangabank.xyz/kokou-no-hito | Downloads the individual images for each chapter |
| renamer.sh | 2 | Name of the Manga(you can get this by checking the folder in the output directory | ./renamer.sh kokou-no-hito | Renames the images using trailing 0's (e.g. 1.jpg -> 001.jpg) |
| 2pdf.sh | 3 | Name of Manga(Same as above) | ./2pdf.sh kokou-no-hito | Converts the images for each chapter into a pdf |
| split.sh | 4 | Name of Manga(Same as above) | ./split.sh kokou-no-hito | Separates the images and pdf's into different folders and renames the pdfs using trailing zeros |
