# asmjoulu

Järjestämme ryhmätilauksen Summer Assemblyille 2013, jotka vietetään 1. - 4. elokuuta.

Viime vuonna (2012) ryhmätilaukseen osallistui 23 henkilöä, joista suurin osa istui katsomossa. Osa dataili myös muualla hallissa, eli kaikkien ei täydy lanittaa yhdessä ryhmässä, jos toivoo paikkoja muualta.

Ryhmätilaukseen kannattaa liittyä ensinnäkin sen takia, koska isommat ryhmät saa valita aiemmin paikat areenalta kuin pienemmät ryhmät. Valitsemme parhaat paikat ryhmän jäsenille, ottaen huomioon ilmottautuneiden toiveet. Henkilöt ryhmässä voi myös järjestää kimppakyytejä eri puolelta Suomea, jotta liikkuminen olisi halpaa ja nopeaa.

  #asmjoulu @ Quakenet

## Installation

    $ git clone https://github.com/naftis/asmjoulu.git
    $ cd asmjoulu
    $ npm install
    $ cp config.example.json config.json

  Create participates.json file

    {
      "participates": []
    }


  For development & creating static js/html/css files

    $ grunt

  For production

    $ coffee runserver.coffee
