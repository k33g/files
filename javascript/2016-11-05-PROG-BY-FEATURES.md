# Programmation par "features" en JavaScript
## Et l'impact de Object.assign sur ma gestion de conf

Lorsque l'on bosse sur un projet (de dev) à plusieurs, il arrive que l'on se marche un peu sur les pieds (je suis tellement doué que même seul j'y arrive :stuck_out_tongue_winking_eye:) et que l'on génère ce que j'appelle des "collisions de code" (des conflits). En y réfléchissant, il y a des pratiques pour résoudre ces conflits, mais pour aussi les **éviter** (et je suis partisan du "moins d'ennuis possible").
Donc aujourd'hui, je vais vous expliquer par le biais d'un exemple JavaScript comment j'essaie d'éviter certains "ennuis de code" grâce au concept des **"mixins"** avec `Object.assign`, mais cela peut s'adapter à d'autres langages, notamment avec le concept de **traits**.

Mais laissez moi vous décrire ma problématique par l'exemple. (et bonne lecture)

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

Alors en tant que [@k33g](https://github.com/k33g), j'ai créé un nouveau projet https://github.com/walking-skeletons/earth-2 avec la même team. Mais cette fois ci j'ai une petite différence dans ma classe `Human`:

```javascript
class Human {
  constructor({firstName, lastName}, ...features) {
    this.firstName = firstName;
    this.lastName = lastName;
    return Object.assign(this, ...features);
  }

  sayHi() {
    console.log(`Hi I'm ${this.firstName} ${this.lastName}`);
  }
}

module.exports = {
  Human: Human
};
```

### Qu'est-ce qui a changé?

Essentiellement mon constructeur:

- `constructor({firstName, lastName}, ...features)` avec `...features` qui me permet de multiples arguments à une méthode sans savoir focément à l'avance combien (cf. https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Operators/Spread_operator)
- puis `return Object.assign(this, ...features);` qui va cloner `this` (l'instance de la classe) et lui coller les propriétés ou méthodes contenu dans `...features` et retourner un nouvel objet. (cf. https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Object/assign) Pensez au traits de Scala ou Groovy (ou les augmentations nommées de Golo)

### Mais ça sert à quoi?

Un bout de code sera plus parlant:

```javascript
const Human = require('./libs/Human').Human

function goodMorning() {
  console.log(`Good Morning I'm ${this.firstName} ${this.lastName}`);
}

let bob = new Human({
  firstName: "Bob",
  lastName: "Morane"
}, {goodMorning:goodMorning});

bob.sayHi();
bob.goodMorning();
```

J'ai donc "greffé" une nouvelle méthode à mon instance de `Human` sans avoir à modifier la classe `Human`. Du coup, maintenant [@babsbunny42](https://github.com/babsbunny42) et [@busterbunny69](https://github.com/busterbunny69) ne devraient plus se marcher sur les pieds:

## Feature sayHello par Buster

Cette fois-ci [@busterbunny69](https://github.com/busterbunny69) ne va pas modifier `Human.js` mais créer une "feature" `sayhello.js`:

```javascript
function sayHello() {
  console.log(`Hello I'm ${this.firstName} ${this.lastName}`);
}

module.exports = {
  sayHello: sayHello
};
```

Et pour l'utiliser il fera ceci:

```javascript
const Human = require('./libs/Human').Human
const sayHello = require('./libs/sayhello')

let bob = new Human({
  firstName: "Bob",
  lastName: "Morane"
}, sayHello);

bob.sayHi();
bob.sayHello();
```

Du coup Buster a préparé sa pull request

![buster-pr](pics/8a-buster-pr.png)

## Feature sayBye par Babs

De son côté Babs crée elle aussi une feature `saybye.js`

```javascript
function sayBye() {
  console.log(`Bye I'm ${this.firstName} ${this.lastName}`);
}
  
module.exports = {
  sayBye: sayBye
};
```

Que nous pourrons utiliser de cette manière:

```javascript
const Human = require('./libs/Human').Human
const sayBye = require('./libs/saybye')

let bob = new Human({
  firstName: "Bob",
  lastName: "Morane"
}, sayBye);

bob.sayHi();
bob.sayBye();
```

Babs a donc préparé elle aussi sa pull request

![babs-pr](pics/9a-babs-pr.png)

## Buster continue à n'en faire qu'à sa tête

Donc à nouveau Buster merge:

![buster-merge](pics/10a-buster-merge.png)

Mais cette fois ci cela n'a plus aucun impact sur la pull request de Babs:

![babs-can-merge](pics/11a-babs-can-merge.png)

Donc toute l'équipe peu bosser un peu plus sereinement, sans coller la :poop: dans le projet

## Et finalement...

Une fois toutes les features mergées, nous pourrons les utiliser comme ceci:

```javascript
const Human = require('./libs/Human').Human
const sayHello = require('./libs/sayhello')
const sayBye = require('./libs/saybye')


let bob = new Human({
  firstName: "Bob",
  lastName: "Morane"
}, sayHello, sayBye);

bob.sayHi();
bob.sayHello();
bob.sayBye();
```

Donc dès fois, plutôt que de se compliquer la vie avec votre gestion de conf, pensez à "écrire" votre code autrement (IMHO). :wink:
