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



