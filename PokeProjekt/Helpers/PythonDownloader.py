from unicodedata import name
import urllib.request

# opening the file in read mode
names_file = open("PokemonNameList.txt", "r")
  
# reading the file
data = names_file.read()
  
# replacing end splitting the text 
# when newline ('\n') is seen.
names = data.split("\n")

names_file.close()

       
index = 1
for nam in names:

    url = f"https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/{index}.png"
    # urllib.request.urlretrieve(url, f"/Users/nacho/Desktop/pokeImages/{nam}@1x.png")
    # urllib.request.urlretrieve(url, f"/Users/nacho/Desktop/pokeImages/{nam}@2x.png")
    print(url)

    print(index, nam)
    index += 1

    # 898 calyrex
