# Polynomial

A class for building polynomial functions using `coefficients` and evaluating them at point `x`.

Example:

    polynomial = Polynomial.new([3, -2, -1, 5])
    puts polynomial.evaluate(3) #=> 65

find _f(3)_ for _f(x) = 3x<sup>3</sup> -2x<sup>2</sup>-x+5_