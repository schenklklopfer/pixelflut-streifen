# pixelflut-streifen

Gedacht war das Script um möglichs schnell eine #Pixelflut Wand mit einer Farbe zu lackieren.  
Solange man kein Multi-Threading verwendet tut es das auch.  

Aber mit Multi-Threading passieren echt lustige Dinge^^  
Einfach mal selber ausprobieren, eventuell gegen den Pixelflut Server hier: https://github.com/TobleMiner/shoreline  
Oder in Docker: https://github.com/Poeschl/docker-shoreline

### Wie mache ich Multi-Threading aus?

## Dependencies

- bash
- mbuffer
- openssl

## Usage

`./pixel.sh <IPv4-Address>`

## You may want to do

`mount -o size=100M -t tmpfs none /mnt/tmpfs`
