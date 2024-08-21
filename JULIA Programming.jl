#Printing in JULIA
println("I am excited to learn JULIA")

#Assigning a Variable
my_answer = 42
typeof(my_answer)

my_pi = 3.14159
typeof(my_pi)

#=helloe 
i am vishal singh
i am learning JULIA =#

# Abobe is a multi line comment


sum = 3 + 7

difference = 10-3

product = 10*5

quotient = 100/10

power = 10^2 #In python 10**2 

modulus = 101%2

##String

s1 = "I am a string"

s2 = """I am also a string"""

"""Look, no "errors"!!!"""

typeof("a")

'we will get an here'

name = "Jane"
num_fingers = 10
num_toes = 10 

println("Hello, my name is $name")
println("I have $num_fingers fingers and $num_toes toes. That is $(num_fingers + num_toes) digits in all!!")

string("How many cats ", "are too many cats?")

string("I don't know, but ", 10, " are too few.")

s3 = "How many cats ";
s4 = "are too many cats?";

s3*s4

"$s3$s4"

myphonebook = Dict("Jenny" => "867-5309", "Ghostbusters" => "555-324")

#To add another entry 
myphonebook["Kramer"] = "555-6677"

myphonebook

myphonebook["Kramer"]

pop!(myphonebook,"Kramer")

myphonebook

myphonebook[1]

myfavoriteanimals = ("penguins", "cats", "sugargliders")

myfavoriteanimals[1] #Julia starts from 1 index rather than 0 index as in python

myfavoriteanimals[1] = "otters"

myfriends = ["Ted", "Robyn", "Barney", "Lily", "Marshal"]

fibonacci = [1,1,2,3,5,8,13]
mix = [1,3,45,6,6,"hi"]

myfriends[3]

myfriends[2] = "Baby Bop"

myfriends

push!(fibonacci,21)

pop!(fibonacci) #removes the last entry

fibonacci

pop!(fibonacci) #removes the last entry

fibonacci

favorites = [["koobideh", "chocolate", "eggs"],["penguins", "cats", "sugargliders"]]

numbers = [[1,2,3],[4,5],[6,7,8,9]]

rand(4,3)

rand(4,3,2)

n = 0 
while n < 10
    n += 1
    println(n)
end

myfriends = ["Ted", "Robin", "Barney", "Lily", "Marshal"]

i = 1
while i <= length(myfriends)
    friends = myfriends[i]
    println("Hi $friends it's great to see you!")
    i += 1
end

for n in 1:10
    println(n)
end

myfriends = ["Ted", "Robin", "Barney", "Lily", "Marshal"]

for friend in myfriends
    println("Hi $friend, it is great to see you!")
end

for n = 1:10
    println(n)
end

m, n = 5, 5
A = zeros(m,n)

for i in 1:m
    for j in 1:n
        A[i, j] = i + j
    end
end
A

B = zeros(m, n)

for i in 1:m, j in 1:n
    B[i, j] = i + j
end
B

c = [i + j for i in 1:m, j in 1:n]

for n in 1:10
    A = [i + j for i in 1:n, j in 1:n]
    display(A)
end

x = 3
y = 90 

if x > y 
    println("$x is larger than $y")
elseif y > x
    println("$y is larger than $x")
else 
    println("$x and $y are equal!")
end

if x > y
    x
else 
    y
end

(x > y) ? x : y

(x > y) && println("$x is larger than $y")

(x < y) && println("$x is smaller than $y")

function sayhi(name)
    println("Hi $name, it's great to see you")
end

function f(x)
    x^2
end

sayhi("Vishal")

f(69)

sayhi2(name) = println("Hi $name, it's great to see you")

f2(x) = x^2

sayhi2("Vishal")

f2(69)

sayhi3 = name -> println("Hi $name, it's great to see you")

f3 = x -> x^2

sayhi3("Vishal")

f3(69)

sayhi(66666778899)

A = rand(3, 3)
A

f(A)

v = rand(3)

f(v)

v = [3, 5, 2]

sort(v)

v

sort!(v)

v

A = [i + 3*j for j in 0:2, i in 1:3]

f(A) #Not broadcasting, Matrix A multiplied by Matrix A

B = f.(A) #Broadcasting and Each element of the matrix is squared.

A[2,2] #element of the matrix which is at [2,2] position

A[2,2]^2 #Square of the element 

B[2,2] #[2,2] position element of the B matrix 

v = [1, 2, 3]

f.(v)

using Pkg
Pkg.add("Example")

using Example

hello("It's me. I was wondering if after all these years you'd like to meet.")

Pkg.add("Colors")

using Colors

Pkg.add("Plots")

