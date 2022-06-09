# PokeProject
### Nacho Ampuero
--------------------

## Konzeptvorstellung
Dieses Projekt zielt darauf ab, die Grundversion des klassischen Pokédex aus der Serie nachzubilden. Es verwendet die kostenlose API von https://pokeapi.co/.
Es ist größtenteils in SwiftUI gebaut, mit Ausnahme des AR-Abschnitts, wo es mit UIKit verbunden ist.
Da sich die Pokémon-Daten (die ersten ~900 Einträge) nicht ändern, ist die anfängliche Datenliste statisch und lokal gespeichert.


## Zielgruppe
Alle Pokémon-Fans und gelangweilte Menschen mit einem iPhone.

## Ablaufplan
// https://pokeapi.co/api/v2/pokemon/charmander
Für allgemeine Spezifikationen
```
{
  "forms": [
    {
      "name": "charmander",
      "url": "https://pokeapi.co/api/v2/pokemon-form/4/"
    }],
    "height": 6,
      "species": {
    "name": "charmander",
    "url": "https://pokeapi.co/api/v2/pokemon-species/4/"
  },
    "weight": 85,
      "sprites": {
    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png",
    }
}
```

## Datenstruktur
