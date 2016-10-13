# Functional programming with Golo - Part 1

> How to make a Kebab
> First steps, baby steps

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


