# Functor et Monad

J'ai souvent essayé de me mettre à Scala, mais j'ai souvent entendu des "gros mots" de la part des personnes à qui je demandais des conseils ou des explications, et cela donnait en général ceci:

![:octocat:](pic/k33g_functional.jpg)

*Au passage, un GRAND MERCI aux [@CommitStrip](https://twitter.com/commitstrip)*

... Mais c'est vexant de rien comprendre, du coup j'ai pris mon courage à 🙌 et j'ai recommencé, plutôt en regardant les autres langages, la théorie, etc... et tou ça avec du JavaScript. Oui, je sais, ce n'est pas typé, peut-être pas adapté, mais "je lis le JavaScript" 😜

## Essai de définition

> WIP

Commençons par la notion de **Container**.

## Container

Alors un container, voyez ça comme un bocal dans lequel vous voulez conserver quelque chose pour le garder intact (conservation des griottes dans l’alcool par exemple), bien fermé pour que les enfants ne puissent pas y toucher. Donc en gros un contenant qui fait que le contenu n’a pas d’impact sur le monde extérieur et vice et versa 

![:octocat:](pic/container.png)

Et en JavaScript, cela donnerait ceci:

```javascript
class Container {
  constructor(x) {
    const value = x;
    Object.defineProperty(this, "value", { get: () => value })
  }

  static of(x) {
    return new Container(x);
  }
}
```

Et pour l'utiliser:
```javascript
let bob = Container.of("Bob Morane");
bob.value == "Bob Morane" // true
bob.value = "John Doe" // ne fonctionnera pas
```

On a donc la garantie que la valeur de départ ne "bougera pas". Mais tout ça n'est pas très utile finalement. Allons donc voir ce qu'est un **Functor**.







