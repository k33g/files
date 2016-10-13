# Functional programming with Golo - Part 1

> baby steps with functional programming

Golo is functional. I'll write some articles about that, and today it's the first!

## First of all, functions and closures

With Golo (it’s like JavaScript :wink:), functions are 👑 . Functions and closure can be used as **output** and **input** of other functions (or other closures).

Here 👇 I have a closure that return an other closure that return the result of the `addition` function

```golo
function addition = |a, b| { return a + b }

function main = |args| {
  # function as output
  let add = |a| {
    return |b| {
      return addition(a,b)
    }
  }
}
```

Then I can create some kind of alias of closure (here 👇 with `addone`), and I can reuse it for example as a parameter of a `map` method to apply `addone` on all items of a list:

```golo
function addition = |a, b| { return a + b }

function main = |args| {
  # function as output
  let add = |a| {
    return |b| {
      return addition(a,b)
    }
  }

  let addOne = add(1)
  println(addOne(41)) # 42

  println(
    list[1, 2, 3, 4, 5]: map(addOne) 
    # [2, 3, 4, 5, 6]
  )
}
```

And here this is a more concise way to do that with the arrow notation:

```golo
function addition = |a, b| { return a + b }

function main = |args| {

  let add = |a| -> |b| -> addition(a,b)

}
```
And by the way, you can see that you can chain `map` methods, and at each `map` you get a new list:

```golo
function addition = |a, b| { return a + b }

function main = |args| {

  let add = |a| -> |b| -> addition(a,b)

  let addOne = add(1)

  println(
    list[1, 2, 3, 4, 5]
      : map(addOne) # [2, 3, 4, 5, 6] this is a new list
      : map(addOne) # [3, 4, 5, 6, 7] this is another new list
  )
}
```

So far, is it ok? (if not, don't hesitate to create an issue here 👉 https://github.com/k33g/files/issues)

## No iteration, or how to make a Kebab with Golo

With functional programming, you have to try to avoid iteration, it’s really easy with Golo, eg: lists have the necessary methods as `map`, `filter`, `reduce`, `each` …

For example, imagine I want to prepare a Kebab (it’s kind of sandwich) and I have two closures `noChips`, `noOnion`.
You can "read" it as *"I don’t want chips"* and *"I don’t want onion"*. For example, If I pass some 🍞 to `noChips` I'll get `true`.

```golo
let noChips = |food| -> food isnt "🍟" 
# return true if it's not chips

let noOnion = |food| -> food isnt “😭"

noChips("🍞") == true
noChips("🍟") == false
```
I have an other closure `cutfood` that returns a string concatenation, and I have a list of food:

```golo
let noChips = |food| -> food isnt "🍟" 
let noOnion = |food| -> food isnt "😭"

let cutFood = |food| -> "piece of " + food

let Food = list[
    "🍞"
  , "🍃"
  , "🍅"
  , "🍖"
  , "🍟"
  , "😭"  # 😡 I can't find onion emoji
]
```

Now,  I can make a filter on `Food` (`[🍞, 🍃, 🍅, 🍖, 🍟, 😭]`) applying the `noChips` closure
I can chain the `filter` methods (each time I get a new list: `[🍞, 🍃, 🍅, 🍖, 😭]`, then `[🍞, 🍃, 🍅, 🍖]`)
an then, I can apply `cutFood` to all the items of the list with the `map` method
and I’ll get a new transformed list: `[piece of 🍞, piece of 🍃, piece of 🍅, piece of 🍖]`

This is the code:

```golo
let myKebabRecipe = Food
      : filter(noChips)
      : filter(noOnion)
      : map(cutFood)
```

And now I can apply an other closure (`mixFood`) to my list (`[piece of 🍞, piece of 🍃, piece of 🍅, piece of 🍖]`) with the `reduce` method, and then I get a Kebab (without chips and onion: `🌮 with: piece of 🍞 piece of 🍃 piece of 🍅 piece of 🍖 `).
I have transformed my list to a string and all this without iteration:

```golo
# ⚡️ preparing kebab with myKebabRecipe
let mixFood = |accFood, nextFood| -> accFood + nextFood + " "

let kebab = myKebabRecipe
      : reduce("🌮 with: ", mixFood)
```

Quite easy and simple! No? 😉

As you see, nothing complicated. Next time, will see **Union Types**.


