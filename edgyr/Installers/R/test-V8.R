library(V8)

# Create a new context
print(ct <- v8())

# Evaluate some code
print(ct$eval("var foo = 123"))
print(ct$eval("var bar = 456"))
print(ct$eval("foo + bar"))
cat(ct$eval("JSON.stringify({x:Math.random()})"))
print(ct$eval("(function(x){return x+1;})(123)"))
