# Functional programming with Golo - Part 2 - Unions Types

There is something else very functional with Golo: you can create Union types (kind of types with several states)

## Show me a Union type

For example, imagine that I want a type to describe that **"something is good or bad"** and of course **something** can’t be good and bad at the same time.

Here I use the `union` keyword to create a my new `Something` type:

```golo
module SomeThing

union SomeThing = {
  Yum = { value }   # good
  Yuck = { value }  # bad
}
# you're good or bad, but not good and bad
```
and then I can add two sub types `Yum` and `Yuck` with a value.

Now my `Something` type has 2 constructors:

```golo
let banana = SomeThing.Yum("🍌")     # content: union SomeThing.Yum{value=🍌}
let hotPepper = SomeThing.Yuck("🌶") # content: union SomeThing.Yuck{value=🌶}
```
- I can access to the value with the getter `value()` 
- This method is not a setter, my value is **immutable**, 
- You can see the `Something` type as a kind of "container"

```golo
let banana = SomeThing.Yum("🍌")
let hotPepper = SomeThing.Yuck("🌶")

println(banana: value())     # 🍌
println(hotPepper: value())  # 🌶
```
And Golo is nice (and useful): It generates automatically the boolean testing methods for each type:

```golo
# you can do that:
println(banana: isYum())      # true
println(hotPepper: isYuck())  # true
```

Then, now I can write something like that:
I have a closure that always returns a Yuck of hot pepper 🌶, unless the `value` parameter equals bananas 🍌:
```golo
let onlyBananas = |value| {
  if value is "🍌" { return SomeThing.Yum(value)}
  return SomeThing.Yuck("🌶")
}
```

Then I can easily test if I have a `Yum` or a `Yuck`:
```golo
if onlyBananas("🍋"): isYum() {
  println("I 💙 bananas")
} else {
  println("💔")
}
```

An other very nice thing: like for the structures, we can augment a union type.

## Augmentations

With the `$` notion I can add method to the sub types of `Something`, here I add a `so()` method to `Yum` and `Yack`:

```golo
union SomeThing = {
  Yum = { value }   # good
  Yuck = { value }  # bad
}

augment SomeThing$Yum {
  function so = |this, ifYum, ifYuck| -> ifYum(this: value())
}

augment SomeThing$Yuck {
  function so = |this, ifYum, ifYuck| -> ifYuck(this: value())
}
```
- Then the `so()` method takes 2 closures as parameters (`ifYum` and `ifYuck`)
- In the first case, I always return the result of `ifYum` 
- In the other case, I always return the result of `ifYuck`

Then now, I can write my conditions like that:
```golo
let onlyBananas = |value| {
  if value is "🍌" { return SomeThing.Yum(value)}
  return SomeThing.Yuck(value)
}

onlyBananas("🍋"): so(
  |value| {
    println("I 💙 " + value)
  },
  |value| {
    println("I 💔 " + value)
  })
```
I don’t need anymore **"if then else"**, *(in fact with an union type you can easily implement for example Either or Validation monads)*.

You can see that Union types are a great feature to write some more functional code. That's all for the moment.


