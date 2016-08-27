# Micro:bit - 1ère fois ... Avec Espruino

## Intro - ???


## Tools

Il y a différente façon de coder un micro:bit (see []()). En cherchant un peu sur Internet, j'ai vu que l'on pouvait utiliser le firmware Espruino sur un **micro:bit**, donc allons y ... :wink:

### Espruino?

> WIP

### Installation

- Flashez votre **micro:bit**:
  - downloadez le build Espruino spéficique au **micro:bit** (par ici http://www.espruino.com/binaries/travis/master/ au moment où j'écris, j'utilise la version `espruino_1v86.194_microbit.hex`)
  - plugguez/connectez votre **micro:bit** sur votre :computer: (USB)
  - copiez `espruino_1v86.194_microbit.hex` à la racine
  - ne soyez pas surpris, cela va déconnecter votre **micro:bit** 
- Installez l'IDE
  - pour le moment, nous allons utiliser l'IDE version "Chrome App":
    - https://chrome.google.com/webstore/detail/espruino-web-ide/bleoifhkdalbjfbobjackfdifdneehpo
    - je chercherais plus tard si l'on peut trouver autre chose

### Connexion

Tout d'abord re connectez le **micro:bit** et lancer la Chrome App


## Resources

### JavaScript :wink:

- micro:bit et nodejs: https://github.com/sandeepmistry/node-bbc-microbit
- micro:bit et Johnny 5: https://github.com/sandeepmistry/node-bbc-microbit-io
- Espruino on micro:bit: http://www.espruino.com/MicroBit



```javascript
function fun() {
  setInterval(function() {
    show(compass().x+compass().y+compass().z);
  }, 500);
}

fun();
```
