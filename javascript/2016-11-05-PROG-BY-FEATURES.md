# Programmation par "features" en JavaScript

> WIP

## Création d'un projet "earth-1" sous GitHub

En tant que [@k33g](https://github.com/k33g), j'ai créé un projet https://github.com/walking-skeletons/earth-1. J'ai une "Team":

![team](pics/1a-team.png)

J'ai créé une première pull request en ajoutant du code:

- `libs/Human.js`
- `main.js`

![first-pr](pics/2a-first-pr.png)

Que j'ai ensuite mergée sur `master` ... Donc jusque là tout va bien

![first-merge](pics/3a-first-merge.png)

## Maintenant on bosse à plusieurs: "tiny toons in action"

Dans un 1er temps, j'ai [@busterbunny69](https://github.com/busterbunny69) qui va proposer une pull request en créant une branche `busterbunny69-wip-Hello` car il veut ajouter une méthode `sayHello()` à la classe `Human`:

```javascript
class Human {
  constructor({firstName, lastName}) {
    this.firstName = firstName;
    this.lastName = lastName;
  }

  sayHi() {
    console.log(`Hi I'm ${this.firstName} ${this.lastName}`);
  }
  
  sayHello() {
    console.log(`Hello I'm ${this.firstName} ${this.lastName}`);
  }
}

module.exports = {
  Human: Human
};
```

![buster-pr](pics/4a-buster-pr.png)

De son côté, [@babsbunny42](https://github.com/babsbunny42) souhaite ajouter via la branche `babsbunny42-wip-bye` une méthode `sayBye()`  à la classe `Human`:

```javascript
  sayBye() {
    console.log(`Bye I'm ${this.firstName} ${this.lastName}`);
  }
```

![babs-pr](pics/5a-babs-pr.png)

## Et Buster n'attend pas Babs, il merge!

Donc [@busterbunny69](https://github.com/busterbunny69) décide sans plus attendre de merger sa PR:

![buster-merge](pics/6a-buster-merge.png)

Et il est tout content :smile: ... Et nous fout un peu la :poop:, surtout chez [@babsbunny42](https://github.com/babsbunny42) qui ne peut plus merger:

![babs-no-merge](pics/7a-babs-no-merge.png)

Alors ce n'est pas plus grave que ça, **git** est là pour nous aider. Mais imaginez une équipe plus nombreuse, pas forcément disciplinée (mais quelle idée de bosser en même temps sur la même classe :laughing: ... oui je sais dès fois on n'a pas le choix), etc... 
Mais est-ce que notre façon d'écrire du code ne pourrait pas nous aider à éviter ce type de collision?

## Une autre version: Création d'un projet "earth-2"




