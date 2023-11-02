-- Exercise 1

-- function which adds two numbers
add n1 n2 = n1 + n2

-- define without using args
-- is it the same as add?
plus = (+)

-- provide an explicit type declaration
plus' :: Num a => a -> a -> a
plus' = (+)

-- function which concats two lists
conc ls1 ls2 = ls1 ++ ls2

-- partially apply above functions:

add10 = add 10
plus5 = plus 5
concHello = conc "hello"

-- Exercise 2

first (v, _) = v
second (_, v) = v

fst3 (x,_,_) = x
snd3 (_,y,_) = y

sumFirst2 :: Num a => [a] -> a
sumFirst2 (x:y:_) = x + y

fnFirst2 :: [a] -> (a -> a -> b) -> (a -> a -> b) -> b
fnFirst2 (x:y:[]) f1 _ = f1 x y
fnFirst2 (x:y:_) _ f2 = f2 x y


-- Exercise 3

cartesianProduct ls1 ls2 =
  [ (x, y) | x <- ls1, y <- ls2 ]

cartesianProductIf ls1 ls2 predicate =
  [ (x, y) | x <- ls1, y <- ls2, predicate x y ]

listOfPairs = [(x,3*x^2+2*x+1) | x <- [1..10]]
componentMulTup = [(x, y) | x <- [1..10], let y = 3 * x^2 + 2 * x + 1, y `rem` 3 == 0]

oddEvenPairs n = [(x,y) | x <-[1..n], y <-[1..n],odd x, even y]
