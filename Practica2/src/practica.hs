-- potencia b p, que recibe un número b y lo eleva a la p.
potencia:: Int -> Int -> Int
potencia b 0 = 1
potencia b p = b * potencia b (p-1)

-- suma_pares n, que recibe un número par n y suma todos los números pares anteriores a n, incluyendo
-- a n.
suma_pares :: Int -> Int
suma_pares 0 = 0
suma_pares n = if mod n 2 == 0 then n + suma_pares (n-1) else suma_pares (n-1)

-- Escribe la función triangular n, que recibe un entero regresa el n-ésimo número triangular, osease:
triangular :: Int -> Int
triangular 0 = 0
triangular n = n + triangular (n-1)

--fibo n, que recibe un entero n y devuelve el número correspondiente al lugar n de la sucesión de
--Fibonacci.
fibo :: Int -> Int
fibo 0 = 0
fibo n = if n == 1 then 1 else fibo (n-1) + fibo (n-2)

--ultimo lst, que recibe una lista y responde con el último elemento de la lista.
ultimo :: [a] -> a
ultimo [ ] = error "No hay elementos"
ultimo [x] = x
ultimo (x:xs) = ultimo xs

-- reversa lst, que recibe una lista y devuelve la misma lista al revés.
reversa :: [a] -> [a]
reversa [ ] = error "No hay elementos"
reversa [x] = [x]
reversa (x:xs) = reversa xs ++ [x]

--elemento elm lst, que recibe una lista lst de tipo [a] y elm un elemento de tipo a y responde si
--elm pertenece a lst.
elemento :: Eq a => a -> [a] -> Bool
elemento elm [ ] = False
elemento elm (x:xs) = if elm == x then True else elemento elm xs


data Categoria = Perfecto | Deficiente | Abundante

nicomaco :: Int -> Categoria
nicomaco 0 = Deficiente
nicomaco n = if suma_divisores n == n then Perfecto else if suma_divisores n < n then Deficiente else Abundante

suma_divisores :: Int -> Int
suma_divisores 0 = 0
suma_divisores n = if mod n 2 == 0 then n + suma_divisores (n-1) else suma_divisores (n-1)
  

luhnAuxDouble :: [Int] -> [Int]
luhnAuxDouble [] = []
luhnAuxDouble (x:xs) = if mod (length (x:xs)) 2 == 0 then x*2 : luhnAuxDouble xs else x : luhnAuxDouble xs


luhnAuxSum :: [Int] -> Int
luhnAuxSum [] = 0
luhnAuxSum (x:xs) = if x > 9 then x-9 + luhnAuxSum xs else x + luhnAuxSum xs


luhn :: [Int] -> Bool
luhn [] = error "No es válida"
luhn (x:xs) =   if mod (luhnAuxSum (luhnAuxDouble (x:xs))) 10 == 0 then True else False


collatz :: Int -> Int
collatz 1 = 1
collatz x = if mod x 2 == 0 && x >= 0 then 1 + collatz (div x 2) else 1 +collatz (3*x+1)

 
{- 
pasosCollatz n que recibe un número entero positivo y responde con el número de pasos que se
deben dar para convertir a n en 1.
 -}
pasosCollatz :: Int -> Int
pasosCollatz 1 = 0
pasosCollatz x = if mod x 2 == 0 && x >= 0 then 1 + pasosCollatz (div x 2) else 1 + pasosCollatz (3*x+1)


{- 
listaCollartz n que recibe un número entero positivo y responde con una lista con las transforma-
ciones que va sufriendo n hasta convertirse en 1.
 -}

listaCollatz :: Int -> [Int]
listaCollatz 1 = [1]
listaCollatz x = if mod x 2 == 0 && x >= 0 then x : listaCollatz (div x 2) else x : listaCollatz (3*x+1)




data EA = N Int | Positivo EA | Negativo EA | Suma EA EA  | 
        Resta EA EA | Mult EA EA | Div EA EA | Mod EA EA | Pot EA EA 


instance Show EA where      
    show (N x) = if x >= 0 then show x else "(" ++ show x ++ ")"
    show (Positivo (N(x))) = show x
    show (Negativo (N(x))) = show (-x)
    show (Suma x y) =  show x ++ " + " ++ show y
    show (Resta x y) = show x ++ " - " ++ show y
    show (Mult x y) = show x ++ " * " ++ show y
    show (Div x y) = show x ++ " / " ++ show y
    show (Mod x y) = show x ++ " % " ++ show y
    show (Pot x y) = show x ++ " ^ " ++ show y




creaSumaEA :: Int -> Int -> EA
creaSumaEA x y = Suma (N x) (N y)


creaRestaEA :: Int -> Int -> EA
creaRestaEA x y = Resta (N x) (N y)

creaMultEA :: Int -> Int -> EA
creaMultEA x y = Mult (N x) (N y)

creaDivEA :: Int -> Int -> EA
creaDivEA x y = Div (N x) (N y)

creaModEA :: Int -> Int -> EA
creaModEA x y = Mod (N x) (N y)

creaPotEA :: Int -> Int -> EA
creaPotEA x y = Pot (N x) (N y)

-- menorque :: EA -> EA -> Bool
-- menorque (N x) (N y) = x < y
-- menorque (N x) (Positivo y) = x < y
-- menorque (N x) (Negativo y) = x < y

-- mayorque :: EA -> EA -> Bool
-- mayorque (N x) (N y) = x > y
-- mayorque (N x) (Positivo (N y)) = x > y
-- mayorque (N x) (Negativo (N y)) = x > y