using Plots

x = -3:0.1:3
f(x) = x^2
y = f.(x)

gr()

plot(x,y,label="line")
scatter!(x, y, label="points")

Pkg.add("PlotlyJS")
plotlyjs()

plot(x, y, label="line")
scatter!(x, y, label="points")

globaltemperatures = [14.4, 14.5, 14.8, 15.2, 15.5, 15.8]
numpirates = [45000, 20000, 15000, 5000, 400, 17]

#First plot the data 
plot(numpirates, globaltemperatures, legend=false)
scatter!(numpirates, globaltemperatures, legend=false)

#This reverses x axis we can see how the temperature changes as 
xflip!()

#Add titles and labels
xlabel!("Number of Pirates [Approximate]")
ylabel!("Global Temperature (C)")
title!("Influence of pirate population on global warming")

p1 = plot(x, x)
p2 = plot(x, x.^2)
p3 = plot(x, x.^3)
p4 = plot(x, x.^4)
plot(p1,p2, p3, p4, layout=(2,2), legend=false)

methods(+)

@which 3 + 3

@which 3.0 + 3.0

@which 3 + 3.0

import Base: +

@which "hello " + "world!"

+(x::String, y::String) = string(x, y)

"hello " + "world!"

@which "hello " + "world!"

foo(x, y) = println("duck-typed foo!")
foo(x::Int, y::Float64) = println("foo with an integer and a float")
foo(x::Float64, y::Float64) = println("foo with two floats")
foo(x::Int, y::Int) = println("foo with two integers!")

foo(1, 1)

foo(1., 1.)

foo(1, 1.0)

foo(true, false)

struct MyObj
    field1
    field2
end

myobj1 = MyObj("Hello", "World") #Immutable

myobj1.field1

myobj1.field2

myobj1.field1 = "test"

mutable struct Person
    name::String
    age::Float64
end

logan = Person("Logan", 44)

logan.age += 1

bob = Person(20,44) #Will give an error

mutable struct newPerson
    name::String
    age::Float64
    isActive
    
    function newPerson(name, age)
        new(name, age, true)
    end
end

new = newPerson("Bob", 27)

function birthday(person::Person)
    person.age +=1
end

birthday(logan)

logan.age

A = rand(1:4, 3, 3)

B = A
C = copy(A)
[ B C]

# Watch out !
A[1] = 17
[B C] #B and A are refernces to the same memory 

x = ones(3)

b = A*x

A

A'

Asym = A + A'

Apd = A'A

A\b

#Keep all rows and only the first 2 columns of "A" to generate A'
Atall = A[:,1:2]
display(Atall)
Atall\b

A = rand(3, 3)

#The outer product of a vector with itself will result in a single  
[A[:,1] A[:,1]]\b

#Keep all columns and only the first 2 rows of "A" to generate

Ashort = A[1:2,:]
display(Ashort)
Ashort\b[1:2]

A = rand(3,3)

# One way to perform an LU factorisation is with the function "lu", which returns matrices l and u 
#and permutation vector p.
using LinearAlgebra

l,u,p = lu(A)

# Pivoting is on by default so we can't assume A == LU 

display(norm(l*u - A))
display(norm(l*u - A[p,:]))

x = ones(3)
b = A*x

det(A)

Aqr = qr(A[:,1:2])

println(Aqr.Q)

Aqr.R

(Aqr.Q)*ones(2)

Asym = A + A'

Asymeig = eigen(Asym)

Asymeig.values

Asymeig.vectors

inv(Asymeig)*Asym

Asvd = svd(A[:,1:2])

Asvd\b

A

Diagonal(diag(A))

Diagonal(A)

LowerTriangular(A)

Symmetric(Asym)

SymTridiagonal(diag(Asym), diag(Asym,1))

n = 1000;
A = randn(n,n);
Asym1 = A + A';
Asym2 = copy(Asym1); Asym2[1,2] += 5eps();
println("Is Asym1 symmetric? ", issymmetric(Asym1))
println("Is Asym2 symmetric? ", issymmetric(Asym2))

@time eigvals(Asym1);

@time eigvals(Asym2);

@time eigvals(Symmetric(Asym2));

rand(1:10,3,3)*rand(1:10,3,3)

Ar = convert(Matrix{Rational{BigInt}}, rand(1:10,3,3))/10

x = ones(Int, 3)
b = Ar*x

lu(Ar)

Ar\b

l1, l2, l3 = 1//1,1//2,1//4
v1,v2,v3 = [1,0,0],[1,1,0],[1,1,1]
v, A = [v1 v2 v3], Diagonal([l1,l2,l3])
A = v*A/v


