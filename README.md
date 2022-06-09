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


## Datenstruktur
Für allgemeine Spezifikationen (https://pokeapi.co/api/v2/pokemon/charmander)
```
{
    "forms": [{
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

Es ist notwendig, die Art (*species*) zu finden, um dann die Evolutionskette zu finden (https://pokeapi.co/api/v2/pokemon-species/4/)
```
{
    "evolution_chain": {
        "url": "https://pokeapi.co/api/v2/evolution-chain/2/"
    }
}
```

Für die Evolutionskette (https://pokeapi.co/api/v2/evolution-chain/2/)
```
{
    "chain": {
        "evolves_to": [{
            "evolves_to": [{
                "evolves_to": [],
                "species": {
                    "name": "charizard",
                    "url": "https://pokeapi.co/api/v2/pokemon-species/6/"
                }
            }],
            "species": {
                "name": "charmeleon",
                "url": "https://pokeapi.co/api/v2/pokemon-species/5/"
            }
        }],
        "species": {
            "name": "charmander",
            "url": "https://pokeapi.co/api/v2/pokemon-species/4/"
        }
    }
}
```
